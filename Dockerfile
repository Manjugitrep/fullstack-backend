# Use official OpenJDK 17 image (lightweight)
FROM openjdk:17-jdk-slim AS build

# Set working directory
WORKDIR /app

# Copy Maven wrapper (if available) and pom.xml first for dependency caching
COPY pom.xml ./
COPY mvnw ./
COPY .mvn .mvn

# Download dependencies (cache layer)
RUN ./mvnw dependency:go-offline -B || apt-get update && apt-get install -y maven && mvn dependency:go-offline -B

# Copy the entire project
COPY . .

# Build the Spring Boot application
RUN ./mvnw clean package -DskipTests || mvn clean package -DskipTests



# ===========================
# Run Stage
# ===========================
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

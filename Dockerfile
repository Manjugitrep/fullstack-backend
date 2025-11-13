# ===============================
# BUILD STAGE
# ===============================
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

# Copy Maven Wrapper and main pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Download all dependencies (helps with caching)
RUN ./mvnw dependency:go-offline

# Copy source and build the JAR
COPY src src
RUN ./mvnw -DskipTests clean package

# ===============================
# RUN STAGE
# ===============================
FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

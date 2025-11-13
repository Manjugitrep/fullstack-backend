@ECHO OFF
SET JAVA_EXE=java
"%JAVA_EXE%" -cp ".mvn/wrapper/maven-wrapper.jar" org.apache.maven.wrapper.MavenWrapperMain %*

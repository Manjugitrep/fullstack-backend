#!/bin/sh
JAVA_EXE="java"
exec "$JAVA_EXE" -cp ".mvn/wrapper/maven-wrapper.jar" org.apache.maven.wrapper.MavenWrapperMain "$@"

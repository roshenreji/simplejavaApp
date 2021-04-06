FROM maven:3.5-jdk-8
COPY target/*.jar app.jar
ENTRYPOINT [ "java","-jar","app.jar" ]

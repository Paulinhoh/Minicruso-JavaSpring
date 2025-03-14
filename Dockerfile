FROM ubuntu:latest AS biuld

RUN apt-get update
RUN apt-get install openjdk-23-jdk -y

COPY . .

RUN apt-get install maven -y
RUN mvn clean install

FROM openjdk:23-slim

EXPOSE 8080

COPY --from=biuld /target/todolist-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]

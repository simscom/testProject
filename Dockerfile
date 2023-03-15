FROM openjdk:8-jdk
ARG WAR_FILE=build/libs/*.war
COPY ${WAR_FILE} app.war
ENV JAVA_OPTS=""
ENTRYPOINT ["java","-jar","/app.jar"]

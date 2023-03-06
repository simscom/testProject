FROM openjdk:8
EXPOSE 8081
ARG WAR_FILE=build/libs/*.war
COPY ${WAR_FILE} app.war
ENTRYPOINT ["java", "-jar", "/app.war"]
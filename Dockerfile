FROM openjdk:8-jdk
VOLUME /tmp
ADD ./build/libs/*.jar app.jar
ENV JAVA_OPTS=""
ENTRYPOINT ["java","-jar","/app.jar"]

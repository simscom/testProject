FROM openjdk:8-jdk
VOLUME /tmp
ADD ./build/libs/testpoject-0.0.1-SNAPSHOT.jar app.jar
ENV JAVA_OPTS=""
ENTRYPOINT ["java","-jar","/app.jar"]
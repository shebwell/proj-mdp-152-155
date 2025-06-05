
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y openjdk-11-jre

COPY target/your-app.jar /opt/app.jar

CMD ["java", "-jar", "/opt/app.jar"]

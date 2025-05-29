# Stage 1: Build the application with Maven
FROM maven:3.8.4-jdk-11 AS build
WORKDIR /app
COPY src /app/src
COPY pom.xml /app
RUN mvn clean package

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

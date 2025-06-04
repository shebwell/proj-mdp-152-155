# Stage 1: Build the application with Maven
FROM maven:3.8.4-jdk-11 AS build
WORKDIR /app

# Copy pom.xml first for better caching
COPY pom.xml /app

# Copy source code
COPY src /app/src

# Build the application
RUN mvn clean package --batch-mode

# Stage 2: Deploy to Tomcat
FROM tomcat:9.0

# Deploy WAR file to Tomcat's webapps directory
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose application port
EXPOSE 8080

# Run Tomcat server
CMD ["catalina.sh", "run"]

# Start with a base Java image
FROM openjdk:8-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the built jar file from Maven build to the container
COPY target/docker-ci-cd-1.0-SNAPSHOT.jar /app/app.jar

# Expose the application port
EXPOSE 8080

# Command to run the app
CMD ["java", "-jar", "/app/app.jar"]

# Stage 1: Build with Maven
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copy only essential files to leverage layer caching
COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Stage 2: Smaller runtime image
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Copy the built .jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Set entrypoint to run your app
ENTRYPOINT ["java", "-jar", "app.jar"]

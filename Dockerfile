# Stage 1: Build the app using Maven
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /ap
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create a smaller runtime image
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
 
WORKDIR /app
 
# Copy full source code
COPY . .
 
# Use system-installed Maven (not mvnw)
RUN mvn clean package -DskipTests
 
# ---------- Runtime Stage ----------
FROM eclipse-temurin:17-jdk-alpine
 
WORKDIR /app
 
COPY --from=build /app/target/*.jar app.jar
 
EXPOSE 8080
 
ENTRYPOINT ["java", "-jar", "app.jar"]
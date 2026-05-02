# Build stage
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Run stage
FROM openjdk:17.0.1-jdk-slim
# Yahan humne *.jar ki jagah specific name handle kiya hai
COPY --from=build /target/demo-0.0.1-SNAPSHOT.jar app.jar
# Render default port 10000 use karta hai, hum Spring ko batayenge
ENV PORT=10000
EXPOSE 10000
ENTRYPOINT ["java","-jar","app.jar","--server.port=10000"]

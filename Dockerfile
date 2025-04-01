FROM gradle:8.4-jdk21 AS build
WORKDIR /home/gradle/app
COPY . .
RUN ./gradlew build -x test

FROM openjdk:21
WORKDIR /app
COPY --from=build /home/gradle/app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
EXPOSE 8080

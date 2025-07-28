# Usa una imagen base de Java y Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .

# Construye el JAR
RUN mvn clean package -DskipTests

# Usa una imagen más liviana solo con Java para producción
FROM eclipse-temurin:17-jdk

WORKDIR /app
COPY --from=build /app/target/gestion-empleados-backend-1.0.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]

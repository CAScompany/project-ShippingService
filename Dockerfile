FROM maven:3.8.4-openjdk-11 AS BUILD_IMAGE
WORKDIR /build
COPY ./shipping-service-example/pom.xml ./pom.xml
RUN mvn dependency:go-offline
COPY ./shipping-service-example ./ 
RUN mvn package -DskipTests

FROM openjdk:11-jdk-slim
LABEL "Project"="Shipping service"
LABEL "Author"="Carlos"
WORKDIR /app
COPY --from=BUILD_IMAGE /build/target/shipping-service-example-0.0.1-SNAPSHOT.jar /app/shipping-service.jar
EXPOSE 8080
CMD ["java","-jar", "/app/shipping-service.jar"]



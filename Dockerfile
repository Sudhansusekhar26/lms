# Stage 1: Build the application using Maven
FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /app

# Cache dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build executable WAR
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime environment
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# Create a non-root group and user for security
RUN addgroup --system lmsgroup && adduser --system --ingroup lmsgroup lmsuser

# Copy the built WAR from the builder stage
COPY --from=builder /app/target/lms-0.0.1-SNAPSHOT.war app.war

# Set ownership
RUN chown lmsuser:lmsgroup app.war

USER lmsuser

# Port default
EXPOSE 8081

# JVM flags for containers
ENV JAVA_OPTS="-Xms256m -Xmx512m -XX:+UseG1GC -Djava.net.preferIPv4Stack=true"

# Run the Spring Boot executable WAR
ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar app.war"]

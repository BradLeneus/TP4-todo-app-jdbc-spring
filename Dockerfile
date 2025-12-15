# Stage 1: Build avec Maven
FROM maven:3.9.9-eclipse-temurin-23 AS build  
WORKDIR /app

# Copier uniquement le pom.xml du backend (dans src/api)
COPY src/api/pom.xml .

# Télécharger les dépendances
RUN mvn dependency:go-offline

# Copier le code source du backend
COPY src/api/src ./src

# Compiler l'application (sans lancer les tests)
RUN mvn clean package -DskipTests

# Stage 2: Exécution finale
FROM eclipse-temurin:23-jre-alpine  
WORKDIR /app

# Copier le JAR compilé depuis l'étape de build
COPY --from=build /app/target/*.jar /app/app.jar

# Variables d'environnement par défaut pour la base de données
ENV DB_HOST=mariadb
ENV DB_PORT=3306
ENV DB_USER=root
ENV DB_PASSWORD=password

# Exposer le port du backend
EXPOSE 8080

# Commande de démarrage
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

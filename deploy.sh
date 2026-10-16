#!/bin/bash
# One-click Ubuntu Deployment Script for LMS
set -e

echo "=== 1. Updating system and installing OpenJDK 17 and MySQL ==="
sudo apt-get update -y
sudo apt-get install -y openjdk-17-jdk mysql-server

echo "=== 2. Setting up MySQL database ==="
sudo systemctl start mysql
sudo systemctl enable mysql

sudo mysql -e "CREATE DATABASE IF NOT EXISTS lms CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER IF NOT EXISTS 'lmsuser'@'localhost' IDENTIFIED BY 'LmsPassword123!';"
sudo mysql -e "GRANT ALL PRIVILEGES ON lms.* TO 'lmsuser'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

echo "=== 3. Setting up LMS Application Service ==="
sudo mkdir -p /opt/lms
if [ -f "lms-0.0.1-SNAPSHOT.war" ]; then
    sudo cp lms-0.0.1-SNAPSHOT.war /opt/lms/lms.war
elif [ -f "target/lms-0.0.1-SNAPSHOT.war" ]; then
    sudo cp target/lms-0.0.1-SNAPSHOT.war /opt/lms/lms.war
fi

# Create systemd service
sudo bash -c 'cat <<EOF > /etc/systemd/system/lms.service
[Unit]
Description=LMS Spring Boot Application
After=syslog.target network.target mysql.service

[Service]
User=root
WorkingDirectory=/opt/lms
ExecStart=/usr/bin/java -Xms256m -Xmx512m -jar /opt/lms/lms.war \
    --server.port=80 \
    --spring.datasource.url=jdbc:mysql://localhost:3306/lms?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC \
    --spring.datasource.username=lmsuser \
    --spring.datasource.password=LmsPassword123!
SuccessExitStatus=143
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF'

echo "=== 4. Starting LMS Service ==="
sudo systemctl daemon-reload
sudo systemctl enable lms
sudo systemctl restart lms

echo "=========================================================="
echo "Deployment Complete! Your LMS is live on Port 80 (HTTP)."
echo "Open your browser and visit: http://$(curl -s ifconfig.me)"
echo "=========================================================="

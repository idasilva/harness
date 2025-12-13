#!/bin/bash
# deploy-to-tomcat.sh

echo "Building WAR..."
mvn clean package -q

echo "Deploying to Tomcat..."

# Detect Tomcat location
if [ -d "/opt/homebrew/opt/tomcat/libexec" ]; then
    TOMCAT="/opt/homebrew/opt/tomcat/libexec"
elif [ -d "/usr/local/opt/tomcat/libexec" ]; then
    TOMCAT="/usr/local/opt/tomcat/libexec"
else
    TOMCAT="/usr/local/tomcat"
fi

# Remove old deployment
rm -rf $TOMCAT/webapps/merry*

# Deploy new WAR
cp target/merry.war $TOMCAT/webapps/

echo "✓ Deployed!"
echo "Access: http://localhost:8080/merry"

# Wait for deployment
sleep 3
open http://localhost:8080/merry/
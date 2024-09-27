#!/bin/bash

# Prepare environment, install all tools
sudo dnf update -y

echo "Installing node.js, npm, curl, wget and net-tools"

# Install Node.js from NodeSource
curl -sL https://rpm.nodesource.com/setup_18.x | sudo bash -
sudo dnf install -y nodejs curl wget net-tools
sleep 15
echo ""
echo "################"
echo ""

# Read user input for log directory
echo -n "Set log directory location for the application (absolute path): "
read LOG_DIRECTORY
if [ -d "$LOG_DIRECTORY" ]; then
  echo "$LOG_DIRECTORY already exists"
else
  mkdir -p "$LOG_DIRECTORY"
  echo "A new directory $LOG_DIRECTORY has been created"
fi

# Display NodeJS version
node_version=$(node --version)
echo "NodeJS version $node_version installed"

# Display npm version
npm_version=$(npm --version)
echo "NPM version $npm_version installed"

echo ""
echo "################"
echo ""

# Fetch NodeJS project archive from s3 bucket
wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz

# Extract the project archive to ./package folder
tar zxvf ./bootcamp-node-envvars-project-1.0.0.tgz

# Change to package directory
cd package || { echo "Failed to change directory to 'package'"; exit 1; }

# Initialize the NodeJS project (if not already initialized)
if [ ! -f package.json ]; then
  echo "Initializing npm project"
  npm init -y
fi

# Install application dependencies
npm install

# Run npm audit fix to resolve vulnerabilities
npm audit fix --force

# Set all needed environment variables
export APP_ENV=dev
export DB_PWD=mysecret
export DB_USER=myuser 
export LOG_DIR=$LOG_DIRECTORY

# Start the NodeJS application in the background
node server.js &

# Wait for the app to start and give a buffer time
sleep 5

# Display that NodeJS process is running
ps aux | grep node | grep -v grep

# Display that NodeJS is running on port 3000
netstat -ltnp | grep :3000

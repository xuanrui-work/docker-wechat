#!/bin/bash

# Configurations
WECHAT_DATA_DIR=$(pwd)/wechat-data    # data directory
DISPLAY=$DISPLAY

# Configure the environment variables
cat <<EOF > .env
UID=$(id -u)
GID=$(id -g)
DISPLAY=$DISPLAY
WECHAT_DATA_DIR=$WECHAT_DATA_DIR
EOF

# Set the permissions of the data directory
mkdir -p $WECHAT_DATA_DIR
chmod +rw $WECHAT_DATA_DIR

# Build the docker image
docker compose build

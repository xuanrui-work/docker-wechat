#!/bin/bash

# Configurations
WECHAT_DATA_DIR=$(pwd)/wechat-data    # data directory

# Build the docker image
docker compose build

# Configure the environment variables
cat <<EOF > .env
UID=$(id -u)
GID=$(id -g)
WECHAT_DATA_DIR=$WECHAT_DATA_DIR
EOF

# Set the permissions of the data directory
mkdir -p $WECHAT_DATA_DIR
chmod 777 $WECHAT_DATA_DIR

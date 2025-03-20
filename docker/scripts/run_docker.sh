#!/bin/bash

CONTAINER_NAME="sample_container"
IMAGE_NAME="docker-sample:latest"


# Dockerコンテナを起動
echo "Starting Docker container with the following settings:"
echo "Container Name: $CONTAINER_NAME"
echo "Image Name: $IMAGE_NAME"


# コンテナを実行
docker run -it --rm --name "$CONTAINER_NAME" \
    --privileged \
    --network host \
    --device=/dev/can0:/dev/can0\
    --volume /dev/input:/dev/input \
    "$IMAGE_NAME"
   
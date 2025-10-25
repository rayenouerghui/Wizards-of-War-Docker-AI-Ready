#!/bin/bash
set -e
IMAGE_NAME=my-game-server
CONTAINER_NAME=game_container

docker build -t ${IMAGE_NAME} .
docker stop ${CONTAINER_NAME} || true
docker rm ${CONTAINER_NAME} || true
docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}
# Give the container a moment to start
sleep 5
# Run binary health check if available
if ! docker exec ${CONTAINER_NAME} ./game_server --health >/dev/null 2>&1; then
    echo "Health check failed, restarting..."
    docker stop ${CONTAINER_NAME} || true
    docker rm ${CONTAINER_NAME} || true
    docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}
fi

echo "Deployed ${IMAGE_NAME} as ${CONTAINER_NAME}"

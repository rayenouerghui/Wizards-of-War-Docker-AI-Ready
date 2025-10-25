#!/bin/bash
# Simple integration test: builds, runs, then queries health endpoint (if provided)
set -e
IMAGE_NAME=my-game-server
CONTAINER_NAME=game_container

docker stop ${CONTAINER_NAME} || true
docker rm ${CONTAINER_NAME} || true

docker build -t ${IMAGE_NAME} .
docker run -d --name ${CONTAINER_NAME} -p 8080:8080 ${IMAGE_NAME}
sleep 5
# If the binary exposes a /health HTTP endpoint, test it; otherwise try the --health flag
if curl -s http://localhost:8080/health | grep -q "OK"; then
    echo "Test passed (HTTP health)"
else
    if docker exec ${CONTAINER_NAME} ./game_server --health >/dev/null 2>&1; then
        echo "Test passed (binary health flag)"
    else
        echo "Test failed"
        docker logs ${CONTAINER_NAME} || true
        docker stop ${CONTAINER_NAME} || true
        docker rm ${CONTAINER_NAME} || true
        exit 1
    fi
fi

docker stop ${CONTAINER_NAME} || true
docker rm ${CONTAINER_NAME} || true

echo "Test completed"

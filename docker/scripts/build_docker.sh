#!/bin/bash
####################################################
# 手動でDocker buildをするためのスクリプト
# Script for manually performing a Docker build
####################################################

set -e

# 変数定義
TIMESTAMP=$(date +%Y%m%d%H%M%S)
IMAGE_NAME="docker-sample"
TAG1="${IMAGE_NAME}:latest"
TAG2="${IMAGE_NAME}:${TIMESTAMP}"

# 現在の作業ディレクトリを取得して変数に代入
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PROJECT_DIR="${SCRIPT_DIR}/../.."
DOCKERFILE="${PROJECT_DIR}/docker/Dockerfile"


cd ${PROJECT_DIR}

DOCKER_BUILDKIT=1
# Dockerイメージのビルド
echo "Building Docker image: ${IMAGE_NAME}..." 
echo "Project Directry: ${PROJECT_DIR} ..." 


docker build  \
    --no-cache \
    -t "${TAG1}" \
    -f "${DOCKERFILE}" \
    .

# ビルド完了メッセージ
echo "Docker image '${IMAGE_NAME}' has been built successfully."
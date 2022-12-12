#!/bin/bash

BASE_DIR=$(dirname $0)
BUILD_SCRIPT_NAME="build-git.sh"
BUILD_SCRIPT="${BASE_DIR}/${BUILD_SCRIPT_NAME}"
TOOLCHAIN="/share/Public/toolchain"

if [ ! -d ${TOOLCHAIN}  ]; then
    mkdir ${TOOLCHAIN}    
fi

if [ -z "$(docker ps -a | grep 'tc-builder')" ]; then
docker run \
--privileged \
--net="host" \
-e TERM=$TERM \
-u root \
-v ${TOOLCHAIN}:${TOOLCHAIN} \
--name=tc-builder \
-dit arm64v8/ubuntu:16.04 /bin/bash
fi

docker start tc-builder
docker cp ${BUILD_SCRIPT} tc-builder:/root/${BUILD_SCRIPT_NAME}
docker exec -t tc-builder /bin/bash /root/${BUILD_SCRIPT_NAME}

if [ -z "$(cat /etc/profile | grep '${TOOLCHAIN}')" ]; then
    echo "PATH=${TOOLCHAIN}/bin:\$PATH" >> /etc/profile
fi

docker stop tc-builder
docker rm tc-builder

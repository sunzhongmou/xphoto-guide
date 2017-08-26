#!/usr/bin/env bash

set -e

docker stop xphoto_guide || true
docker rm xphoto_guide || true
docker run --name xphoto_guide -it -p 3066:4000 -v $(pwd):/srv/gitbook fellah/gitbook


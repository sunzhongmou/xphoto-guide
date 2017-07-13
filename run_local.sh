#!/usr/bin/env bash

set -e

docker stop xphoto_guide || true
docker rm xphoto_guide || true
docker run --name xphoto_guide -itd -p 3066:4000 -v /Users/wwsun/Sunzhongmou/xphoto-guide:/srv/gitbook fellah/gitbook


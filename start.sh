#!/bin/bash
if [ ! -d config/.mozilla ]; then
  mkdir config/.mozilla
fi
PORT=$((RANDOM%40000+1025))
PORT=2224
echo starting on port $PORT
CONTAINER=$(docker run -d  -p 127.0.0.1:$PORT:22 \
       -v `pwd`/config/.mozilla:/home/surfer/.mozilla \
       reto/firefox)
ssh -X -R64713:localhost:4713 -X surfer@127.0.0.1 -p $PORT firefox
docker stop $CONTAINER

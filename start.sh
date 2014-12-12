docker run -ti --rm \
       -e DISPLAY=$DISPLAY \
       -v `pwd`/config/.mozilla:/home/surfer/.mozilla \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       reto/firefox

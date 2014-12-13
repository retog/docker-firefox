FROM ubuntu:14.10
# Based on http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/, by Fabio Rehm "fgrehm@gmail.com"


RUN apt-get update && apt-get install -y firefox software-properties-common 
RUN apt-add-repository multiverse && apt-get update && apt-get install -y flashplugin-installer

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/surfer && \
    echo "surfer:x:${uid}:${gid}:surfer,,,:/home/surfer:/bin/bash" >> /etc/passwd && \
    echo "surfer:x:${uid}:" >> /etc/group && \
    echo "surfer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/surfer && \
    chmod 0440 /etc/sudoers.d/surfer && \
    chown ${uid}:${gid} -R /home/surfer

USER surfer

ENV HOME /home/surfer
WORKDIR /home/surfer
CMD /usr/bin/firefox -no-remote

#!/bin/bash
# Script used to startup all of the local services run on my PC



portainer(){
    docker run -d -p 127.0.0.1:8000:8000 -p 127.0.0.1:9443:9443 \
    --name portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /home/zek/Docker-Data/Portainer:/data \
    --privileged \
    portainer/portainer-ce:latest ;
}

immich(){
    docker compose -f ./immich/docker-compose.yml up
}

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)


read -p "Start Portainer?(y/n): " START_PORTAINER

if [ "$START_PORTAINER" = "y" ]; then
    portainer;

else
    docker stop portainer
fi

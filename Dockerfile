FROM node:19.5.0-alpine as base

RUN sudo apt-get update; \
    sudo apt-get -y upgrade; \
    sudo apt-get install -y gnupg2 wget lsb_release 
# USER root
WORKDIR /webapps
# COPY package*.json ./
COPY . . 
RUN npm install
# ADD . /webapps  
CMD [ "node","server.js" ]
# CMD node server.js


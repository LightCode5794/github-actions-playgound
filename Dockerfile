FROM node:19.5.0-alpine as base

# USER root
WORKDIR /webapps
# COPY package*.json ./
COPY . . 
RUN npm install
# ADD . /webapps  
CMD [ "node","server.js" ]
# CMD node server.js


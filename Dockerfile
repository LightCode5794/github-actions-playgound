FROM node:19.5.0-alpine as base


WORKDIR /webapps
COPY package*.json ./
RUN npm install
COPY . /webapps

CMD [ "node","server.js" ]
# CMD node server.js


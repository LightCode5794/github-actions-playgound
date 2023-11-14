FROM node:16-alpine as base

USER root
WORKDIR /webapps
COPY package*.json ./
RUN npm install
COPY . /webapps


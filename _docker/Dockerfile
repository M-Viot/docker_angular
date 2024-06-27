FROM node:lts-slim

RUN npm install -g @angular/cli
RUN apt-get update
RUN apt-get install -y git

RUN git config --global user.email "contact@mathieuviot.fr"
RUN git config --global user.name "Mathieu"
RUN git config --global --add safe.directory /angular-app


WORKDIR /
RUN mkdir angular-app
WORKDIR /angular-app

EXPOSE 4200
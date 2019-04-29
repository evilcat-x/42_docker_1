FROM node:12

# cuz yarn comes preinstalled now ....
RUN npm install -g create-react-app
RUN mkdir -p /usr/src/app
WORKDIR /usr/src
RUN npx create-react-app app
WORKDIR /usr/src/app
EXPOSE 3000

ENTRYPOINT [ "npm", "start" ]

ARG REPOSITORY=
ARG IMAGE=node
ARG TAG=20.11.0-alpine

FROM $REPOSITORY$IMAGE:$TAG

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 8081

CMD ["npm", "start"]
FROM node:current-alpine

RUN mkdir -p /etc/tls/certs

WORKDIR /webhook

RUN mkdir -p /app

COPY package*.json / 

RUN npm i

COPY app /app

EXPOSE 4443

CMD ["npm", "start"]
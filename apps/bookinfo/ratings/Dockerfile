FROM node:14.17.5-alpine3.14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

EXPOSE 9080
CMD ["npm", "run", "start-server"]
FROM node:14.17.5-alpine3.14

# Create app directory
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 9080
CMD ["npm", "run", "start-server"]
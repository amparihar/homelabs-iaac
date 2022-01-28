FROM node:12.13.0-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

FROM gcr.io/distroless/nodejs:12
COPY --from=build /app /app
WORKDIR /app

EXPOSE 9001

CMD ["npm", "run", "start-server"]

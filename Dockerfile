FROM node:alpine

EXPOSE 3000

WORKDIR /app

COPY . .
RUN npm install --quiet

ENTRYPOINT [ "npm", "start" ]

FROM node:6-alpine
# replace this with your application's default port
EXPOSE 3000

COPY . .

RUN npm install && yarn build

CMD ["yarn", "start"]

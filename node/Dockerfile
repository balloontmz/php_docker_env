FROM node:latest

RUN mkdir -p /home/www/node
WORKDIR /home/node
WORKDIR /home/php

RUN npm install

EXPOSE 3000

ENTRYPOINT ["npm", "run"]
CMD ["start"]

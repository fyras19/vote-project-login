FROM node:18-slim
WORKDIR /usr/local/app
COPY . .
RUN npm i -g nodemon && \
    npm ci && \
    npm cache clean --force && \
    mv /usr/local/app/node_modules /node_modules
ENV PORT=4000
CMD [ "node", "server.js" ]
EXPOSE 4000
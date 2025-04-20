FROM node:18
WORKDIR /app
COPY backend/helloService/ .
RUN npm install
EXPOSE 3001
CMD ["node", "index.js"]

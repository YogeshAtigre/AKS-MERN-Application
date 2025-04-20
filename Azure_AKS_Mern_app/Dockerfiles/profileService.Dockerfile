FROM node:18
WORKDIR /app
COPY backend/profileService/ .
RUN npm install
EXPOSE 3002
CMD ["node", "index.js"]

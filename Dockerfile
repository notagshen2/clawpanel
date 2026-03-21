FROM node:22-slim

RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# RUN npm install -g @qingchencloud/openclaw-zh --registry https://registry.npmmirror.com

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build

EXPOSE 1420

CMD ["npm", "run", "serve"]

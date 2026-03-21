FROM node:22-slim AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:22-slim AS runtime

WORKDIR /app

COPY package.json ./
COPY openclaw-version-policy.json ./
COPY scripts/serve.js ./scripts/serve.js
COPY scripts/dev-api.js ./scripts/dev-api.js
COPY --from=builder /app/dist ./dist

EXPOSE 1420

CMD ["node", "scripts/serve.js"]

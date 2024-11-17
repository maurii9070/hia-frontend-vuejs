FROM bitnami/node:18 as build

WORKDIR /app

COPY . .

RUN npm install && npm run build

FROM caddy:latest

COPY Caddyfile /etc/caddy/Caddyfile

COPY --from=build /app/dist /app

EXPOSE 80

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile"]
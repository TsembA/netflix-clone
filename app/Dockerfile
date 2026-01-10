# -----------------------
# Builder stage
# -----------------------
    FROM node:20-alpine AS builder

    WORKDIR /app
    
    COPY package.json yarn.lock ./
    RUN yarn install --frozen-lockfile
    
    COPY . .
    RUN yarn build
    
    # -----------------------
    # Runtime stage
    # -----------------------
    FROM nginxinc/nginx-unprivileged:stable-alpine
    
    WORKDIR /usr/share/nginx/html
    
    # Copy SPA build
    COPY --from=builder /app/dist/ ./
    
    # Replace default nginx config
    COPY nginx.conf /etc/nginx/conf.d/default.conf
    
    EXPOSE 8080
    CMD ["nginx", "-g", "daemon off;"]
    
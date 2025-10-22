# Build stage
FROM node:18-alpine as build

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
# Accept Vite build-time variables so import.meta.env.VITE_* will be populated
ARG VITE_APIKEY
ARG VITE_AUTHDOMAIN
ARG VITE_PROJECTID
ARG VITE_STORAGEBUCKET
ARG VITE_MESSAGINGSENDERID
ARG VITE_APPID
ARG VITE_MEASUREMENTID

# Export them into build environment for Vite
ENV VITE_APIKEY=$VITE_APIKEY
ENV VITE_AUTHDOMAIN=$VITE_AUTHDOMAIN
ENV VITE_PROJECTID=$VITE_PROJECTID
ENV VITE_STORAGEBUCKET=$VITE_STORAGEBUCKET
ENV VITE_MESSAGINGSENDERID=$VITE_MESSAGINGSENDERID
ENV VITE_APPID=$VITE_APPID
ENV VITE_MEASUREMENTID=$VITE_MEASUREMENTID

RUN npm run build

# Production stage
FROM nginx:alpine

# Copy built application from build stage
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Ensure nginx runtime directories exist and are writable, then switch to nginx user
RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx \
  && chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html

# Do NOT set USER here — keep root so the official entrypoint can perform setup steps

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost || exit 1

CMD ["nginx", "-g", "daemon off;"]

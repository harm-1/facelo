# ================================== BUILDER ===================================
ARG NODE_IMAGE_VERSION=${NODE_IMAGE_VERSION}

FROM node:${NODE_IMAGE_VERSION} AS builder

RUN npm install -g @vue/cli @vue/cli-service-global

WORKDIR /app
COPY package*.json ./
RUN npm install

EXPOSE 8080

CMD [ "npm", "run", "serve" ]

# ================================= PRODUCTION =================================
FROM builder AS production

# ================================= DEVELOPMENT ================================
FROM builder AS development

#*********
# base stage
#**********
FROM node:lts-alpine3.19 AS base

WORKDIR /usr/application/frontendnextserver

# Copy package.json to /app
COPY package*.json ./


COPY . /usr/application/frontendnextserver

ENV NEXT_TELEMETRY_DISABLED 1
# Instal dependencies according to the lockfile
RUN --mount=type=cache,target=/usr/application/frontendnextserver/.npm \
    npm set cache /usr/application/frontendnextserver/.npm && \
    npm install



# exposing the port
EXPOSE 3000

# **********
# prod stage
# **********
FROM base AS prod

RUN npm run build

CMD ["npm", "start"]

RUN npm run postinstall



# **********
# dev stage
# **********
FROM base AS dev

RUN npm run postinstall

CMD ["npm", "run", "dev"]



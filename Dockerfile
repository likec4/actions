# Build Stage

FROM node:20-alpine as builder

WORKDIR /likec4-action

COPY package.json yarn.lock .yarnrc.yml /likec4-action/
COPY .yarn/releases/ .yarn/releases

RUN yarn install --immutable

ENV NODE_ENV=production

COPY src src
COPY tsconfig.json .

RUN yarn build

# Run Stage

FROM mcr.microsoft.com/playwright:v1.46.0-jammy AS runner

ARG LIKEC4_VER=1.7.4

ENV NODE_ENV=production

RUN npm install -g likec4@${LIKEC4_VER} \
    && apt-get update \
    && apt-get install -y graphviz \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /likec4-action/dist /likec4-action

ENTRYPOINT ["node", "/likec4-action/index.js"]

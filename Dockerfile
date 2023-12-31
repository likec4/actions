# Build Stage

FROM node:20.9-alpine as builder

WORKDIR /likec4-action

COPY package.json yarn.lock .yarnrc.yml /likec4-action/
COPY .yarn/releases/ .yarn/releases

RUN yarn install --immutable

ENV NODE_ENV=production

COPY src src
COPY tsconfig.json .

RUN yarn build

# Run Stage

FROM mcr.microsoft.com/playwright:v1.40.1-jammy AS runner

ARG LIKEC4_VER=0.52.0

ENV NODE_ENV=production

RUN npm install -g likec4@${LIKEC4_VER}

COPY --from=builder /likec4-action/dist /likec4-action

ENTRYPOINT ["node", "/likec4-action/index.js"]

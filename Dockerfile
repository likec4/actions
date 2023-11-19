# Build Stage

FROM node:20.9-alpine as builder

WORKDIR /likec4-action

COPY package.json yarn.lock .yarnrc.yml .
COPY .yarn/releases/ .yarn/releases

RUN yarn install --immutable

COPY src src
COPY tsconfig.json .

RUN npm install --ignore-scripts
RUN npm run build

# Run Stage

FROM mcr.microsoft.com/playwright:v1.40.0-jammy AS runner
# Check available tags: https://mcr.microsoft.com/en-us/product/playwright/tags

ARG LIKEC4_VER=latest

ENV NODE_ENV=production

# RUN ln -s /likec4-action/dist/bin.js /usr/local/bin/lost-pixel
# RUN chmod +x /usr/local/bin/lost-pixel
RUN npm install -g likec4@${LIKEC4_VER}

COPY --from=builder /likec4-action/dist /likec4-action

ENTRYPOINT ["node", "/likec4-action/index.js"]

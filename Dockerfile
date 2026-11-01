FROM node:22 AS build

WORKDIR /react-app

# Use Yarn Classic
RUN corepack enable && corepack prepare yarn@1.22.22 --activate

RUN yarn --version
RUN node --version

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

FROM nginx:alpine

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=build /react-app/build /usr/share/nginx/html


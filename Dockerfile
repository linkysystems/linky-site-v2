FROM klakegg/hugo:alpine AS base

ENV HUGO_ENV="production"

COPY . /src

RUN hugo -D

FROM nginx:1.19.0-alpine AS release

COPY --chown=0:0 --from=base /src/public /usr/share/nginx/html
COPY --chown=0:0 --from=base /src/_infra/nginx/default.conf /etc/nginx/conf.d/default.conf

FROM ruby:2.4.0-alpine

ENV RACK_ENV development
ENV APP_ROOT /app

COPY app $APP_ROOT
WORKDIR $APP_ROOT

RUN apk --no-cache add \
      jq \
      python && \
    apk --no-cache add --virtual=build-dependencies \
      build-base \
      curl-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev \
      python-dev \
      py-pip && \
    pip install awscli && \
    bundle install -j4 --path vendor/bundler && \
    apk del --purge build-dependencies

ENTRYPOINT [ "./start.sh" ]

CMD [ "bundle", "exec", "ruby", "app.rb", "-p", "80", "-o", "0.0.0.0" ]

EXPOSE 80

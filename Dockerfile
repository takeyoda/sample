FROM ruby:2.4.0-alpine

ENV APP_ROOT /app

RUN apk --no-cache add jq py-pip python && pip install awscli && apk del --purge py-pip

COPY app $APP_ROOT
WORKDIR $APP_ROOT
RUN bundle install --path vendor/bundler

ENTRYPOINT [ "./start.sh" ]

CMD [ "bundle", "exec", "ruby", "hello.rb", "-e", "production" ]

EXPOSE 4567

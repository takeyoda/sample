FROM ruby:2.4.0-alpine

ENV APP_ROOT /app

COPY app $APP_ROOT
WORKDIR $APP_ROOT
RUN bundle install --path vendor/bundler

# CMD [ "bundle", "exec", "ruby", "hello.rb", "-o", "0.0.0.0" ]
CMD [ "bundle", "exec", "ruby", "hello.rb", "-e", "production" ]

EXPOSE 4567

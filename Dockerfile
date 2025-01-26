FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /credit-simulator-api
WORKDIR /credit-simulator-api

COPY Gemfile /credit-simulator-api/Gemfile
COPY Gemfile.lock /credit-simulator-api/Gemfile.lock
RUN bundle install

COPY . /credit-simulator-api

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
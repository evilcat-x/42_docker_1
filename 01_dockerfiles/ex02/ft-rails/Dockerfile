FROM ruby

RUN apt-get update && apt-get -y upgrade && apt-get install -y nodejs postgresql-client sqlite3
RUN gem install rail
RUN mkdir /blog
WORKDIR /blog
COPY blog/Gemfile /blog/Gemfile
COPY blog/Gemfile.lock /blog/Gemfile.lock
RUN bundle install
COPY blog /blog


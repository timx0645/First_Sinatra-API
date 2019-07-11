FROM ruby:2.5.3-stretch
RUN gem install bundler
RUN gem install sinatra
RUN gem install mongoid
RUN bundle config --global frozen 1
WORKDIR /Workdir
COPY . /
ADD server.rb server.rb
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD mongoid.config mongoid.config
RUN bundle install --without development test
COPY . .
CMD bundle exec rackup --host 0.0.0.0 -p $PORT

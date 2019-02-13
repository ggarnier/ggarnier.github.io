FROM ruby:latest

ADD .
RUN gem install bundler && bundle install

EXPOSE 4000
CMD ["jekyll", "serve", "-H", "0.0.0.0"]

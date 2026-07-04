FROM ruby:3.4

RUN apt-get update -qq && apt-get install -y \
build-essential \
libpq-dev \
nodejs \
git

WORKDIR /rails

COPY backend/Gemfile backend/Gemfile.lock ./

RUN bundle install

COPY backend .

EXPOSE 3000

CMD ["bash","-c","rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]
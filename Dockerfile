# FROM ruby:3.3.0

# WORKDIR /opt/app
# COPY . .
# RUN bundle install

# # RUN rake db:setup

# EXPOSE 3000

# CMD ["rails", "s", "-b", "0.0.0.0"]

# Make sure it matches the Ruby version in .ruby-version and Gemfile

FROM ruby:3.3.0

WORKDIR /rails

ENV RAILS_LOG_TO_STDOUT="1" \
    # RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development"

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec bootsnap precompile --gemfile app/ lib/

# RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]
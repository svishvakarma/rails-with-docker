FROM ruby:3.2.2
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -yq && apt-get install -yq --no-install-recommends \
  nodejs \
  yarn
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /rails_with_docker 
RUN gem install bundler -v 2.4.12
WORKDIR /rails_with_docker
ENV BUNDLER_VERSION 2.4.12
COPY Gemfile /rails_with_docker/Gemfile
COPY Gemfile.lock /rails_with_docker/Gemfile.lock
RUN bundle install
ENTRYPOINT [ "/bin/bash" ]
RUN bundle exec rails assets:precompile
EXPOSE 3000
CMD ["env", "rails", "server", "-b", "0.0.0.0"]




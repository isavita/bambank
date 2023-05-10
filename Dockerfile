# Start from the official ruby image
FROM ruby:3.2.2

# Install necessary Linux packages
RUN apt-get update -qq && apt-get install -y curl postgresql-client
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash - \
    && apt-get install -y nodejs

# Set an environment
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn

# Set an environment variable to store where the app is installed to inside of the Docker image
ENV RAILS_ROOT /var/www/app
RUN mkdir -p $RAILS_ROOT 

# Set working directory
WORKDIR $RAILS_ROOT

# Setting env variables not to install documentations for each gem locally
ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile* ./

# Install gems
RUN bundle check || bundle install

# Copy the application code into the image
COPY . .

# Precompile Rails assets
RUN bundle exec rake assets:precompile

# Start puma
CMD bundle exec puma -C config/puma.rb

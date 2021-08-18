FROM ruby:2.0.0-p648

# So we can use HTTPS in APT.  Without this ths below Postgres install
# will fail because it only serves packages using HTTPS.
#
#  https://unix.stackexchange.com/questions/263801/apt-get-fails-the-method-driver-usr-lib-apt-methods-https-could-not-be-found
#
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates

# So we can install Postgres 9.6.  Make sure to use the archived
# APT repository as the Jessie Postgres packages have been moved there.
# You will likely have to switch back to the regular Postgres archive
# when upgrading to a newer version of Ruby Docker image that does not
# use Debian Jessie.
#
#  https://www.postgresql.org/about/news/old-distributions-moving-to-apt-archivepostgresqlorg-jessie-wheezy-eoan-disco-trusty-precise-2159/
#
RUN touch /etc/apt/sources.list.d/pgdg.list
RUN echo 'deb https://apt-archive.postgresql.org/pub/repos/apt/ jessie-pgdg main' >> /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Build essentials is included in the base image.
# Boost is used to build CILA.
# Graphviz is used to created ERDs.
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    imagemagick \
    nodejs \
    sqlite3 \
    libsqlite3-dev

# Direcotry for the app.
RUN mkdir -p /spree_app
WORKDIR /spree_app

# Install the latest version of rubygems and bunlder that work
# with Ruby 2.0.
RUN gem install rubygems-update -v 2.7.10
RUN update_rubygems
RUN gem install bundler -v 1.17.3

# Add the code.
COPY . .


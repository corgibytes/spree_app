#!/usr/bin/env bash

# Install the gems in the entrypoint so they are added to
# the containers volume.
bundle check || bundle install && bundle clean --force

# So the server does not think it is still running.
rm -f tmp/pids/server.pid

exec "$@"

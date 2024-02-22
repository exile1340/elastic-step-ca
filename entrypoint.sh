#!/bin/bash

# Save environment variables to a file without the HOME variable
printenv | grep -v '^HOME=' > /etc/environment

# Start cron as root
cron

# Drop privileges and start Elasticsearch
exec gosu elasticsearch /usr/local/bin/docker-entrypoint.sh elasticsearch
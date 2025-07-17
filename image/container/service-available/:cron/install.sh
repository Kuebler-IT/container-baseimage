#!/bin/sh -e

chmod 600 /etc/crontab

# Fix https://github.com/phusion/baseimage-docker/issues/345
# sed -i 's/^\s*session\s\+required\s\+pam_loginuid.so/# &/' /etc/pam.d/cron

## Delete all predefined cron jobs from any package.
find /etc/cron.* -type f -not -name '.placeholder' -delete  || true

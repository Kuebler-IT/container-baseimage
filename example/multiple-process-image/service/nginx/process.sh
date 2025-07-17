#!/bin/bash -e

echo "The first start secret is: ${FIRST_START_SETUP_ONLY_SECRET:-'not available'}"
exec /usr/sbin/nginx -g "daemon off;"

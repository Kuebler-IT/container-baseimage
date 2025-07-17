# Use kueblerit/container-baseimage
# https://github.com/kuebler-it/container-baseimage
FROM kueblerit/container-baseimage:12.0.0

# Install multiple process stack, nginx and php8.2-fpm and clean apt-get files
# https://github.com/kuebler-it/container-baseimage/blob/stable/image/tool/add-multiple-process-stack
RUN apt-get -y update \
    && /container/tool/add-multiple-process-stack \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    nginx \
    php8.2-fpm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add service directory to /container/service
ADD service /container/service

# Use baseimage install-service script
# https://github.com/kuebler-it/container-baseimage/blob/stable/image/tool/install-service
RUN /container/tool/install-service

# Add default env directory
ADD environment /container/environment/99-default

# Set /var/www/ in a data volume
VOLUME /var/www/

# Expose default http and https ports
EXPOSE 80 443

# Use kueblerit/container-baseimage
# https://github.com/kuebler-it/container-baseimage
FROM kueblerit/container-baseimage:12.2.1

# Install multiple process stack, nginx and php8.2-fpm and clean apt-get files
# https://github.com/kuebler-it/container-baseimage/blob/stable/image/usr/lib/sbin/add-multiple-process-stack
RUN apt-get -y update \
    && add-multiple-process-stack \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    nginx=1.22* \
    php8.2-fpm=8.2* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add service directory to /container/service
COPY service /container/service

# Use baseimage install-service script
# https://github.com/kuebler-it/container-baseimage/blob/stable/image/usr/lib/sbin/install-service
RUN install-service

# Add default env directory
COPY environment /container/environment/99-default

# Set /var/www/ in a data volume
VOLUME /var/www/

# Expose default http and https ports
EXPOSE 80 443

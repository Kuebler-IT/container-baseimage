# Use kueblerit/container-baseimage
# https://github.com/kuebler-it/container-baseimage
FROM kueblerit/container-baseimage:12.2.1

# Download nginx from apt-get and clean apt-get files
RUN apt-get -y update \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    nginx=1.22* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add service directory to /container/service
COPY service /container/service

# Use baseimage install-service script
# https://github.com/kuebler-it/container-baseimage/blob/stable/image/usr/local/sbin/install-service
RUN install-service

# Add default env directory
COPY environment /container/environment/99-default

# Set /var/www/ in a data volume
VOLUME /var/www/

# Expose default http and https ports
EXPOSE 80 443

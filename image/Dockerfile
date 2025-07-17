FROM debian:bookworm-slim

COPY . /

RUN <<EOF
set -e
set -x

mkdir -p /container/service /container/environment /container/environment/startup
chmod 700 /container/environment/ /container/environment/startup

groupadd -g 8377 docker_env

# General config
export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive
MINIMAL_APT_GET_INSTALL='apt-get install -y --no-install-recommends'

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no
printf no > /container/environment/INITRD

apt-get update && apt-get upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold"

## TODO: check this issue should be fixed and not needed anymore.
## Comment out for now.
## Fix some issues with APT packages.
## See https://github.com/dotcloud/docker/issues/1024
#dpkg-divert --local --rename --add /sbin/initctl
#ln -sf /bin/true /sbin/initctl

## TODO: check this issue should be fixed and not needed anymore.
## Comment out for now.
## Replace the 'ischroot' tool to make it always return true.
## Prevent initscripts updates from breaking /dev/shm.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## https://bugs.launchpad.net/launchpad/+bug/974584
#dpkg-divert --local --rename --add /usr/bin/ischroot
#ln -sf /bin/true /usr/bin/ischroot

## Install apt-utils.
$MINIMAL_APT_GET_INSTALL apt-utils=2.6.1 apt-transport-https=2.6.1 ca-certificates=20230311* locales=2.36* procps=2:4.0.2* dirmngr=2.2.40* gnupg=2.2.40* iproute2=6.1.0* python3-minimal=3.11* python3-yaml=6.0*

# fix locale
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen en_US
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

printf en_US.UTF-8 > /container/environment/LANG
printf en_US.UTF-8 > /container/environment/LANGUAGE
printf en_US.UTF-8 > /container/environment/LC_CTYPE

apt-get clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*

# Remove useless files
rm -rf /container/build.sh /container/Dockerfile

EOF

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

ENTRYPOINT ["/usr/local/sbin/run"]

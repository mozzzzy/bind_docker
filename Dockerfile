# base image
FROM centos:7

#
# packages
#

RUN yum install -y bind bind-utils

#
# configuration files
#

# configure /etc/named.conf
ADD files/etc/named.conf /etc/named.conf
ADD files/var/named/dev.local.zone /var/named/dev.local.zone

#
# enable named
#

RUN systemctl enable named.service

#
# command to execute when run container
#

CMD ["/sbin/init"]

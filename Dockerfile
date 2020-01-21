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

#
# start named
#
RUN systemctl enable named.service

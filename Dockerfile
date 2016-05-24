FROM centos:6

MAINTAINER udomph "elep.ls@gmail.com"

ENV NGINX_VERSION 1.10.0-1

# Add Nginx repo
ADD nginx.repo /etc/yum.repos.d/nginx.repo
RUN rpm --import http://nginx.org/keys/nginx_signing.key

# Update 
#RUN yum -y update 

# Install Nginx
RUN yum -y install nginx

# Install utils
#RUN yum -y install net-tools

# Prepare nginx config
# Change log to /app/log
RUN sed -i 's/\/var\/log/\/app\/log/g'  /etc/nginx/nginx.conf
ADD default.conf /etc/nginx/conf.d/default.conf

# Clean up
RUN yum clean -y all
RUN chkconfig iptables off

# Listener port
EXPOSE 80 443

# Webroot and log directories
VOLUME ["/app/www","/app/log/nginx","/etc/ssl/nginx"]
ADD index.html /app/www/index.html

CMD ["nginx","-g","daemon off;"]

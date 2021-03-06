FROM debian:stretch
MAINTAINER PeGa! <dev@pega.sh>

ENV LANG C.UTF-8

RUN apt update && apt full-upgrade -y && apt install -y \
    python \
    subversion \
    libapache2-mod-svn \
    apache2 \
    apache2-utils \
    links \
    psmisc \
    wget \
    && apt-get clean

RUN a2enmod dav_svn
RUN a2enmod auth_digest
RUN a2enmod authz_svn
RUN a2dissite 000-default
# Clear files at /var/www, avoid display anything at that directory.
RUN rm -rf /var/www/*

RUN mkdir -p /var/lib/svn
RUN mkdir -p /etc/apache2/dav_svn

ADD files/update_dav_svn_conf.py /usr/local/bin/
ADD files/entrypoint.sh /usr/local/bin/
ADD files/subversion-daemon.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/*.sh

VOLUME /var/lib/svn
VOLUME /etc/apache2/dav_svn

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

FROM debian:buster-slim

RUN apt-get update && env DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y apache2 libapache2-mod-php davical

COPY calendar.conf /etc/apache2/sites-available
COPY container-log.conf /etc/apache2/conf-available

RUN a2dissite 000-default && \
    a2enmod rewrite && \
    a2enconf container-log && \
    a2ensite davical && \
    a2ensite calendar

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT /usr/local/bin/docker-entrypoint.sh

VOLUME /etc/davical

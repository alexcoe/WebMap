# WebMap
# -
# https://github.com/SabyasachiRana/WebMap
# Original Author: SabyasachiRana
# Updated by Kolor
# -
# Usage:
#   $ cd /opt
#   $ git clone https://github.com/alexcoe/WebMap.git
#   $ cd WebMap/docker
#   $ docker build -t webmap:latest .
#   $ docker run -d -v /opt/WebMap/docker/xml:/opt/xml -p 9191:9191 webmap:latest
#
# Nmap Example:
#   $ nmap -sT -A -oX /tmp/myscan.xml 192.168.1.0/24
#   $ mv /tmp/myscan.xml /opt/WebMap/docker/xml
#
# Now you can point your browser to http://localhost:9191

FROM alpine:latest
FROM python:3.9-alpine3.13
RUN apk add --no-cache py3-pip curl wkhtmltopdf libssl1.1 nmap tzdata
RUN apk add --no-cache --virtual .build-deps wget git

RUN mkdir /opt/xml && mkdir /opt/notes && \
    wget -P /opt/ https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
    cd /opt/ && tar -xvf /opt/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && rm wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

RUN pip3 install Django requests xmltodict && \
    cd /opt/ && django-admin startproject nmapdashboard && cd /opt/nmapdashboard && \
    git clone https://github.com/alexcoe/WebMap.git nmapreport && \
    cd nmapreport && git checkout master

RUN cp /opt/nmapdashboard/nmapreport/docker/settings.py /opt/nmapdashboard/nmapdashboard/
RUN cp /opt/nmapdashboard/nmapreport/docker/urls.py /opt/nmapdashboard/nmapdashboard/
RUN cp /opt/nmapdashboard/nmapreport/docker/tzdata.sh /root/tzdata.sh
RUN cp /opt/nmapdashboard/nmapreport/docker/startup.sh /startup.sh

RUN cd /opt/nmapdashboard && python3 manage.py migrate
RUN ln -s /opt/nmapdashboard/nmapreport/token.py /root/token
RUN chmod +x /root/token

RUN apk del .build-deps

EXPOSE 9191

ENTRYPOINT ["sh", "/startup.sh"]

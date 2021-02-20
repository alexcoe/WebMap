FROM alpine:latest
FROM python:3.6-alpine
FROM surnet/alpine-wkhtmltopdf:3.9-0.12.5-small as wkhtmltopdf
RUN apk add --no-cache \
    curl \
    libssl1.1 \
    libstdc++ \
    libx11 \
    libxrender \
    libxext \
    libssl1.1 \
    ca-certificates \
    fontconfig \
    freetype \
    ttf-dejavu \
    ttf-droid \
    ttf-freefont \
    ttf-liberation \
    ttf-ubuntu-font-family \
    nmap \
    nmap-scripts \
    tzdata && \
    apk add --no-cache --virtual .build-deps wget git msttcorefonts-installer py3-pip && \
    update-ms-fonts && \
    fc-cache -f && \
    mkdir /opt/xml && \
    mkdir /opt/notes && \
    pip3 install Django requests xmltodict && \
    cd /opt/ && \
    django-admin startproject nmapdashboard && \
    cd /opt/nmapdashboard && \
    git clone https://github.com/alexcoe/WebMap.git nmapreport && \
    cd nmapreport && \
    git checkout master && \
    cp /opt/nmapdashboard/nmapreport/docker/settings.py /opt/nmapdashboard/nmapdashboard/ && \
    cp /opt/nmapdashboard/nmapreport/docker/urls.py /opt/nmapdashboard/nmapdashboard/ && \
    cp /opt/nmapdashboard/nmapreport/docker/tzdata.sh /root/tzdata.sh && \
    cp /opt/nmapdashboard/nmapreport/docker/startup.sh /startup.sh && \
    cd /opt/nmapdashboard && \
    python3 manage.py migrate && \
    ln -s /opt/nmapdashboard/nmapreport/token.py /root/token && \
    chmod +x /root/token && \
    apk del --no-cache .build-deps && \
    rm -rf /tmp/*

COPY --from=surnet/alpine-wkhtmltopdf:3.9-0.12.5-small /bin/wkhtmltopdf /bin/wkhtmltopdf

EXPOSE 9191

ENTRYPOINT ["sh", "/startup.sh"]

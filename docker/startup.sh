#!/bin/sh

sh /opt/nmapdashboard/nmapreport/nmap/runcron.sh > /dev/null 2>&1 &
python3 /opt/nmapdashboard/manage.py runserver 0:9191

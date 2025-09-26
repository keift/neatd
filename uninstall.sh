#!/bin/bash

SERVICE_NAME="neatd"

sudo rm -rf /usr/local/bin/$SERVICE_NAME.sh

sudo rm -rf /etc/systemd/system/$SERVICE_NAME.*
sudo rm -rf /etc/systemd/system/timers.target.wants/$SERVICE_NAME.*
sudo rm -rf /var/lib/systemd/timers/$SERVICE_NAME.*

sudo systemctl daemon-reload
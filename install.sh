#!/bin/bash

SERVICE_NAME="neatd"

sudo tee /usr/local/bin/$SERVICE_NAME.sh &>/dev/null << EOF
#!/bin/bash

until ping -c 1 -W 1 1.1.1.1 &>/dev/null; do sleep 10; done

apt install -y curl
dnf install -y curl
yum install -y curl
zypper -n install curl
pacman -S --noconfirm curl

curl -fsSL https://raw.githubusercontent.com/keift/neatd/refs/heads/main/src/main.sh | sh
EOF

sudo chmod +x /usr/local/bin/$SERVICE_NAME.sh

sudo tee /etc/systemd/system/$SERVICE_NAME.service &>/dev/null << EOF
[Unit]
Description=Neatd Daily

[Service]
Type=oneshot
User=root
ExecStart=/usr/local/bin/$SERVICE_NAME.sh
EOF

sudo tee /etc/systemd/system/$SERVICE_NAME.timer &>/dev/null << EOF
[Unit]
Description=Neatd Daily

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
EOF

sudo systemctl daemon-reload

sudo systemctl enable $SERVICE_NAME.timer
sudo systemctl start $SERVICE_NAME.timer

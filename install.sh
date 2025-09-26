#!/bin/bash

SERVICE_NAME="neatd"

sudo tee /usr/local/bin/$SERVICE_NAME.sh > /dev/null << EOF
  #!/bin/bash

  apt install -y curl
  dnf install -y curl
  yum install -y curl
  pacman -S --noconfirm curl
  zypper install -y curl

  curl -fsSL https://raw.githubusercontent.com/keift/neatd/refs/heads/main/src/main.sh | sh
EOF

sudo chmod +x /usr/local/bin/$SERVICE_NAME.sh

sudo tee /etc/systemd/system/$SERVICE_NAME.service > /dev/null << EOF
  [Service]
  Type=oneshot
  ExecStart=/usr/local/bin/$SERVICE_NAME.sh
EOF

sudo tee /etc/systemd/system/$SERVICE_NAME.timer > /dev/null << EOF
  [Timer]
  OnCalendar=daily
  Persistent=true

  [Install]
  WantedBy=timers.target
EOF

sudo systemctl daemon-reload

sudo systemctl enable $SERVICE_NAME.timer
sudo systemctl start $SERVICE_NAME.timer
#!/bin/bash
set -euxo pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y python3 python3-pip python3-venv redis-server postgresql-client curl

systemctl enable redis-server
systemctl restart redis-server

install -d -o ${ssh_user} -g ${ssh_user} /home/${ssh_user}/Two-heartes
install -d -o ${ssh_user} -g ${ssh_user} /home/${ssh_user}/Two-heartes/uploads
install -d -o ${ssh_user} -g ${ssh_user} /home/${ssh_user}/Two-heartes/uploads/avatars

cat > /home/${ssh_user}/Two-heartes/.env <<EOF
DATABASE_URL=postgresql://${db_username}:${db_password}@${db_host}:5432/${db_name}
REDIS_URL=${redis_url}
JWT_SECRET_KEY=${jwt_secret_key}
JWT_EXPIRE_MINUTES=525600
AWS_ACCESS_KEY_ID=${aws_access_key_id}
AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}
AWS_S3_BUCKET=${bucket_name}
AWS_REGION=${aws_region}
SMTP_HOST=${smtp_host}
SMTP_PORT=${smtp_port}
SMTP_USER=${smtp_user}
SMTP_PASS=${smtp_pass}
SMTP_FROM=${smtp_from}
EOF

chown ${ssh_user}:${ssh_user} /home/${ssh_user}/Two-heartes/.env
chmod 600 /home/${ssh_user}/Two-heartes/.env

cat > /etc/systemd/system/movieapp.service <<EOF
[Unit]
Description=Movie App Backend
Wants=network-online.target
After=network-online.target redis-server.service

[Service]
User=${ssh_user}
WorkingDirectory=/home/${ssh_user}/Two-heartes
Environment="PATH=/home/${ssh_user}/Two-heartes/venv/bin"
EnvironmentFile=/home/${ssh_user}/Two-heartes/.env
ExecStart=/home/${ssh_user}/Two-heartes/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

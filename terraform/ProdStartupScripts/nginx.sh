#!/bin/bash

apt update
apt install -y nginx

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list

apt update
apt install -y elasticsearch kibana

systemctl daemon-reload
systemctl enable --now elasticsearch.service
systemctl enable --now kibana.service

cat << EOF > /etc/nginx/sites-available/default
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;

    # Main location which proxy's Kibana backend server
    location / {
        proxy_pass http://127.0.0.1:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;   
    }

    # Reverse proxy of assets and front end app
    location ~ (/app|/translations|/node_modules|/built_assets/|/bundles|/es_admin|/plugins|/api|/ui|/elasticsearch|/spaces/enter) {
            proxy_pass          http://127.0.0.1:5601;
            proxy_set_header    Host \$host;
            proxy_set_header    X-Real-IP \$remote_addr;
            proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header    X-Forwarded-Proto \$scheme;
            proxy_set_header    X-Forwarded-Host \$http_host;
            proxy_set_header    Authorization "";
            proxy_hide_header   Authorization;
    }
}
EOF

systemctl restart nginx
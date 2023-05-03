#!/bin/sh
echo "Quay Vlog Text"
read UnzipPass
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y --allowerasing docker-ce docker-ce-cli containerd.io
systemctl enable --now docker
firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --reload
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose



sudo yum install -y unzip
curl -L "https://github.com/vohuynhthanhtra/pr64/raw/main/proxy-v4-v6-vultr.zip" -o /root/proxy-v4-v6-vultr.zip
unzip -P ${UnzipPass} /root/proxy-v4-v6-vultr.zip -d /root/proxy-v4-v6-vultr
cd /root/proxy-v4-v6-vultr
docker-compose up -d
sudo yum update - y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bash_profile
nvm i v18
npm install --global pm2 yarn
yarn install
yarn prisma migrate dev
yarn prisma generate
cd build
pm2 start main.es.js
sleep 20
pm2 restart main.es.js
cd cronjob
pm2 start cron-update-vultr-account.es.js
pm2 start cron-setup-vultr-vps.es.js
pm2 start cron-setup-p.es.js
pm2 start cron-interval.es.js
pm2 start cron-ini-vultr-region.es.js
pm2 start cron-ini-vultr-plan.es.js
pm2 start cron-ini-vultr-os.es.js
pm2 save
pm2 startup
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --reload
echo "Done Setup"
REPO_DIR="/srv/web/ffbe"
REPO_NAME="ffbe"

# Install Nginx / Varnish
curl -s https://packagecloud.io/install/repositories/varnishcache/varnish60lts/script.deb.sh | sudo bash
apt-get install varnish nginx

# Varnish
service varnish stop

mv /etc/varnish/default.vcl /etc/varnish/default.vcl.org
ln -s $REPO_DIR/_prod/varnish.vcl /etc/varnish/default.vcl
ln -s $REPO_DIR/_prod/varnish.service /etc/systemd/system/varnish.service

# Nginx
ln -s $REPO_DIR/_prod/nginx.conf /etc/nginx/sites-enabled/$REPO_NAME

systemctl daemon-reload
service varnish start
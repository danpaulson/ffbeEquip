REPO_DIR="/srv/web/ffbe"

# Install Nginx / Varnish
apt-get install varnish nginx

# Varnish
service varnish stop

cp /etc/varnish/default.vcl /etc/varnish/default.vcl.org
ln -s $REPO_DIR/_prod/varnish.vcl /etc/varnish/default.vcl
ln -s $REPO_DIR/_prod/varnish.service /etc/systemd/system/varnish.service

systemctl daemon-reload
service varnish start
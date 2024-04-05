#!/usr/bin/env bash

# - check if Nginx is installed else install if not exists
check=$(which nginx)
if [ -z "$check" ]
then
	sudo apt install nginx
else
	echo "Already installed"
fi 

content="\
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>
"

# - Create Directories
sudo mkdir -p /data/web_static/ || cd /data/web_static || sudo mkdir releases shared current;
cd releases || mkdir test || echo "$content" > /data/web_static/releases/test/index.html

# - create a symbolic link from test to current

sudo ln -sf /data/web_static/releases/test /data/web_static/current

sudo chown -R ubuntu:ubuntu /data/

# sudo sed -i 's/root /var/www/html;/ alias /data/web_static/current/;/g' /etc/nginx/sites-enabled/default
# sudo sed -i '/listen 80 default_server/a location /hbnb_static { alias /data/web_static/current/;}' /etc/nginx/sites-enabled/default

sudo sed -i 's#root /var/www/html;#root /var/www/html;\n        location /hbnb_static/ {\n            alias /data/web_static/current/;\n        }#' /etc/nginx/sites-enabled/default

# - Restart Server
sudo service nginx restart


#!/usr/bin/env bash

#updates the server
sudo apt-get update -y
#install nginx
sudo apt-get install nginx -y

#Creates the folder if it doesn't exist and create a fake html file
mkdir -p /data/web_static/releases/test/
#Creates the folder if it doesn't exist
mkdir -p /data/web_static/shared/

#Create a fake HTML file to test the nginx configuration
echo "<!DOCTYPE html>
<html>
	<head>
	</head>
	<body>
	<h1> Holberton School</h1>
	</body>
</html> " | sudo tee /data/web_static/releases/test/index.html
#check if the symbolic link exists
if [ -L /data/web_static/current ]; then
	#remove the existing symbolic link
	rm /data/web_static/current
fi

#Creates the Symbolic link
ln -s /data/web_static/releases/test /data/web_static/current

#Giving ownership of the data folder to the ubuntu user AND group recursively
sudo Chown -r ubuntu:ubuntu /data/
sudo Chgrp -r ubuntu:ubuntu /data/

#Updating the nginxx configuration to serve the content of /data/web_static/current/ to hbnb_static

sudo tee -a /etc/nginx/sites-enabled/default <<EOF
location /hbnb_static/ {
	alias /data/web_static/current/;
}
EOF

#test the configuration
sudo nginx -t

#Restart the nginx
sudo service nginx restart

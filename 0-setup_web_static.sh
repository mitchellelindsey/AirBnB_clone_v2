#!/usr/bin/env bash

# Update package lists
sudo apt-get update -y

# Install Nginx if not already installed
if ! command -v nginx &>/dev/null; then
    sudo apt-get install -y nginx
fi

# Create required directories
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/

# Create index.html file
echo "<html>
<head>
</head>
<body>
<h1>Holberton School</h1>
</body>
</html>" | sudo tee /data/web_static/releases/test/index.html > /dev/null

# Create symbolic link for current release
sudo rm -f /data/web_static/current
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of /data/ folder to ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/

# Create Nginx configuration file
sudo tee /etc/nginx/sites-available/hbnb_static > /dev/null << 'EOF'
server {
    listen 80;
    root /var/www/html;
    index index.html;
    location /hbnb_static {
        alias /data/web_static/current;
    }
}
EOF

# Enable the new configuration and reload Nginx
sudo ln -sf /etc/nginx/sites-available/hbnb_static /etc/nginx/sites-enabled/
sudo systemctl reload nginx

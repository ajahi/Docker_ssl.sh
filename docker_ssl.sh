#!/bin/bash

#check command line arguments

 [ $# != 2 ] && { echo "Warning: script expeting two arguments: 1. domain-name 2. port"; exit 1; }


# Function to check if a domain already exists
check_domain_existence() {
    domain=$1
    domain_ip=$(ping -c 1 $domain| grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}');
    current_ip=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    
   [ $current_ip != $domain_ip ] && { echo "Given Domain IP:$domain_ip and Current IP:$current_ip  are not same "; exit 1; } 
}

# Function to check if a port is occupied
#check_port_availability() {
 #   echo "Checking if the port is available.............."
  #  port=$1
   # nc -z localhost $port &> /dev/null && { echo "Port $port is already occupied"; exit 1; }
#}

# Function to install NGINX if not installed
install_nginx() {
    command -v nginx &> /dev/null || { echo "NGINX is not installed. Installing..."; apt install -y nginx; }
}

# Function to create NGINX configuration file
create_nginx_conf() {
    domain=$1
    port=$2
    conf_file="/etc/nginx/sites-enabled/$domain.conf"
    echo "Creating NGINX configuration file: $conf_file"
    cat > $conf_file <<EOF
server {
    server_name $domain;

    location / {
        proxy_pass http://localhost:$port;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
      }
    }
EOF
}

# Function to check if certbot and python-certbot-nginx are installed
#check_certbot() {
 #   command -v certbot &> /dev/null && dpkg -l | grep -q python-certbot-nginx || { echo "Certbot or python-certbot-nginx is not installed. Installing..."; apt update && apt install -y certbot python-certbot-nginx; }
#}

# Check if domain and port arguments are provided
[ $# -ne 2 ] && { echo "Usage: $0 <domain> <port>"; exit 1; }

# Assign arguments to variables
domain=$1
port=$2

 
# Check if domain already exists
check_domain_existence $domain

# Check if port is available
#check_port_availability $port

# Install NGINX if not installed
install_nginx

# Create NGINX configuration file
create_nginx_conf $domain $port

# Obtain SSL certificate using certbot
sudo certbot --nginx -d $domain 
sudo systemctl restart nginx

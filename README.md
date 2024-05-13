# Docker_ssl.sh
Bash scripting to make a docker application ssl certiifed.

## Pre-Requisits
1. Understanding of Dockerization
2. DNS
3. Working domain name.

## Requirements
> Create a subdomain in your DNS pointing to your server.

## Working
This bash script file accepts two command line arguments. 1> domain name (subdomain.domain.com) 2> Port of the application to be deployed.

## Steps
1. Checks for command line arguments.
2. Checks for existence of domain name
3. Check if current IP and domain IP are same, if not error code is shown.
4. Checks if necessary services are installed. CERBOT, NGINX, python3-certbot-nginx.
5. Create a conf file for the given domain name with port number. Dir /etc/nginx/sites-enabled 
6. certbot nginx -d domainName.
7. Restart nginx

## Example
sudo ./Docker_ssl.sh <subdomain.domain.com> <port>


# Docker_ssl.sh
Bash scripting to make a docker application ssl certiifed.

## Pre-Requisits
> Understanding of Dockerization
> DNS
> Working domain name.

## Requirements
> Create a subdomain in your DNS pointing to your server.

## WORKING
This bash script file accepts two command line arguments. 1> domain name (subdomain.domain.com) 2> Port of the application to be deployed.

## STEPS
> Checks for command line arguments.
> Checks for existence of domain name
> Check if current IP and domain IP are same, if not error code is shown.
> Checks if necessary services are installed. CERBOT, NGINX, python3-certbot-nginx.
> Create a conf file for the given domain name with port number. Dir /etc/nginx/sites-enabled 
> certbot nginx -d domainName.
> Restart nginx

## EXAMPLE
sudo ./Docker_ssl.sh <subdomain.domain.com> <port>


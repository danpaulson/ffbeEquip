# ffbeEquip Production Setup

## Technology

- Cloudflare: Provides DDOS protection, edge caching of assets
- AWS - Loadbalancer, Linux instance
- Nginx - Webserver, handles SSL termination
- Varnish - caching reverse proxy
- Node - the ffbeEquip app

## Request / Response Loop

- User initiates request
- AWS Loadbalancer
	- For additional DDOS protection as well as ease of adding new nodes
- Cloudflare
	- On cache miss, proceeds to next step
	- On cache hit, serves assets from edge
- Nginx
	- For HTTPS requests, redirects locally to HTTP, and proceeds to next step
- Varnish
	- On cache hit, sends response from memory
	- On cache miss, proceeds to next step
- Node
	- ffbeEquip app responds with content

## Setup

`setup.sh` is a bash script that will do the following:

- Install Varnish and Nginx
- Create symlinks to the correct config files for those apps
- Install the Varnish service at a system level
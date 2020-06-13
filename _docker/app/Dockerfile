FROM ubuntu:latest

WORKDIR "/srv/web/ffbeequip.com"

# Install Linux libs
RUN apt-get update && apt-get install -y nano curl build-essential

# Install Node.js v14.x
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Install FFBE Equip App dependencies
RUN npm install
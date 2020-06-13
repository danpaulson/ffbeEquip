FROM ubuntu:18.04

# Install Varnish 6.1
RUN apt-get update && \
    apt-get install -y debian-archive-keyring && \
    apt-get install -y curl gnupg apt-transport-https && \
    curl -L https://packagecloud.io/varnishcache/varnish60lts/gpgkey | apt-key add - && \
    echo "deb https://packagecloud.io/varnishcache/varnish60lts/ubuntu/ bionic main" \
        >> /etc/apt/sources.list.d/varnishcache_varnish60lts.list && \
    echo "deb-src https://packagecloud.io/varnishcache/varnish60lts/ubuntu/ bionic main" \
        >> /etc/apt/sources.list.d/varnishcache_varnish60lts.list && \
    apt-get update && apt-get install -y varnish

# Install Varnish Modules
RUN apt-get install -y varnish-dev wget && \
    mkdir /src && cd /src && \
    wget https://download.varnish-software.com/varnish-modules/varnish-modules-0.15.0.tar.gz && \
    tar xvzf varnish-modules-0.15.0.tar.gz && \
    cd varnish-modules-0.15.0 && \
    ./configure && make && make install

# Add start script
COPY _docker/varnish/start-varnish.sh /usr/local/bin/start-varnish
COPY _docker/varnish/reload-varnish.sh /usr/local/bin/vrl
RUN chmod +x /usr/local/bin/start-varnish /usr/local/bin/vrl

RUN echo 'alias vl="varnishlog"' >> ~/.bashrc
RUN echo 'alias vld="varnishlog -c -i VCL_Log,VCL_call"' >> ~/.bashrc
RUN echo 'alias vlc="varnishadm vcl.show boot"' >> ~/.bashrc
RUN echo 'alias vba="varnishadm ban req.url ~ /"' >> ~/.bashrc

# Start Varnish
CMD ["start-varnish"]
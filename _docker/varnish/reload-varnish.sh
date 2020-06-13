#!/bin/bash

# Reload varnish config
HANDLE=varnish-cfg-$RANDOM ; \
  varnishadm vcl.load $HANDLE /etc/varnish/default.vcl && \
  varnishadm vcl.use $HANDLE
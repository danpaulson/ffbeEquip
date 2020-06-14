vcl 4.1;

backend default {
    .host = "ffbe.app";
    .port = "3000";
}

sub vcl_recv {
    # Only Cache certain data files
    if (req.url ~ "^/googleOAuth*" ||
        req.url ~ "^/(.*)/settings" ||
        req.url ~ "^/(.*)/units" ||
        req.url ~ "^/(.*)/defaultExclusionList" ||
        req.url ~ "^/(.*)/espers" ||
        req.url ~ "^/(.*)/itemInventory"
    ) {
        return (pass);
    }


    return(hash);
}

sub vcl_backend_response {
    set beresp.http.x-url = bereq.url;

    # Never Cache 404s
    if (beresp.status == 404) {
        set beresp.ttl = 0s;
    }

    set beresp.ttl = 10m;

    # GZip
    if (beresp.http.url ~ "\.(jpg|png|gif|gz|tgz|bz2|tbz|mp3|ogg|swf)$") {
        set beresp.do_gzip = false;
    }
    else {
        set beresp.do_gzip = true;
        set beresp.http.X-Cache = "ZIP";
    }
}
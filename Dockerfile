FROM bash:5.2
COPY matrix /usr/local/bin/matrix
USER nobody
ENTRYPOINT ["/usr/local/bin/bash", "/usr/local/bin/matrix"]

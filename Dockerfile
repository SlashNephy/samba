# syntax = docker/dockerfile:1.7-labs@sha256:6c10f183dee5815997ad312c29b524dccb03d9f1cfb535c511415b74c232f81e
FROM alpine@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

# Install samba
RUN <<EOF
    apk add --no-cache samba tzdata bash tini rsyslog
    addgroup -S smb
    adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g "" smbuser
EOF

COPY samba.sh /

LABEL org.opencontainers.image.source https://github.com/SlashNephy/samba
ENTRYPOINT [ "/sbin/tini", "--", "/samba.sh" ]

# syntax = docker/dockerfile:1.3-labs
FROM alpine@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a

# Install samba
RUN <<EOF
    apk add --no-cache samba tzdata bash tini rsyslog
    addgroup -S smb
    adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g "" smbuser
EOF

COPY samba.sh /

LABEL org.opencontainers.image.source https://github.com/SlashNephy/samba
ENTRYPOINT [ "/sbin/tini", "--", "/samba.sh" ]

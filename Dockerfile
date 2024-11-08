# syntax = docker/dockerfile:1.11-labs@sha256:abe0052c66a1352ebf6b2493c77459e4764af249d507c33e0d6176ac20075292
FROM alpine@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d

# Install samba
RUN <<EOF
    apk add --no-cache samba tzdata bash tini rsyslog
    addgroup -S smb
    adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g "" smbuser
EOF

COPY samba.sh /

LABEL org.opencontainers.image.source https://github.com/SlashNephy/samba
ENTRYPOINT [ "/sbin/tini", "--", "/samba.sh" ]

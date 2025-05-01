# syntax = docker/dockerfile:1.15-labs@sha256:94edd5b349df43675bd6f542e2b9a24e7177432dec45fe3066bfcf2ab14c4355
FROM alpine@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c

# Install samba
RUN <<EOF
    apk add --no-cache samba tzdata bash tini rsyslog
    addgroup -S smb
    adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g "" smbuser
EOF

COPY samba.sh /

LABEL org.opencontainers.image.source https://github.com/SlashNephy/samba
ENTRYPOINT [ "/sbin/tini", "--", "/samba.sh" ]

# syntax = docker/dockerfile:1.3-labs@sha256:250ce669e1aeeb5ffb892b18039c3f0801466536cb4210c8eb2638e628859bfd
FROM alpine@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978

# Install samba
RUN <<EOF
    apk add --no-cache samba tzdata bash tini rsyslog
    addgroup -S smb
    adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g "" smbuser
EOF

COPY samba.sh /

LABEL org.opencontainers.image.source https://github.com/SlashNephy/samba
ENTRYPOINT [ "/sbin/tini", "--", "/samba.sh" ]

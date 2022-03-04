#!/usr/bin/env bash

create_user() {
    local name="$1" passwd="$2"
    grep -q "^$name:" /etc/passwd || adduser -D -H "$name"
    echo -e "$passwd\n$passwd" | smbpasswd -s -a $name
}

while read i; do
    eval create_user $(sed 's/^/"/; s/$/"/; s/;/" "/g' <<< $i)
done < <(env | awk '/^USER[0-9=_]/ {sub (/^[^=]*=/, "", $0); print}')

if ps -ef | egrep -v grep | grep -q smbd; then
    echo "Service already running, please restart container to apply changes"
else
    exec ionice -c 3 smbd -F --no-process-group </dev/null
fi

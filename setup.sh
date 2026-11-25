#!/bin/sh
set -e

WORK=/home/student/work

if ! tmpfile=$(runuser -u student -- mktemp "$WORK/.test.XXXXXXXX"); then
    chmod 0777 "$WORK"
else
    runuser -u student -- rm -f "$tmpfile"
fi

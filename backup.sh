#!/bin/bash
set -euo pipefail
trap '! test -x hooks/error.sh || ./hooks/error.sh' ERR
! test -x hooks/pre.sh || ./hooks/pre.sh
chmod 0600 "$SSH_KEY"
curl -sSf -u "$USERNAME:$PASSWORD" -o rememberthemilk-backup.ics https://www.rememberthemilk.com/icalendar/simmel/
head -n1 rememberthemilk-backup.ics | grep -q '^BEGIN:VCALENDAR'
tail -n1 rememberthemilk-backup.ics | grep -q 'END:VCALENDAR[[:cntrl:]]$'
scp -i "$SSH_KEY" -o UserKnownHostsFile=/srv/known_hosts rememberthemilk-backup.ics "$SCP_URL"
! test -x hooks/post.sh || ./hooks/post.sh

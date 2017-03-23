#!/usr/bin/env bash

yum update -y

cat <<'EOF' >> ~/mycron
0 0 * * * yum -y update --security
EOF
crontab ~/mycron
rm ~/mycron
echo "${FUNCNAME[0]} Ended"


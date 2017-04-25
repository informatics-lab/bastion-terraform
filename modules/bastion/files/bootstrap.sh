#!/usr/bin/env bash

yum update -y

cat <<'EOF' >> ~/mycron
0 0 * * * yum -y update --security
EOF

crontab ~/mycron
rm ~/mycron

echo -e "\nPort 22" >> /etc/ssh/sshd_config
echo -e "\nPort 993" >> /etc/ssh/sshd_config
service sshd restart

echo "${FUNCNAME[0]} Ended"

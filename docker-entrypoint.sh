#!/bin/bash

# Wait for SecFlood Interfaces to become available and then update config
until ip link show dev "$SECFLOOD_INTF1" >/dev/null 2>&1; do
	sleep 2
done
until ip link show dev "$SECFLOOD_INTF2" >/dev/null 2>&1; do
	sleep 2
done
sed -i "s/XXXINTF1XXX/$SECFLOOD_INTF1/g" /etc/trex_cfg.yaml
sed -i "s/XXXINTF2XXX/$SECFLOOD_INTF2/g" /etc/trex_cfg.yaml
sed -i "s/XXXIP1XXX/$SECFLOOD_IP1/g" /etc/trex_cfg.yaml
sed -i "s/XXXIP2XXX/$SECFLOOD_IP2/g" /etc/trex_cfg.yaml
sed -i "s/XXXGW1XXX/$SECFLOOD_GW1/g" /etc/trex_cfg.yaml
sed -i "s/XXXGW2XXX/$SECFLOOD_GW2/g" /etc/trex_cfg.yaml

service ssh start
service apache2 start
service shellinabox start
rsyslogd

mkdir -p /var/lib/shellinabox/.ssh
chmod 700 /var/lib/shellinabox/.ssh
ssh-keygen -t rsa -N "" -C root@shellinabox -f /var/lib/shellinabox/.ssh/id_rsa
chown -R shellinabox:shellinabox /var/lib/shellinabox/.ssh
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cp /var/lib/shellinabox/.ssh/id_rsa.pub /root/.ssh/authorized_keys
chown root:root /root/.ssh

tail -f /var/log/syslog

#!/bin/bash

# Wait for SecFlood Interfaces to become available and then update config
echo "waiting for interfaces to become available..."
until ip link show dev "$SECFLOOD_INTF_INSIDE" >/dev/null 2>&1; do
	sleep 2
done
until ip link show dev "$SECFLOOD_INTF_OUTSIDE" >/dev/null 2>&1; do
	sleep 2
done

set -x

sed -i "s/XXXINTF1XXX/$SECFLOOD_INTF_INSIDE/g" /etc/trex_cfg.yaml /var/www/html/secflood/ifstat.php
sed -i "s/XXXINTF2XXX/$SECFLOOD_INTF_OUTSIDE/g" /etc/trex_cfg.yaml /var/www/html/secflood/ifstat.php
sed -i "s/XXXIP1XXX/$SECFLOOD_IP_INSIDE/g" /etc/trex_cfg.yaml
sed -i "s/XXXIP2XXX/$SECFLOOD_IP_OUTSIDE/g" /etc/trex_cfg.yaml
sed -i "s/XXXGW1XXX/$SECFLOOD_GW_INSIDE/g" /etc/trex_cfg.yaml
sed -i "s/XXXGW2XXX/$SECFLOOD_GW_OUTSIDE/g" /etc/trex_cfg.yaml

# create ssh key
su - shellinabox -s /bin/sh -c 'ssh-keygen -t rsa -N "" -f /var/lib/shellinabox/.ssh/id_rsa'
mkdir -p /root/.ssh
cp /var/lib/shellinabox/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# force SSL cert to be recreated
make-ssl-cert --force-overwrite generate-default-snakeoil

# start services
service ssh start
service apache2 start
service shellinabox start
rsyslogd

touch /var/log/syslog
tail -f /var/log/syslog

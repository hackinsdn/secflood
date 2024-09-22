FROM debian:12

RUN --mount=source=.,target=/mnt,type=bind \
    export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install --no-install-recommends -y apache2 libapache2-mod-php php-sqlite3 \
                                               sqlite3 git-core ssh sudo iproute2 tmux \
                                               vim python3-all pciutils binutils tcpdump \
					       rsyslog iptables \
                                               curl nmap hydra hping3 iperf3 d-itg \
 && echo "root:hackinsdn" | chpasswd \
 && sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 127.0.0.1/g' /etc/ssh/sshd_config \
 && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
 && cp -r /mnt/src /var/www/html/secfood \
 && cp -vr /mnt/conf/* / \
 && install --mode 0755 --owner root /mnt/scripts/trex /usr/local/bin/ \
 && mkdir -p /var/lib/sqlite \
 && sqlite3 /var/lib/sqlite/secflood.db < /var/www/html/secflood/assets/database.sql \
 && chown www-data /var/lib/sqlite/secflood.db \
 && apt install -y /mnt/misc/shellinabox_2.21.1_amd64.deb \
 && a2dissite 000-default \
 && a2enmod proxy_http \
 && a2enmod rewrite \
 && a2enmod ssl \
 && a2ensite secflood \
 && mv /etc/shellinabox/options-enabled/00+Black\ on\ White.css /etc/shellinabox/options-enabled/00_Black\ on\ White.css \
 && mv /etc/shellinabox/options-enabled/00_White\ On\ Black.css /etc/shellinabox/options-enabled/00+White\ On\ Black.css \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

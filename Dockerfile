FROM debian:12

RUN --mount=source=.,target=/mnt,type=bind \
    export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install --no-install-recommends -y apache2 libapache2-mod-php php-sqlite3 \
                                               sqlite3 git-core ssh sudo iproute2 net-tools iputils-ping tmux \
                                               vim python3-all pciutils binutils tcpdump \
                                               rsyslog iptables ssl-cert openssl ca-certificates \
                                               curl nmap hydra hping3 iperf3 d-itg socat \
                                               traceroute arjun \
 && apt install -y /mnt/misc/shellinabox_2.21.1_amd64.deb \
 && rm -rf /var/lib/apt/lists/*

RUN --mount=source=.,target=/mnt,type=bind \
    echo "root:hackinsdn" | chpasswd \
 && sed -i 's/#ListenAddress 0.0.0.0/ListenAddress 127.0.0.1/g' /etc/ssh/sshd_config \
 && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config \
 && cp -vr /mnt/conf/* /

RUN curl -L --insecure https://trex-tgn.cisco.com/trex/release/v3.05.tar.gz | tar -xz -C /opt/trex

RUN --mount=source=.,target=/mnt,type=bind \
    cp -r /mnt/src /var/www/html/secflood \
 && install --mode 0755 --owner root /mnt/scripts/trex /usr/local/bin/

RUN curl https://raw.githubusercontent.com/gkbrk/slowloris/refs/heads/master/slowloris.py -o /usr/local/bin/slowloris \
 && chmod +x /usr/local/bin/slowloris

RUN apt-get update \
 && apt install --no-install-recommends -y libnet-ssleay-perl \
 && rm -rf /var/lib/apt/lists/* \
 && git clone https://github.com/sullo/nikto /opt/nikto \
 && ln -s /opt/nikto/program/nikto.pl /usr/local/bin/nikto

RUN apt update \
 && apt install --no-install-recommends -y python3-requests python3-colorama \
 && rm -rf /var/lib/apt/lists/* \
 && git clone https://github.com/gildasio/h2t /opt/h2t \
 && ln -s /opt/h2t/h2t.py /usr/local/bin/h2t \
 && sed -i 's@headers/@/opt/h2t/headers/@g' /opt/h2t/h2t.py

RUN mkdir -p /var/lib/sqlite \
 && sqlite3 /var/lib/sqlite/secflood.db < /var/www/html/secflood/assets/database.sql \
 && chown www-data /var/lib/sqlite/secflood.db

RUN a2dissite 000-default \
 && a2enmod proxy_http \
 && a2enmod rewrite \
 && a2enmod ssl \
 && a2ensite secflood

RUN mv /etc/shellinabox/options-enabled/00+Black\ on\ White.css /etc/shellinabox/options-enabled/00_Black\ on\ White.css \
 && mv /etc/shellinabox/options-enabled/00_White\ On\ Black.css /etc/shellinabox/options-enabled/00+White\ On\ Black.css

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

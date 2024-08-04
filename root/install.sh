#!/bin/bash
apt-get -y update && apt-get -y dist-upgrade && apt-get -y install sudo bash nano curl tar stubby

mkdir -p /etc/stubby /tmp && rm -f /etc/stubby/stubby.yml && cd /tmp

if [[ ${TARGETPLATFORM} =~ "arm64" ]]; then
		curl -sL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb -o /tmp/cloudflared.deb
		dpkg --add-architecture arm64
		echo "$(date "+%d.%m.%Y %T") Added cloudflared for ${TARGETPLATFORM}" >> /build.info

	elif [[ ${TARGETPLATFORM} =~ "amd64" ]]; then
		curl -sL https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb -o /tmp/cloudflared.deb
		dpkg --add-architecture amd64
		echo "$(date "+%d.%m.%Y %T") Added cloudflared for ${TARGETPLATFORM}" >> /build.info
	else  echo "$(date "+%d.%m.%Y %T") Unsupported platform - cloudflared not added" >> /build.info
fi

apt install /tmp/cloudflared.deb && rm -f /tmp/cloudflared.deb && useradd -s /usr/sbin/nologin -r -M cloudflared && chown cloudflared:cloudflared /usr/local/bin/cloudflared

mkdir -p /etc/cloudflared && rm -f /etc/cloudflared/config.yml

apt-get -y autoremove && apt-get -y autoclean && apt-get -y clean && rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/*


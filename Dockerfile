FROM resin/rpi-raspbian MAINTAINER Alberto Lorenzo

RUN apt-get update && apt-get install -qy curl ca-certificates WORKDIR /root/ RUN mkdir /root/prometheus && 
curl -sSLO https://s3-eu-west-1.amazonaws.com/downloads.robustperception.io/prometheus/prometheus-linux-arm-nightly.tar.gz && 
tar -xvf prometheus-linux-arm-nightly.tar.gz -C /root/prometheus/ --strip-components=1 && 
rm prometheus-linux-arm-nightly.tar.gz

workdir /root/prometheus

RUN mkdir -p /usr/share/prometheus && 
mkdir -p /etc/prometheus && 
mv ./prometheus /usr/bin/ && 
mv ./promtool /usr/bin/ && 
mv ./console_libraries /usr/share/prometheus/ && 
mv ./consoles /usr/share/prometheus/ && 
ln -s /usr/share/prometheus/console_libraries /etc/prometheus/

EXPOSE 9090 VOLUME [ "/prometheus" ] WORKDIR /prometheus ENTRYPOINT [ "/usr/bin/prometheus" ] CMD ["-config.file=/etc/prometheus/prometheus.yml", 
"-storage.local.path=/prometheus", 
"-web.console.libraries=/usr/share/prometheus/console_libraries", 
"-web.console.templates=/usr/share/prometheus/consoles" ]

FROM ubuntu:bionic

COPY ss.json /etc/

RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt update && \
    apt install -y shadowsocks-libev iptables iproute2 dnsutils net-tools vim screen curl && \
    rm -rf /var/cache/apt/

WORKDIR /root/
EXPOSE 6677
CMD ss-server -c /etc/ss.json

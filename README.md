# mirror
* A mirror proxy for docker.io k8s.gcr.io gcr.io quay.io with shadowsocks redir transparent proxy
* quay.io not support for manifest v2, so it must use registry old version (it's a trik

# how to use it
* configure in /etc/docker/daemon.json:
* docker.io(hub.docker.com):
  * "registry-mirrors": ["http://192.168.123.123"]
* the others container registry:
  * "insecure-registries": ["k8s.gcr.io", "quay.io", "gcr.io"]
  * in /etc/hosts: 192.168.123.123 k8s.gcr.io ...
* finally:
  * docker-compose up -d


                command: >
                        sh -c "
                        echo 'nameserver 8.8.8.8' > /etc/resolv.conf &&
                        ip rule add fwmark 1 table 100 &&
                        ip route add local default dev lo table 100 &&

                        iptables -t mangle -A PREROUTING -d 127.0.0.0/8  -j RETURN &&
                        iptables -t mangle -A PREROUTING -d 10.0.0.0/8  -j RETURN &&
                        iptables -t mangle -A PREROUTING -d 192.168.0.0/16  -j RETURN &&
                        iptables -t mangle -A PREROUTING -d 172.16.0.0/12  -j RETURN &&
                        iptables -t mangle -A OUTPUT -d 127.0.0.0/8  -j RETURN &&
                        iptables -t mangle -A OUTPUT -d 10.0.0.0/8  -j RETURN &&
                        iptables -t mangle -A OUTPUT -d 192.168.0.0/16  -j RETURN &&
                        iptables -t mangle -A OUTPUT -d 172.16.0.0/12  -j RETURN &&

                        iptables -t mangle -A OUTPUT -d 180.97.250.217 -j RETURN &&

                        iptables -t mangle -A OUTPUT -p tcp -j MARK --set-mark 0x1/0x1 &&
                        iptables -t mangle -A PREROUTING -p tcp -j TPROXY --on-port 12345 --tproxy-mark 0x1/0x1 &&
                        iptables -t mangle -A OUTPUT -p udp -j MARK --set-mark 0x1/0x1 &&
                        iptables -t mangle -A PREROUTING -p udp -j TPROXY --on-port 12345 --tproxy-mark 0x1/0x1 &&
                        sleep 100000d "

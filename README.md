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

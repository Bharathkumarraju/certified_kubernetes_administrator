ip link
ip addr
ip addr add 192.168.1.0/24 dev eth0
ip route
ip route add 192.168.1.0/24 via 192.168.2.1
cat /proc/sys/net/ipv4/ip_forward
arp 
route 

how to deploy a network addon --> "weave-net"


root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   7m7s    v1.20.0   10.3.110.9    <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
node01         Ready    <none>                 6m11s   v1.20.0   10.3.110.12   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# 


root@controlplane:~# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:1b:24:29:2c brd ff:ff:ff:ff:ff:ff
3: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN mode DEFAULT group default 
    link/ether ce:f4:d8:2e:e4:ae brd ff:ff:ff:ff:ff:ff
4: cni0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether ae:27:5f:22:d2:18 brd ff:ff:ff:ff:ff:ff
5: veth9b446119@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue master cni0 state UP mode DEFAULT group default 
    link/ether 1e:50:5b:2f:68:df brd ff:ff:ff:ff:ff:ff link-netnsid 2
6: veth96d95d6c@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue master cni0 state UP mode DEFAULT group default 
    link/ether 92:68:a5:7e:f2:3d brd ff:ff:ff:ff:ff:ff link-netnsid 3
44603: eth0@if44604: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:0a:03:6e:09 brd ff:ff:ff:ff:ff:ff link-netnsid 0
44605: eth1@if44606: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:ac:19:00:1c brd ff:ff:ff:ff:ff:ff link-netnsid 1
root@controlplane:~#


What is the network interface configured for cluster connectivity on the master node?
node-to-node communication



root@controlplane:~# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:1b:24:29:2c brd ff:ff:ff:ff:ff:ff
    inet 172.12.0.1/24 brd 172.12.0.255 scope global docker0
       valid_lft forever preferred_lft forever
3: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN group default 
    link/ether ce:f4:d8:2e:e4:ae brd ff:ff:ff:ff:ff:ff
    inet 10.244.0.0/32 brd 10.244.0.0 scope global flannel.1
       valid_lft forever preferred_lft forever
4: cni0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UP group default qlen 1000
    link/ether ae:27:5f:22:d2:18 brd ff:ff:ff:ff:ff:ff
    inet 10.244.0.1/24 brd 10.244.0.255 scope global cni0
       valid_lft forever preferred_lft forever
5: veth9b446119@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue master cni0 state UP group default 
    link/ether 1e:50:5b:2f:68:df brd ff:ff:ff:ff:ff:ff link-netnsid 2
6: veth96d95d6c@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue master cni0 state UP group default 
    link/ether 92:68:a5:7e:f2:3d brd ff:ff:ff:ff:ff:ff link-netnsid 3
44603: eth0@if44604: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default 
    link/ether 02:42:0a:03:6e:09 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.3.110.9/24 brd 10.3.110.255 scope global eth0
       valid_lft forever preferred_lft forever
44605: eth1@if44606: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:19:00:1c brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 172.25.0.28/24 brd 172.25.0.255 scope global eth1
       valid_lft forever preferred_lft forever
root@controlplane:~#



What is the MAC address of the interface on the master node?

root@controlplane:~# ip link show eth0
44603: eth0@if44604: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:0a:03:6e:09 brd ff:ff:ff:ff:ff:ff link-netnsid 0
root@controlplane:~# 


root@controlplane:~# arp
Address                  HWtype  HWaddress           Flags Mask            Iface
10.3.110.4               ether   02:42:0a:03:6e:04   C                     eth0
10.244.0.2               ether   d2:cc:5a:40:2c:52   C                     cni0
10.244.1.0               ether   7e:18:9a:b8:f0:88   CM                    flannel.1
10.3.110.11              ether   02:42:0a:03:6e:0a   C                     eth0
10.3.110.13              ether   02:42:0a:03:6e:0d   C                     eth0
10.3.110.7               ether   02:42:0a:03:6e:07   C                     eth0
10.244.0.3               ether   6e:50:0b:a2:84:d1   C                     cni0
10.3.110.10              ether   02:42:0a:03:6e:0a   C                     eth0
k8-multi-node-ttyd-1-20  ether   02:42:0a:03:6e:0c   C                     eth0
172.25.0.1               ether   02:42:64:28:fa:49   C                     eth1
root@controlplane:~# 



root@controlplane:~# arp controlplane
controlplane (10.3.110.9) -- no entry
root@controlplane:~# arp node01
Address                  HWtype  HWaddress           Flags Mask            Iface
10.3.110.11              ether   02:42:0a:03:6e:0a   C                     eth0
root@controlplane:~# 

root@controlplane:~# ssh node01
root@node01:~# arp
Address                  HWtype  HWaddress           Flags Mask            Iface
10.3.110.4               ether   02:42:0a:03:6e:04   C                     eth0
10.3.110.8               ether   02:42:0a:03:6e:0d   C                     eth0
k8-multi-node-ttyd-1-20  ether   02:42:0a:03:6e:09   C                     eth0
10.244.0.0               ether   ce:f4:d8:2e:e4:ae   CM                    flannel.1
172.17.0.1               ether   02:42:6e:67:3c:7a   C                     eth1
10.3.110.13              ether   02:42:0a:03:6e:0d   C                     eth0
10.3.110.10              ether   02:42:0a:03:6e:0a   C                     eth0
root@node01:~# 
root@node01:~# arp controlplane
Address                  HWtype  HWaddress           Flags Mask            Iface
10.3.110.8               ether   02:42:0a:03:6e:0d   C                     eth0
root@node01:~# 



Docker is container runtime What is the interface/bridge created by Docker on this host?


root@controlplane:~# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:1b:24:29:2c brd ff:ff:ff:ff:ff:ff
3: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UNKNOWN mode DEFAULT group default 
    link/ether ce:f4:d8:2e:e4:ae brd ff:ff:ff:ff:ff:ff
4: cni0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether ae:27:5f:22:d2:18 brd ff:ff:ff:ff:ff:ff
5: veth9b446119@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue master cni0 state UP mode DEFAULT group default 
    link/ether 1e:50:5b:2f:68:df brd ff:ff:ff:ff:ff:ff link-netnsid 2
6: veth96d95d6c@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1400 qdisc noqueue master cni0 state UP mode DEFAULT group default 
    link/ether 92:68:a5:7e:f2:3d brd ff:ff:ff:ff:ff:ff link-netnsid 3
44603: eth0@if44604: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:0a:03:6e:09 brd ff:ff:ff:ff:ff:ff link-netnsid 0
44605: eth1@if44606: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:ac:19:00:1c brd ff:ff:ff:ff:ff:ff link-netnsid 1
root@controlplane:~# 



root@controlplane:~# ip link show docker0 
2: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default 
    link/ether 02:42:1b:24:29:2c brd ff:ff:ff:ff:ff:ff
root@controlplane:~# 


If you were to ping google from the master node, which route does it take?
What is the IP address of the Default Gateway?

root@controlplane:~# ip route show
default via 172.25.0.1 dev eth1 
10.3.110.0/24 dev eth0 proto kernel scope link src 10.3.110.9 
10.244.0.0/24 dev cni0 proto kernel scope link src 10.244.0.1 
10.244.1.0/24 via 10.244.1.0 dev flannel.1 onlink 
172.12.0.0/24 dev docker0 proto kernel scope link src 172.12.0.1 linkdown 
172.25.0.0/24 dev eth1 proto kernel scope link src 172.25.0.28 
root@controlplane:~# 

root@controlplane:~# ip route show default
default via 172.25.0.1 dev eth1 
root@controlplane:~# 



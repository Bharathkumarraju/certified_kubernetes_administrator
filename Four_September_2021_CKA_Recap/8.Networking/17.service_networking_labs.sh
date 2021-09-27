What network range are the nodes in the cluster part of?

ip addr and look at the IP address assigned to the eth0 interfaces. Derive network range from that.

root@controlplane:~# apt-get install -y ipcalc
Reading package lists... Done
Building dependency tree       
Reading state information... Done
ipcalc is already the newest version (0.41-5).
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
root@controlplane:~# 

 
root@controlplane:~# ip a | grep eth0
4227: eth0@if4228: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default 
    inet 10.15.219.6/24 brd 10.15.219.255 scope global eth0
root@controlplane:~# ipcalc -b 10.15.219.6/24
Address:   10.15.219.6          
Netmask:   255.255.255.0 = 24   
Wildcard:  0.0.0.255            
=>
Network:   10.15.219.0/24       
HostMin:   10.15.219.1          
HostMax:   10.15.219.254        
Broadcast: 10.15.219.255        
Hosts/Net: 254                   Class A, Private Internet

root@controlplane:~# 


 
 What is the range of IP addresses configured for PODs on this cluster?
# kubectl logs weave-net-627nk weave -n kube-system 

 root@controlplane:~# kubectl logs weave-net-627nk -n kube-system 
error: a container name must be specified for pod weave-net-627nk, choose one of: [weave weave-npc] or one of the init containers: [weave-init]
root@controlplane:~# kubectl logs weave-net-627nk weave -n kube-system 
DEBU: 2021/09/27 08:54:52.452110 [kube-peers] Checking peer "86:d2:8d:82:da:47" against list &{[]}
Peer not in list; removing persisted data
INFO: 2021/09/27 08:54:52.774655 Command line options: map[conn-limit:200 datapath:datapath db-prefix:/weavedb/weave-net docker-api: expect-npc:true http-addr:127.0.0.1:6784 ipalloc-init:consensus=0 ipalloc-range:10.50.0.0/16 metrics-addr:0.0.0.0:6782 name:86:d2:8d:82:da:47 nickname:controlplane no-dns:true no-masq-local:true port:6783]
INFO: 2021/09/27 08:54:52.774804 weave  2.8.1
INFO: 2021/09/27 08:54:54.268379 Bridge type is bridged_fastdp
INFO: 2021/09/27 08:54:54.268428 Communication between peers is unencrypted.
INFO: 2021/09/27 08:54:54.273996 Our name is 86:d2:8d:82:da:47(controlplane)
INFO: 2021/09/27 08:54:54.274073 Launch detected - using supplied peer list: []
INFO: 2021/09/27 08:54:54.274156 Using "no-masq-local" LocalRangeTracker
INFO: 2021/09/27 08:54:54.274172 Checking for pre-existing addresses on weave bridge
INFO: 2021/09/27 08:54:54.276122 [allocator 86:d2:8d:82:da:47] No valid persisted data
INFO: 2021/09/27 08:54:54.284607 [allocator 86:d2:8d:82:da:47] Initialising via deferred consensus
INFO: 2021/09/27 08:54:54.284740 Sniffing traffic on datapath (via ODP)
INFO: 2021/09/27 08:54:54.334151 Listening for HTTP control messages on 127.0.0.1:6784
INFO: 2021/09/27 08:54:54.334441 Listening for metrics requests on 0.0.0.0:6782
INFO: 2021/09/27 08:54:54.468655 Error checking version: Get "https://checkpoint-api.weave.works/v1/check/weave-net?arch=amd64&flag_docker-version=none&flag_kernel-version=5.4.0-1052-gcp&os=linux&signature=gcF912ffmo8YREblTPlm3cNoSXNxl8a63a%2F%2BwEt4%2B4w%3D&version=2.8.1": dial tcp: lookup checkpoint-api.weave.works on 10.96.0.10:53: write udp 172.17.0.81:37204->10.96.0.10:53: write: operation not permitted
INFO: 2021/09/27 08:54:54.736502 [kube-peers] Added myself to peer list &{[{86:d2:8d:82:da:47 controlplane}]}
DEBU: 2021/09/27 08:54:54.747796 [kube-peers] Nodes that have disappeared: map[]
INFO: 2021/09/27 08:54:54.774377 Assuming quorum size of 1
INFO: 2021/09/27 08:54:54.774565 adding entry 10.50.0.0/16 to weaver-no-masq-local of 0
INFO: 2021/09/27 08:54:54.774591 added entry 10.50.0.0/16 to weaver-no-masq-local of 0
10.50.0.1
DEBU: 2021/09/27 08:54:54.948924 registering for updates for node delete events
INFO: 2021/09/27 08:55:24.325962 ->[10.15.219.9:51035] connection accepted
INFO: 2021/09/27 08:55:24.327492 ->[10.15.219.9:51035|7a:0a:e1:78:3a:84(node01)]: connection ready; using protocol version 2
INFO: 2021/09/27 08:55:24.327736 overlay_switch ->[7a:0a:e1:78:3a:84(node01)] using fastdp
INFO: 2021/09/27 08:55:24.327778 ->[10.15.219.9:51035|7a:0a:e1:78:3a:84(node01)]: connection added (new peer)
INFO: 2021/09/27 08:55:24.428675 ->[10.15.219.9:51035|7a:0a:e1:78:3a:84(node01)]: connection fully established
INFO: 2021/09/27 08:55:24.430068 sleeve ->[10.15.219.9:6783|7a:0a:e1:78:3a:84(node01)]: Effective MTU verified at 1388
INFO: 2021/09/27 08:55:25.429246 adding entry 10.50.0.0/17 to weaver-no-masq-local of 0
INFO: 2021/09/27 08:55:25.429292 added entry 10.50.0.0/17 to weaver-no-masq-local of 0
INFO: 2021/09/27 08:55:25.430688 adding entry 10.50.128.0/18 to weaver-no-masq-local of 0
INFO: 2021/09/27 08:55:25.430747 added entry 10.50.128.0/18 to weaver-no-masq-local of 0
INFO: 2021/09/27 08:55:25.431762 deleting entry 10.50.0.0/16 from weaver-no-masq-local of 0
INFO: 2021/09/27 08:55:25.431799 deleted entry 10.50.0.0/16 from weaver-no-masq-local of 0
INFO: 2021/09/27 08:55:25.493874 Discovered remote MAC 7a:0a:e1:78:3a:84 at 7a:0a:e1:78:3a:84(node01)
root@controlplane:~# 



What is the IP Range configured for the services within the cluster?


root@controlplane:~# cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep cluster-ip-range
    - --service-cluster-ip-range=10.96.0.0/12
root@controlplane:~# 




What type of proxy is the kube-proxy configured to use?



root@controlplane:~# kubectl get all --all-namespaces | grep -i "kube-proxy"
kube-system   pod/kube-proxy-4mgll                       1/1     Running   0          31m
kube-system   pod/kube-proxy-59dvb                       1/1     Running   0          30m
kube-system   daemonset.apps/kube-proxy   2         2         2       2            2           kubernetes.io/os=linux   31m
root@controlplane:~# kubectl logs kube-proxy-4mgll -n kube-system
W0927 08:54:33.945359       1 proxier.go:661] Failed to load kernel module ip_vs_wrr with modprobe. You can ignore this message when kube-proxy is running inside container without mounting /lib/modules
W0927 08:54:33.949143       1 proxier.go:661] Failed to load kernel module ip_vs_sh with modprobe. You can ignore this message when kube-proxy is running inside container without mounting /lib/modules
I0927 08:54:34.052244       1 node.go:172] Successfully retrieved node IP: 10.15.219.6
I0927 08:54:34.052321       1 server_others.go:142] kube-proxy node IP is an IPv4 address (10.15.219.6), assume IPv4 operation
W0927 08:54:34.148331       1 server_others.go:578] Unknown proxy mode "", assuming iptables proxy
I0927 08:54:34.184424       1 server_others.go:185] Using iptables Proxier.
I0927 08:54:34.249532       1 server.go:650] Version: v1.20.0
I0927 08:54:34.270712       1 conntrack.go:52] Setting nf_conntrack_max to 1179648
I0927 08:54:34.273624       1 conntrack.go:100] Set sysctl 'net/netfilter/nf_conntrack_tcp_timeout_established' to 86400
I0927 08:54:34.277353       1 config.go:315] Starting service config controller
I0927 08:54:34.277384       1 shared_informer.go:240] Waiting for caches to sync for service config
I0927 08:54:34.277433       1 config.go:224] Starting endpoint slice config controller
I0927 08:54:34.277454       1 shared_informer.go:240] Waiting for caches to sync for endpoint slice config
I0927 08:54:34.377692       1 shared_informer.go:247] Caches are synced for service config 
I0927 08:54:34.377695       1 shared_informer.go:247] Caches are synced for endpoint slice config 
root@controlplane:~# 
root@controlplane:~# kubectl logs pod/kube-proxy-59dvb -n kube-system
W0927 08:55:14.401382       1 proxier.go:661] Failed to load kernel module ip_vs_wrr with modprobe. You can ignore this message when kube-proxy is running inside container without mounting /lib/modules
W0927 08:55:14.407380       1 proxier.go:661] Failed to load kernel module ip_vs_sh with modprobe. You can ignore this message when kube-proxy is running inside container without mounting /lib/modules
I0927 08:55:14.495137       1 node.go:172] Successfully retrieved node IP: 10.15.219.9
I0927 08:55:14.495184       1 server_others.go:142] kube-proxy node IP is an IPv4 address (10.15.219.9), assume IPv4 operation
W0927 08:55:14.679926       1 server_others.go:578] Unknown proxy mode "", assuming iptables proxy
I0927 08:55:14.817002       1 server_others.go:185] Using iptables Proxier.
I0927 08:55:14.934375       1 server.go:650] Version: v1.20.0
I0927 08:55:15.014109       1 conntrack.go:52] Setting nf_conntrack_max to 1179648
I0927 08:55:15.017569       1 conntrack.go:100] Set sysctl 'net/netfilter/nf_conntrack_tcp_timeout_established' to 86400
I0927 08:55:15.021132       1 config.go:315] Starting service config controller
I0927 08:55:15.021166       1 shared_informer.go:240] Waiting for caches to sync for service config
I0927 08:55:15.021203       1 config.go:224] Starting endpoint slice config controller
I0927 08:55:15.021223       1 shared_informer.go:240] Waiting for caches to sync for endpoint slice config
I0927 08:55:15.121378       1 shared_informer.go:247] Caches are synced for service config 
I0927 08:55:15.121405       1 shared_informer.go:247] Caches are synced for endpoint slice config 
root@controlplane:~# 

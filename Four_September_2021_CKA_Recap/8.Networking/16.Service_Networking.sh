ClusterIP: accessible only within the cluster.

NodePort: can also accessible from outside

when a service is created it is assigned an IP Address from a pre-defined range.
the "kube-proxy" component running on each node, gets that IP Address and creates forwarding rule on each node of the cluster using IPAddress and Port.
"kube-proxy" uses "iptables" to create forwarding rules.


iptables -L -t nat 

/var/log/kube-proxy.log


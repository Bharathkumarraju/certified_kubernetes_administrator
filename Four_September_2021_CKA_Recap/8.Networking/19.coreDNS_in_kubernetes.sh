Prior to 1.12 the DNS server called the "kube-dns" 

with version 1.12 the recommended DNS server is coreDNS.

core-dns deployed as a pods in kube-sytem namespace.

./Coredns  requires a config file located in /etc/coredns/Corefile


When coreDNS deployed its solution it has created a service called "kube-dns"
when ever a new pod created in its "/etc/resolv.conf" the "kube-dns service's"  clusterIP gets configured.

to add the above entry is the job of kubelet(it will be done automatically)

cat /var/lib/kubelet/config.yaml
---------------------------------------->
...
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local


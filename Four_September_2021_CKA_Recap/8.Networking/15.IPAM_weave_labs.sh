root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   53m   v1.20.0   10.12.176.6   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
node01         Ready    <none>                 52m   v1.20.0   10.12.176.9   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# 



root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   53m   v1.20.0   10.12.176.6   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
node01         Ready    <none>                 52m   v1.20.0   10.12.176.9   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# ps aux | grep -i "kubelet"
root      3653  0.0  0.1 1103940 351196 ?      Ssl  07:42   5:33 kube-apiserver --advertise-address=10.12.176.6 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/etc/kubernetes/pki/ca.crt --enable-admission-plugins=NodeRestriction --enable-bootstrap-token-auth=true --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --insecure-port=0 --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=6443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/etc/kubernetes/pki/sa.pub --service-account-signing-key-file=/etc/kubernetes/pki/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/etc/kubernetes/pki/apiserver.crt --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
root      4865  0.0  0.0 4150812 85812 ?       Ssl  07:42   2:54 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.2
root     29476  0.0  0.0  11468  1100 pts/0    S+   08:36   0:00 grep --color=auto -i kubelet
root@controlplane:~# 



root@controlplane:~# kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-74ff55c5b-4d5mc                1/1     Running   0          54m
coredns-74ff55c5b-mwjtw                1/1     Running   0          54m
etcd-controlplane                      1/1     Running   0          54m
kube-apiserver-controlplane            1/1     Running   0          54m
kube-controller-manager-controlplane   1/1     Running   0          54m
kube-proxy-5tktf                       1/1     Running   0          53m
kube-proxy-knlpw                       1/1     Running   0          54m
kube-scheduler-controlplane            1/1     Running   0          54m
weave-net-8f8xq                        2/2     Running   1          54m
weave-net-zzs6l                        2/2     Running   0          53m
root@controlplane:~# 



root@controlplane:/etc/cni/net.d# pwd
/etc/cni/net.d
root@controlplane:/etc/cni/net.d# ls
10-weave.conflist
root@controlplane:/etc/cni/net.d# cat 10-weave.conflist 
{
    "cniVersion": "0.3.0",
    "name": "weave",
    "plugins": [
        {
            "name": "weave",
            "type": "weave-net",
            "hairpinMode": true
        },
        {
            "type": "portmap",
            "capabilities": {"portMappings": true},
            "snat": true
        }
    ]
}
root@controlplane:/etc/cni/net.d# 



root@controlplane:/etc/cni/net.d# ip addr show weave
5: weave: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1376 qdisc noqueue state UP group default qlen 1000
    link/ether 06:b9:8c:8c:cc:9a brd ff:ff:ff:ff:ff:ff
    inet 10.50.0.1/16 brd 10.50.255.255 scope global weave
       valid_lft forever preferred_lft forever
root@controlplane:/etc/cni/net.d# 



root@controlplane:/etc/cni/net.d# arp
Address                  HWtype  HWaddress           Flags Mask            Iface
10.50.0.3                ether   ae:23:0f:b1:b6:f6   C                     weave
10.12.176.4              ether   02:42:0a:0c:b0:04   C                     eth0
10.12.176.13             ether   02:42:0a:0c:b0:0d   C                     eth0
10.12.176.7              ether   02:42:0a:0c:b0:07   C                     eth0
10.12.176.10             ether   02:42:0a:0c:b0:0a   C                     eth0
k8-multi-node-weave-tty  ether   02:42:0a:0c:b0:09   C                     eth0
172.25.0.1               ether   02:42:64:28:fa:49   C                     eth1
10.50.0.2                ether   fa:b3:57:78:c6:ea   C                     weave
10.12.176.8              ether   02:42:0a:0c:b0:07   C                     eth0
root@controlplane:/etc/cni/net.d# ip route
default via 172.25.0.1 dev eth1 
10.12.176.0/24 dev eth0 proto kernel scope link src 10.12.176.6 
10.50.0.0/16 dev weave proto kernel scope link src 10.50.0.1 
172.12.0.0/24 dev docker0 proto kernel scope link src 172.12.0.1 linkdown 
172.25.0.0/24 dev eth1 proto kernel scope link src 172.25.0.24 
root@controlplane:/etc/cni/net.d# 



root@controlplane:/etc/cni/net.d# arp
Address                  HWtype  HWaddress           Flags Mask            Iface
10.50.0.3                ether   ae:23:0f:b1:b6:f6   C                     weave
10.12.176.4              ether   02:42:0a:0c:b0:04   C                     eth0
10.12.176.13             ether   02:42:0a:0c:b0:0d   C                     eth0
10.12.176.7              ether   02:42:0a:0c:b0:07   C                     eth0
10.12.176.10             ether   02:42:0a:0c:b0:0a   C                     eth0
k8-multi-node-weave-tty  ether   02:42:0a:0c:b0:09   C                     eth0
172.25.0.1               ether   02:42:64:28:fa:49   C                     eth1
10.50.0.2                ether   fa:b3:57:78:c6:ea   C                     weave
10.12.176.8              ether   02:42:0a:0c:b0:07   C                     eth0
root@controlplane:/etc/cni/net.d# ip route
default via 172.25.0.1 dev eth1 
10.12.176.0/24 dev eth0 proto kernel scope link src 10.12.176.6 
10.50.0.0/16 dev weave proto kernel scope link src 10.50.0.1 
172.12.0.0/24 dev docker0 proto kernel scope link src 172.12.0.1 linkdown 
172.25.0.0/24 dev eth1 proto kernel scope link src 172.25.0.24 
root@controlplane:/etc/cni/net.d# 

kubeclt exec -it pod-webapp
ip route


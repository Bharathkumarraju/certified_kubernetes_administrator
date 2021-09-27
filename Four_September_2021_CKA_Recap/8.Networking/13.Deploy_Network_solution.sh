kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')" 


MacBook-Pro:8.Networking bharathdasaraju$ kubectl version | tr -d '\n'
Client Version: version.Info{Major:"1", Minor:"19", GitVersion:"v1.19.3", GitCommit:"1e11e4a2108024935ecfcb2912226cedeafd99df", GitTreeState:"clean", BuildDate:"2020-10-14T12:50:19Z", GoVersion:"go1.15.2", Compiler:"gc", Platform:"darwin/amd64"}Server Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.2", GitCommit:"faecb196815e248d3ecfb03c680a4507229c2a56", GitTreeState:"clean", BuildDate:"2021-01-13T13:20:00Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}
MacBook-Pro:8.Networking bharathdasaraju$ 



Deploy weave-net networking solution to the cluster.

Replace the default IP address and subnet of weave-net to the 10.50.0.0/16.
Please check the official weave installation and configuration guide which is available at the top right panel.

1.https://www.weave.works/docs/net/latest/kubernetes/kube-addon/#-changing-configuration-options
2. https://www.weave.works/docs/net/latest/kubernetes/kube-addon/#-installation


Solution:
------------------------------------------------------------------------------------------>
By default, the range of IP addresses and the subnet used by weave-net is 10.32.0.0/12 and 
its overlapping with the host system IP addresses.
To know the host system IP address by running ip a




root@controlplane:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:f0:0f:ae:f6 brd ff:ff:ff:ff:ff:ff
    inet 172.12.0.1/24 brd 172.12.0.255 scope global docker0
       valid_lft forever preferred_lft forever
3: datapath: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1376 qdisc noqueue state UNKNOWN group default qlen 1000
    link/ether 2e:12:df:d1:7a:b2 brd ff:ff:ff:ff:ff:ff
5: weave: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1376 qdisc noqueue state UP group default qlen 1000
    link/ether 42:a3:19:0f:16:3c brd ff:ff:ff:ff:ff:ff
    inet 10.50.0.1/16 brd 10.50.255.255 scope global weave
       valid_lft forever preferred_lft forever
24838: eth0@if24839: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UP group default 
    link/ether 02:42:0a:0b:38:06 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.11.56.6/24 brd 10.11.56.255 scope global eth0
       valid_lft forever preferred_lft forever
7: vethwe-datapath@vethwe-bridge: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1376 qdisc noqueue master datapath state UP group default 
    link/ether 6a:da:9e:62:c0:5d brd ff:ff:ff:ff:ff:ff
8: vethwe-bridge@vethwe-datapath: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1376 qdisc noqueue master weave state UP group default 
    link/ether 96:e2:1f:41:bf:de brd ff:ff:ff:ff:ff:ff
24840: eth1@if24841: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:3e brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet 172.17.0.62/16 brd 172.17.255.255 scope global eth1
       valid_lft forever preferred_lft forever
9: vxlan-6784: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 65535 qdisc noqueue master datapath state UNKNOWN group default qlen 1000
    link/ether 52:98:c1:8c:d9:9c brd ff:ff:ff:ff:ff:ff
11: vethweplf48374a@if10: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1376 qdisc noqueue master weave state UP group default 
    link/ether 92:f2:38:04:21:af brd ff:ff:ff:ff:ff:ff link-netnsid 2
13: vethwepl708f939@if12: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1376 qdisc noqueue master weave state UP group default 
    link/ether 62:b4:86:59:28:6d brd ff:ff:ff:ff:ff:ff link-netnsid 3
root@controlplane:~#


If we deploy a weave manifest file directly without changing the default IP addresses 
it will overlap with the host system IP addresses and as a result,
its weave pods will go into an Error or CrashLoopBackOff state




root@controlplane:~# kubectl get po -n kube-system | grep weave
weave-net-6mckb                        1/2     CrashLoopBackOff   6          6m46s
If we will go more deeper and inspect the logs then we can clearly see the issue :-

root@controlplane:~# kubectl logs -n kube-system weave-net-6mckb -c weave
Network 10.32.0.0/12 overlaps with existing route 10.40.56.0/24 on host

So we need to change the default IP address by adding 
&env.IPALLOC_RANGE=10.50.0.0/16 option at the end of the manifest file. 
It should be look like as follows :-

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=10.50.0.0/16"



kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=10.50.0.0/16"



root@controlplane:~# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=10.50.0.0/16"
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.apps/weave-net created
root@controlplane:~# 


root@controlplane:~# kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-74ff55c5b-lfq6t                1/1     Running   0          44m
coredns-74ff55c5b-shjds                1/1     Running   0          44m
etcd-controlplane                      1/1     Running   0          44m
kube-apiserver-controlplane            1/1     Running   0          44m
kube-controller-manager-controlplane   1/1     Running   0          44m
kube-proxy-pl6br                       1/1     Running   0          44m
kube-scheduler-controlplane            1/1     Running   0          44m
weave-net-vkbt9                        2/2     Running   0          22s
root@controlplane:~# 


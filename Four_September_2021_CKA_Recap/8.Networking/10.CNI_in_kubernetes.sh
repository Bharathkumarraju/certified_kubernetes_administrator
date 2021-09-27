Bridging
Natting
Masquerading

CNI 
CNI plugins

1. container runtime must create network namespaces.
2. identify the nwetwork the container must attach to.
3. Container runtime to invoke network plugin(bridge) when container is added.
4. Container runtime to invoke Network plugin(bridge) when contiNER is Deleted.

CNI plugin must configure with kubelet in each node of the cluster.

kubelet.service:
--------------------->
ExecStart=/usr/local/bin/kubelet \\
...
  --network-plugin=cni \\
  --cni-bin-dir=/opt/cni/bin \\
  --cni-conf-dir=/etc/cni/net.d \\
...


MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ docker ps
CONTAINER ID        IMAGE                                 COMMAND                  CREATED             STATUS              PORTS                                                                                                                                  NAMES
15a6fd66b44e        gcr.io/k8s-minikube/kicbase:v0.0.22   "/usr/local/bin/entr…"   6 days ago          Up About a minute   127.0.0.1:32772->22/tcp, 127.0.0.1:32771->2376/tcp, 127.0.0.1:32770->5000/tcp, 127.0.0.1:32769->8443/tcp, 127.0.0.1:32768->32443/tcp   minikube
MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ docker exec -it 15a6fd66b44e bash
root@minikube:/# ps auxwww | grep -i "kubelet "
root        1003 12.6  4.5 1942524 92408 ?       Ssl  06:34   0:08 /var/lib/minikube/binaries/v1.20.2/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime=docker --hostname-override=minikube --kubeconfig=/etc/kubernetes/kubelet.conf --node-ip=192.168.49.2
root        3819  0.0  0.0   3436   724 pts/1    S+   06:35   0:00 grep --color=auto -i kubelet 
root@minikube:/# 

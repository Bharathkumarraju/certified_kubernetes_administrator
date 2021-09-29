root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   20m   v1.20.0   10.53.130.3   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
node01         Ready    <none>                 19m   v1.20.0   10.53.130.6   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# 


root@controlplane:~# kubectl get nodes
NAME           STATUS     ROLES                  AGE   VERSION
controlplane   Ready      control-plane,master   21m   v1.20.0
node01         NotReady   <none>                 20m   v1.20.0
root@controlplane:~# 



root@node01:~# cd /etc/systemd/system/kubelet.service.d/
root@node01:/etc/systemd/system/kubelet.service.d# pwd
/etc/systemd/system/kubelet.service.d
root@node01:/etc/systemd/system/kubelet.service.d# cat 10-kubeadm.conf 
# Note: This dropin only works with kubeadm and kubelet v1.11+
[Service]
Environment="KUBELET_KUBECONFIG_ARGS=--bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf"
Environment="KUBELET_CONFIG_ARGS=--config=/var/lib/kubelet/config.yaml"
# This is a file that "kubeadm init" and "kubeadm join" generates at runtime, populating the KUBELET_KUBEADM_ARGS variable dynamically
EnvironmentFile=-/var/lib/kubelet/kubeadm-flags.env
# This is a file that the user can use for overrides of the kubelet args as a last resort. Preferably, the user should use
# the .NodeRegistration.KubeletExtraArgs object in the configuration files instead. KUBELET_EXTRA_ARGS should be sourced from this file.
EnvironmentFile=-/etc/default/kubelet
ExecStart=
ExecStart=/usr/bin/kubelet $KUBELET_KUBECONFIG_ARGS $KUBELET_CONFIG_ARGS $KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS
root@node01:/etc/systemd/system/kubelet.service.d# 


root@controlplane:~# kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
controlplane   Ready    control-plane,master   27m   v1.20.0
node01         Ready    <none>                 27m   v1.20.0
root@controlplane:~# 


root@node01:/var/lib/kubelet# service kubelet status
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Wed 2021-09-29 00:18:25 UTC; 17s ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 12506 (kubelet)
    Tasks: 35 (limit: 5529)
   CGroup: /system.slice/kubelet.service
           └─12506 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --k

Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.690184   12506 topology_manager.go:187] [topolo
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.789994   12506 reconciler.go:224] operationExec
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.790057   12506 reconciler.go:224] operationExec
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.790076   12506 reconciler.go:224] operationExec
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.790100   12506 reconciler.go:224] operationExec
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.790117   12506 reconciler.go:224] operationExec
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.790133   12506 reconciler.go:224] operationExec
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.790206   12506 reconciler.go:224] operationExec
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.790322   12506 reconciler.go:224] operationExec
Sep 29 00:18:27 node01 kubelet[12506]: I0929 00:18:27.790363   12506 reconciler.go:157] Reconciler: s
root@node01:/var/lib/kubelet#



root@controlplane:~# kubectl get nodes
NAME           STATUS     ROLES                  AGE   VERSION
controlplane   Ready      control-plane,master   31m   v1.20.0
node01         NotReady   <none>                 30m   v1.20.0
root@controlplane:~# 

fix kubelet service.

root@controlplane:~# kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
controlplane   Ready    control-plane,master   38m   v1.20.0
node01         Ready    <none>                 38m   v1.20.0
root@controlplane:~# 


always use "--no-pager" option with journalctl to see full readable logs

root@node01:/etc/kubernetes/pki# journalctl -u kubelet --no-pager -f
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.152194   16383 eviction_manager.go:260] eviction manager: failed to get summary stats: failed to get node info: node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.162151   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.262354   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.362600   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.462875   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.563084   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.663298   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.763502   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.863697   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:56 node01 kubelet[16383]: I0929 00:35:56.907813   16383 kubelet_node_status.go:71] Attempting to register node node01
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.909407   16383 kubelet_node_status.go:93] Unable to register node "node01" with API server: Post "https://controlplane:6553/api/v1/nodes": dial tcp 10.53.130.2:6553: connect: connection refused
Sep 29 00:35:56 node01 kubelet[16383]: E0929 00:35:56.963833   16383 kubelet.go:2240] node "node01" not found
Sep 29 00:35:57 node01 kubelet[16383]: E0929 00:35:57.064046   16383 kubelet.go:2240] node "node01" not found




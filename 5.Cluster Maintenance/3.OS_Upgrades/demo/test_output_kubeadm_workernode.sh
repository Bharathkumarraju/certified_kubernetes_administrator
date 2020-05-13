master $ kubectl drain node01 --ignore-daemonsets
node/node01 cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/kube-proxy-gjptt, kube-system/weave-net-bctrm
evicting pod "coredns-6955765f44-tgm9l"
evicting pod "red-5dc59c9654-7kf26"
evicting pod "coredns-6955765f44-sd5f5"
evicting pod "red-5dc59c9654-7hr8l"
pod/red-5dc59c9654-7hr8l evicted
pod/red-5dc59c9654-7kf26 evicted
pod/coredns-6955765f44-tgm9l evicted
pod/coredns-6955765f44-sd5f5 evicted
node/node01 evicted
master $

node01 $ apt-get install -y kubeadm=1.17.0-00
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following package was automatically installed and is no longer required:
  libuv1
Use 'apt autoremove' to remove it.
The following packages will be upgraded:
  kubeadm
1 to upgrade, 0 to newly install, 0 to remove and 244 not to upgrade.
Need to get 8,059 kB of archives.
After this operation, 4,903 kB disk space will be freed.
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubeadm amd64 1.17.0-00 [8,059 kB]
Fetched 8,059 kB in 0s (9,330 kB/s)
(Reading database ... 248903 files and directories currently installed.)
Preparing to unpack .../kubeadm_1.17.0-00_amd64.deb ...
Unpacking kubeadm (1.17.0-00) over (1.16.0-00) ...
Setting up kubeadm (1.17.0-00) ...
node01 $


node01 $ kubeadm upgrade node config --kubelet-version v1.17.0
Command "config" is deprecated, use "kubeadm upgrade node" instead
[upgrade] Reading configuration from the cluster...
[upgrade] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.17" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[upgrade] The configuration for this node was successfully updated!
[upgrade] Now you should go ahead and upgrade the kubelet package using your package manager.
node01 $

node01 $ apt-get install kubelet=1.17.0-00
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following package was automatically installed and is no longer required:
  libuv1
Use 'apt autoremove' to remove it.
The following packages will be upgraded:
  kubelet
1 to upgrade, 0 to newly install, 0 to remove and 244 not to upgrade.
Need to get 19.2 MB of archives.
After this operation, 11.6 MB disk space will be freed.
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.17.0-00 [19.2 MB]
Fetched 19.2 MB in 0s (27.0 MB/s)
(Reading database ... 248903 files and directories currently installed.)
Preparing to unpack .../kubelet_1.17.0-00_amd64.deb ...
Unpacking kubelet (1.17.0-00) over (1.16.0-00) ...
Setting up kubelet (1.17.0-00) ...


node01 $ systemctl restart kubelet


node01 $ systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Wed 2020-05-13 01:25:31 UTC; 8s ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 27404 (kubelet)
    Tasks: 15
   Memory: 21.1M
      CPU: 475ms
   CGroup: /system.slice/kubelet.service
           └─27404 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/
node01 $

master $ kubectl drain master --ignore-daemonsets
node/master already cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/kube-proxy-rnj44, kube-system/weave-net-8v7kl
evicting pod "coredns-5644d7b6d9-glwxt"
evicting pod "red-5dc59c9654-ghk7w"
pod/red-5dc59c9654-ghk7w evicted
pod/coredns-5644d7b6d9-glwxt evicted
node/master evicted
master $

master $ kubeadm upgrade apply v1.17.0
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[preflight] Running pre-flight checks.
[upgrade] Making sure the cluster is healthy:
[upgrade/version] You have chosen to change the cluster version to "v1.17.0"
[upgrade/versions] Cluster version: v1.16.0
[upgrade/versions] kubeadm version: v1.17.0
[upgrade/confirm] Are you sure you want to proceed with the upgrade? [y/N]: y
[upgrade/prepull] Will prepull images for components [kube-apiserver kube-controller-manager kube-scheduler etcd]
[upgrade/prepull] Prepulling image for component etcd.
[upgrade/prepull] Prepulling image for component kube-apiserver.
[upgrade/prepull] Prepulling image for component kube-controller-manager.
[upgrade/prepull] Prepulling image for component kube-scheduler.
[apiclient] Found 1 Pods for label selector k8s-app=upgrade-prepull-kube-apiserver
[apiclient] Found 0 Pods for label selector k8s-app=upgrade-prepull-kube-scheduler
[apiclient] Found 1 Pods for label selector k8s-app=upgrade-prepull-kube-controller-manager
[apiclient] Found 0 Pods for label selector k8s-app=upgrade-prepull-etcd
[apiclient] Found 1 Pods for label selector k8s-app=upgrade-prepull-etcd
[apiclient] Found 1 Pods for label selector k8s-app=upgrade-prepull-kube-scheduler
[upgrade/prepull] Prepulled image for component etcd.
[upgrade/prepull] Prepulled image for component kube-controller-manager.
[upgrade/prepull] Prepulled image for component kube-scheduler.
[upgrade/prepull] Prepulled image for component kube-apiserver.
[upgrade/prepull] Successfully prepulled the images for all the control plane components
[upgrade/apply] Upgrading your Static Pod-hosted control plane to version "v1.17.0"...
Static pod: kube-apiserver-master hash: 51a0db272a0c3336bbe8c0fc549f9a89
Static pod: kube-controller-manager-master hash: 5c21306a65dd081e1f8bbec6db1a1610
Static pod: kube-scheduler-master hash: c18ee741ac4ad7b2bfda7d88116f3047
[upgrade/etcd] Upgrading to TLS for etcd
Static pod: etcd-master hash: 8cf60e5c25491988258fdc548a315400
[upgrade/staticpods] Preparing for "etcd" upgrade
[upgrade/staticpods] Renewing etcd-server certificate
[upgrade/staticpods] Renewing etcd-peer certificate
[upgrade/staticpods] Renewing etcd-healthcheck-client certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/etcd.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2020-05-13-01-05-27/etcd.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
Static pod: etcd-master hash: 8cf60e5c25491988258fdc548a315400
Static pod: etcd-master hash: 8cf60e5c25491988258fdc548a315400
Static pod: etcd-master hash: 9a229e57a9644bc869a3435f7529c26e
[apiclient] Found 1 Pods for label selector component=etcd
[upgrade/staticpods] Component "etcd" upgraded successfully!
[upgrade/etcd] Waiting for etcd to become available
[upgrade/staticpods] Writing new Static Pod manifests to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests960648558"
W0513 01:05:32.583684    8384 manifests.go:214] the default kube-apiserver authorization-mode is "Node,RBAC"; using "Node,RBAC"
[upgrade/staticpods] Preparing for "kube-apiserver" upgrade
[upgrade/staticpods] Renewing apiserver certificate
[upgrade/staticpods] Renewing apiserver-kubelet-client certificate
[upgrade/staticpods] Renewing front-proxy-client certificate
[upgrade/staticpods] Renewing apiserver-etcd-client certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-apiserver.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2020-05-13-01-05-27/kube-apiserver.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
Static pod: kube-apiserver-master hash: 51a0db272a0c3336bbe8c0fc549f9a89
Static pod: kube-apiserver-master hash: 51a0db272a0c3336bbe8c0fc549f9a89
Static pod: kube-apiserver-master hash: 8dc2d93ffaa0daabc64bff4571e2171e
[apiclient] Found 1 Pods for label selector component=kube-apiserver
[upgrade/staticpods] Component "kube-apiserver" upgraded successfully!
[upgrade/staticpods] Preparing for "kube-controller-manager" upgrade
[upgrade/staticpods] Renewing controller-manager.conf certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-controller-manager.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2020-05-13-01-05-27/kube-controller-manager.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
Static pod: kube-controller-manager-master hash: 5c21306a65dd081e1f8bbec6db1a1610
Static pod: kube-controller-manager-master hash: e7bc401dca2029dd58a272da618fc389
[apiclient] Found 1 Pods for label selector component=kube-controller-manager
[upgrade/staticpods] Component "kube-controller-manager" upgraded successfully!
[upgrade/staticpods] Preparing for "kube-scheduler" upgrade
[upgrade/staticpods] Renewing scheduler.conf certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-scheduler.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2020-05-13-01-05-27/kube-scheduler.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
Static pod: kube-scheduler-master hash: c18ee741ac4ad7b2bfda7d88116f3047
Static pod: kube-scheduler-master hash: ff67867321338ffd885039e188f6b424
[apiclient] Found 1 Pods for label selector component=kube-scheduler
[upgrade/staticpods] Component "kube-scheduler" upgraded successfully!
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.17" in namespace kube-system with the configuration for the kubelets in the cluster
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.17" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[addons]: Migrating CoreDNS Corefile
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

[upgrade/successful] SUCCESS! Your cluster was upgraded to "v1.17.0". Enjoy!

[upgrade/kubelet] Now that your control plane is upgraded, please proceed with upgrading your kubelets if you havent already done so.
master $


master $ apt-get install -y kubelet=1.17.0-00
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following package was automatically installed and is no longer required:
  libuv1
Use 'apt autoremove' to remove it.
The following packages will be upgraded:
  kubelet
1 to upgrade, 0 to newly install, 0 to remove and 245 not to upgrade.
Need to get 19.2 MB of archives.
After this operation, 11.6 MB disk space will be freed.
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.17.0-00 [19.2 MB]
Fetched 19.2 MB in 1s (16.2 MB/s)
(Reading database ... 248896 files and directories currently installed.)
Preparing to unpack .../kubelet_1.17.0-00_amd64.deb ...
Unpacking kubelet (1.17.0-00) over (1.16.0-00) ...
Setting up kubelet (1.17.0-00) ...
master $



master $ systemctl restart kubelet
master $ systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Wed 2020-05-13 01:08:15 UTC; 9s ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 11643 (kubelet)
    Tasks: 16
   Memory: 23.8M
      CPU: 701ms
   CGroup: /system.slice/kubelet.service
           └─11643 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/

May 13 01:08:18 master kubelet[11643]: I0513 01:08:18.976618   11643 reconciler.go:209] operationExecutor.VerifyControllerAttachedVolume started for v
May 13 01:08:18 master kubelet[11643]: I0513 01:08:18.976649   11643 reconciler.go:209] operationExecutor.VerifyControllerAttachedVolume started for v
May 13 01:08:18 master kubelet[11643]: I0513 01:08:18.976666   11643 reconciler.go:209] operationExecutor.VerifyControllerAttachedVolume started for v
May 13 01:08:18 master kubelet[11643]: I0513 01:08:18.976735   11643 reconciler.go:209] operationExecutor.VerifyControllerAttachedVolume started for v
May 13 01:08:19 master kubelet[11643]: I0513 01:08:19.078044   11643 reconciler.go:209] operationExecutor.VerifyControllerAttachedVolume started for v
May 13 01:08:19 master kubelet[11643]: I0513 01:08:19.078437   11643 reconciler.go:209] operationExecutor.VerifyControllerAttachedVolume started for v
May 13 01:08:19 master kubelet[11643]: I0513 01:08:19.078519   11643 reconciler.go:209] operationExecutor.VerifyControllerAttachedVolume started for v
May 13 01:08:19 master kubelet[11643]: I0513 01:08:19.078762   11643 reconciler.go:209] operationExecutor.VerifyControllerAttachedVolume started for v
master $
https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

kubectl drain node01 --ignore-daemonsets ==> This command should run on controlplane node(Not in the worker node)


root@controlplane:~# kubectl get nodes
NAME           STATUS   ROLES    AGE   VERSION
controlplane   Ready    master   26m   v1.19.0
node01         Ready    <none>   25m   v1.19.0
root@controlplane:~# 

root@controlplane:~# cat /etc/*release*
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=18.04
DISTRIB_CODENAME=bionic
DISTRIB_DESCRIPTION="Ubuntu 18.04.5 LTS"
NAME="Ubuntu"
VERSION="18.04.5 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.5 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
root@controlplane:~# 



root@controlplane:~# kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
blue-746c87566d-8tbgw   1/1     Running   0          83s   10.244.0.5   controlplane   <none>           <none>
blue-746c87566d-gjtzg   1/1     Running   0          84s   10.244.0.4   controlplane   <none>           <none>
blue-746c87566d-kn5pv   1/1     Running   0          84s   10.244.1.3   node01         <none>           <none>
blue-746c87566d-rnbvw   1/1     Running   0          84s   10.244.1.4   node01         <none>           <none>
blue-746c87566d-tp4m7   1/1     Running   0          83s   10.244.1.5   node01         <none>           <none>
simple-webapp-1         1/1     Running   0          84s   10.244.1.2   node01         <none>           <none>
root@controlplane:~# kubectl describe node node01 | grep -i taint
Taints:             <none>
root@controlplane:~# kubectl describe node controlplane | grep -i taint
Taints:             <none>
root@controlplane:~# 



root@controlplane:~# kubectl get pods
NAME                    READY   STATUS    RESTARTS   AGE
blue-746c87566d-8tbgw   1/1     Running   0          2m25s
blue-746c87566d-gjtzg   1/1     Running   0          2m26s
blue-746c87566d-kn5pv   1/1     Running   0          2m26s
blue-746c87566d-rnbvw   1/1     Running   0          2m26s
blue-746c87566d-tp4m7   1/1     Running   0          2m25s
simple-webapp-1         1/1     Running   0          2m26s
root@controlplane:~# kubectl get deploy
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
blue   5/5     5            5           2m35s
root@controlplane:~# 




root@controlplane:~# kubeadm upgrade plan
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: v1.19.0
[upgrade/versions] kubeadm version: v1.19.0
I0921 13:54:49.753378   24236 version.go:252] remote version is much newer: v1.22.2; falling back to: stable-1.19
[upgrade/versions] Latest stable version: v1.19.15
[upgrade/versions] Latest stable version: v1.19.15
[upgrade/versions] Latest version in the v1.19 series: v1.19.15
[upgrade/versions] Latest version in the v1.19 series: v1.19.15

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   CURRENT       AVAILABLE
kubelet     2 x v1.19.0   v1.19.15

Upgrade to the latest version in the v1.19 series:

COMPONENT                 CURRENT   AVAILABLE
kube-apiserver            v1.19.0   v1.19.15
kube-controller-manager   v1.19.0   v1.19.15
kube-scheduler            v1.19.0   v1.19.15
kube-proxy                v1.19.0   v1.19.15
CoreDNS                   1.7.0     1.7.0
etcd                      3.4.9-1   3.4.9-1

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.19.15

Note: Before you can perform this upgrade, you have to update kubeadm to v1.19.15.

_____________________________________________________________________


The table below shows the current state of component configs as understood by this version of kubeadm.
Configs that have a "yes" mark in the "MANUAL UPGRADE REQUIRED" column require manual config upgrade or
resetting to kubeadm defaults before a successful upgrade can be performed. The version to manually
upgrade to is denoted in the "PREFERRED VERSION" column.

API GROUP                 CURRENT VERSION   PREFERRED VERSION   MANUAL UPGRADE REQUIRED
kubeproxy.config.k8s.io   v1alpha1          v1alpha1            no
kubelet.config.k8s.io     v1beta1           v1beta1             no
_____________________________________________________________________

root@controlplane:~# 



root@controlplane:~# kubectl drain controlplane --ignore-daemonsets
node/controlplane cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/kube-flannel-ds-jsvcl, kube-system/kube-proxy-mqz2l
evicting pod default/blue-746c87566d-8tbgw
evicting pod default/blue-746c87566d-gjtzg
evicting pod kube-system/coredns-f9fd979d6-5sgvw
evicting pod kube-system/coredns-f9fd979d6-6k5kr
pod/blue-746c87566d-gjtzg evicted
pod/coredns-f9fd979d6-5sgvw evicted
pod/blue-746c87566d-8tbgw evicted
pod/coredns-f9fd979d6-6k5kr evicted
node/controlplane evicted




Upgrade the controlplane components to exact version v1.20.0
                      Controlplane_node:
---------------------------------------------------------------->


Upgrade kubeadm tool (if not already), then the master components, and finally the kubelet. 
Practice referring to the kubernetes documentation page. Note: While upgrading kubelet, 
if you hit dependency issue while running the apt-get upgrade kubelet command, use the apt install kubelet=1.20.0-00 command instead



root@controlplane:~# apt update
Hit:2 https://download.docker.com/linux/ubuntu bionic InRelease                                                 
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [9383 B]                                
Hit:3 http://security.ubuntu.com/ubuntu bionic-security InRelease                                               
Hit:4 http://archive.ubuntu.com/ubuntu bionic InRelease                                                         
Hit:5 http://archive.ubuntu.com/ubuntu bionic-updates InRelease
Hit:6 http://archive.ubuntu.com/ubuntu bionic-backports InRelease
Fetched 9383 B in 3s (3194 B/s)
Reading package lists... Done
Building dependency tree       
Reading state information... Done
29 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@controlplane:~# 


root@controlplane:~# apt install kubeadm=1.20.0-00 -y
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following held packages will be changed:
  kubeadm
The following packages will be upgraded:
  kubeadm
1 upgraded, 0 newly installed, 0 to remove and 28 not upgraded.
Need to get 7707 kB of archives.
After this operation, 111 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubeadm amd64 1.20.0-00 [7707 kB]
Fetched 7707 kB in 0s (16.8 MB/s)
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 15149 files and directories currently installed.)
Preparing to unpack .../kubeadm_1.20.0-00_amd64.deb ...
Unpacking kubeadm (1.20.0-00) over (1.19.0-00) ...
Setting up kubeadm (1.20.0-00) ...
root@controlplane:~# 



root@controlplane:~# kubeadm upgrade apply v1.20.0
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks.
[upgrade] Running cluster health checks
[upgrade/version] You have chosen to change the cluster version to "v1.20.0"
[upgrade/versions] Cluster version: v1.19.0
[upgrade/versions] kubeadm version: v1.20.0
[upgrade/confirm] Are you sure you want to proceed with the upgrade? [y/N]: y
[upgrade/prepull] Pulling images required for setting up a Kubernetes cluster
[upgrade/prepull] This might take a minute or two, depending on the speed of your internet connection
[upgrade/prepull] You can also perform this action in beforehand using 'kubeadm config images pull'
[upgrade/apply] Upgrading your Static Pod-hosted control plane to version "v1.20.0"...
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-controller-manager-controlplane hash: f6a9bf2865b2fe580f39f07ed872106b
Static pod: kube-scheduler-controlplane hash: 5146743ebb284c11f03dc85146799d8b
[upgrade/etcd] Upgrading to TLS for etcd
Static pod: etcd-controlplane hash: 9329872a3917b49cc78c2b1ed2e6439f
[upgrade/staticpods] Preparing for "etcd" upgrade
[upgrade/staticpods] Renewing etcd-server certificate
[upgrade/staticpods] Renewing etcd-peer certificate
[upgrade/staticpods] Renewing etcd-healthcheck-client certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/etcd.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2021-09-21-14-05-49/etcd.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
Static pod: etcd-controlplane hash: 9329872a3917b49cc78c2b1ed2e6439f
Static pod: etcd-controlplane hash: 3cde3d9caab5089311d6d64f30417d52
[apiclient] Found 1 Pods for label selector component=etcd
[upgrade/staticpods] Component "etcd" upgraded successfully!
[upgrade/etcd] Waiting for etcd to become available
[upgrade/staticpods] Writing new Static Pod manifests to "/etc/kubernetes/tmp/kubeadm-upgraded-manifests363947080"
[upgrade/staticpods] Preparing for "kube-apiserver" upgrade
[upgrade/staticpods] Renewing apiserver certificate
[upgrade/staticpods] Renewing apiserver-kubelet-client certificate
[upgrade/staticpods] Renewing front-proxy-client certificate
[upgrade/staticpods] Renewing apiserver-etcd-client certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-apiserver.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2021-09-21-14-05-49/kube-apiserver.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: c55bca267c1fd7f395e6c47f180272bb
Static pod: kube-apiserver-controlplane hash: cb4f658ebd1182de2f60cf8a9d8181c5
[apiclient] Found 1 Pods for label selector component=kube-apiserver
[upgrade/staticpods] Component "kube-apiserver" upgraded successfully!
[upgrade/staticpods] Preparing for "kube-controller-manager" upgrade
[upgrade/staticpods] Renewing controller-manager.conf certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-controller-manager.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2021-09-21-14-05-49/kube-controller-manager.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
Static pod: kube-controller-manager-controlplane hash: f6a9bf2865b2fe580f39f07ed872106b
Static pod: kube-controller-manager-controlplane hash: a875134e700993a22f67999011829566
[apiclient] Found 1 Pods for label selector component=kube-controller-manager
[upgrade/staticpods] Component "kube-controller-manager" upgraded successfully!
[upgrade/staticpods] Preparing for "kube-scheduler" upgrade
[upgrade/staticpods] Renewing scheduler.conf certificate
[upgrade/staticpods] Moved new manifest to "/etc/kubernetes/manifests/kube-scheduler.yaml" and backed up old manifest to "/etc/kubernetes/tmp/kubeadm-backup-manifests-2021-09-21-14-05-49/kube-scheduler.yaml"
[upgrade/staticpods] Waiting for the kubelet to restart the component
[upgrade/staticpods] This might take a minute or longer depending on the component/version gap (timeout 5m0s)
Static pod: kube-scheduler-controlplane hash: 5146743ebb284c11f03dc85146799d8b
Static pod: kube-scheduler-controlplane hash: 81d2d21449d64d5e6d5e9069a7ca99ed
[apiclient] Found 1 Pods for label selector component=kube-scheduler
[upgrade/staticpods] Component "kube-scheduler" upgraded successfully!
[upgrade/postupgrade] Applying label node-role.kubernetes.io/control-plane='' to Nodes with label node-role.kubernetes.io/master='' (deprecated)
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.20" in namespace kube-system with the configuration for the kubelets in the cluster
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to get nodes
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

[upgrade/successful] SUCCESS! Your cluster was upgraded to "v1.20.0". Enjoy!

[upgrade/kubelet] Now that your control plane is upgraded, please proceed with upgrading your kubelets if you havent already done so.
root@controlplane:~# 


root@controlplane:~# apt install kubelet=1.20.0-00
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following held packages will be changed:
  kubelet
The following packages will be upgraded:
  kubelet
1 upgraded, 0 newly installed, 0 to remove and 28 not upgraded.
Need to get 18.8 MB of archives.
After this operation, 4000 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.20.0-00 [18.8 MB]
Fetched 18.8 MB in 1s (20.4 MB/s)  
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 15149 files and directories currently installed.)
Preparing to unpack .../kubelet_1.20.0-00_amd64.deb ...
/usr/sbin/policy-rc.d returned 101, not running 'stop kubelet.service'
Unpacking kubelet (1.20.0-00) over (1.19.0-00) ...
Setting up kubelet (1.20.0-00) ...
/usr/sbin/policy-rc.d returned 101, not running 'start kubelet.service'
root@controlplane:~#


root@controlplane:~# systemctl restart kubelet
root@controlplane:~# systemctl status kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Tue 2021-09-21 14:14:03 UTC; 12s ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 2585 (kubelet)
    Tasks: 30 (limit: 5529)
   CGroup: /system.slice/kubelet.service
           └─2585 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/et

Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414706    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414739    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414766    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414829    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414879    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414901    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414923    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414949    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.414977    2585 reconciler.go:224] operationExecutor.Ve
Sep 21 14:14:08 controlplane kubelet[2585]: I0921 14:14:08.415051    2585 reconciler.go:157] Reconciler: start to
root@controlplane:~# 


root@controlplane:~# kubectl uncordon controlplane
node/controlplane uncordoned
root@controlplane:~# 


Drain the worker node of the workloads and mark it UnSchedulable
                      Worker_node:
---------------------------------------------------------------->

root@controlplane:~# kubectl drain node01 --ignore-daemonsets --force
node/node01 already cordoned
WARNING: deleting Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet: default/simple-webapp-1; ignoring DaemonSet-managed Pods: kube-system/kube-flannel-ds-k6dmc, kube-system/kube-proxy-7jdgp
evicting pod default/blue-746c87566d-kn5pv
evicting pod default/blue-746c87566d-c2ct8
evicting pod default/blue-746c87566d-rnbvw
evicting pod default/simple-webapp-1
evicting pod default/blue-746c87566d-xzkw5
evicting pod kube-system/coredns-74ff55c5b-mfqvt
evicting pod kube-system/coredns-74ff55c5b-w4n4s
evicting pod default/blue-746c87566d-tp4m7
I0921 14:17:46.427327    4653 request.go:645] Throttling request took 1.009198612s, request: GET:https://controlplane:6443/api/v1/namespaces/default/pods/blue-746c87566d-xzkw5
pod/blue-746c87566d-tp4m7 evicted
pod/blue-746c87566d-kn5pv evicted
pod/blue-746c87566d-rnbvw evicted
pod/coredns-74ff55c5b-mfqvt evicted
pod/blue-746c87566d-c2ct8 evicted
pod/coredns-74ff55c5b-w4n4s evicted
pod/blue-746c87566d-xzkw5 evicted
pod/simple-webapp-1 evicted
node/node01 evicted
root@controlplane:~#



root@node01:~# apt update -y
Get:2 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]                                     
Get:3 https://download.docker.com/linux/ubuntu bionic InRelease [64.4 kB]                                       
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial InRelease [9383 B]                                
Get:4 http://archive.ubuntu.com/ubuntu bionic InRelease [242 kB]                   
Get:5 http://security.ubuntu.com/ubuntu bionic-security/multiverse amd64 Packages [26.7 kB]
Get:6 http://security.ubuntu.com/ubuntu bionic-security/universe amd64 Packages [1428 kB]                  
Get:7 https://download.docker.com/linux/ubuntu bionic/stable amd64 Packages [22.4 kB]        
Get:8 http://security.ubuntu.com/ubuntu bionic-security/restricted amd64 Packages [567 kB]                      
Get:9 http://archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]                               
Get:10 http://security.ubuntu.com/ubuntu bionic-security/main amd64 Packages [2326 kB]                          
Get:11 http://archive.ubuntu.com/ubuntu bionic-backports InRelease [74.6 kB]                              
Get:12 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 Packages [50.0 kB]                    
Get:13 http://archive.ubuntu.com/ubuntu bionic/restricted amd64 Packages [13.5 kB] 
Get:14 http://archive.ubuntu.com/ubuntu bionic/multiverse amd64 Packages [186 kB]     
Get:15 http://archive.ubuntu.com/ubuntu bionic/universe amd64 Packages [11.3 MB]
Get:16 http://archive.ubuntu.com/ubuntu bionic/main amd64 Packages [1344 kB]          
Get:17 http://archive.ubuntu.com/ubuntu bionic-updates/restricted amd64 Packages [600 kB]
Get:18 http://archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages [2202 kB]
Get:19 http://archive.ubuntu.com/ubuntu bionic-updates/multiverse amd64 Packages [34.4 kB]
Get:20 http://archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [2761 kB]
Get:21 http://archive.ubuntu.com/ubuntu bionic-backports/universe amd64 Packages [11.4 kB]
Get:22 http://archive.ubuntu.com/ubuntu bionic-backports/main amd64 Packages [11.3 kB]
Fetched 23.5 MB in 6s (3830 kB/s)                                                                               
Reading package lists... Done
Building dependency tree       
Reading state information... Done
35 packages can be upgraded. Run 'apt list --upgradable' to see them.
root@node01:~# 


root@node01:~# apt install kubeadm=1.20.0-00
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following held packages will be changed:
  kubeadm
The following packages will be upgraded:
  kubeadm
1 upgraded, 0 newly installed, 0 to remove and 34 not upgraded.
Need to get 7707 kB of archives.
After this operation, 111 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubeadm amd64 1.20.0-00 [7707 kB]
Fetched 7707 kB in 0s (34.3 MB/s)
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 15013 files and directories currently installed.)
Preparing to unpack .../kubeadm_1.20.0-00_amd64.deb ...
Unpacking kubeadm (1.20.0-00) over (1.19.0-00) ...
Setting up kubeadm (1.20.0-00) ...
root@node01:~# 

root@node01:~# kubeadm upgrade node
[upgrade] Reading configuration from the cluster...
[upgrade] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[preflight] Running pre-flight checks
[preflight] Skipping prepull. Not a control plane node.
[upgrade] Skipping phase. Not a control plane node.
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[upgrade] The configuration for this node was successfully updated!
[upgrade] Now you should go ahead and upgrade the kubelet package using your package manager.
root@node01:~#



root@node01:~# apt install kubelet=1.20.0-00
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following held packages will be changed:
  kubelet
The following packages will be upgraded:
  kubelet
1 upgraded, 0 newly installed, 0 to remove and 34 not upgraded.
Need to get 18.8 MB of archives.
After this operation, 4000 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main amd64 kubelet amd64 1.20.0-00 [18.8 MB]
Fetched 18.8 MB in 1s (31.1 MB/s)
debconf: delaying package configuration, since apt-utils is not installed
(Reading database ... 15013 files and directories currently installed.)
Preparing to unpack .../kubelet_1.20.0-00_amd64.deb ...
/usr/sbin/policy-rc.d returned 101, not running 'stop kubelet.service'
Unpacking kubelet (1.20.0-00) over (1.19.0-00) ...
Setting up kubelet (1.20.0-00) ...
/usr/sbin/policy-rc.d returned 101, not running 'start kubelet.service'
root@node01:~#


root@node01:~# systemctl restart kubelet
root@node01:~# systemctl status  kubelet
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Tue 2021-09-21 14:28:24 UTC; 13s ago
     Docs: https://kubernetes.io/docs/home/
 Main PID: 46591 (kubelet)
    Tasks: 32 (limit: 7372)
   CGroup: /system.slice/kubelet.service
           └─46591 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/e

Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.514366   46591 topology_manager.go:187] [topologymanager] T
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.521710   46591 reconciler.go:224] operationExecutor.VerifyC
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.521780   46591 reconciler.go:224] operationExecutor.VerifyC
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.521806   46591 reconciler.go:224] operationExecutor.VerifyC
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.521830   46591 reconciler.go:224] operationExecutor.VerifyC
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.521910   46591 reconciler.go:224] operationExecutor.VerifyC
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.521953   46591 reconciler.go:224] operationExecutor.VerifyC
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.521981   46591 reconciler.go:224] operationExecutor.VerifyC
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.522015   46591 reconciler.go:224] operationExecutor.VerifyC
Sep 21 14:28:26 node01 kubelet[46591]: I0921 14:28:26.522052   46591 reconciler.go:157] Reconciler: start to sync
root@node01:~# 



root@controlplane:~# kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
controlplane   Ready    control-plane,master   69m   v1.20.0
node01         Ready    <none>                 69m   v1.20.0
root@controlplane:~# 


master $ kubectl get nodes -o wide
NAME     STATUS   ROLES    AGE    VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
master   Ready    master   112s   v1.16.0   172.17.0.15   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
node01   Ready    <none>   82s    v1.16.0   172.17.0.16   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
master $




Question1:
---------->
We will be upgrading the master node first. Drain the master node of workloads and mark it UnSchedulable

Answer:
-------->
master $ kubectl drain master --ignore-daemonsets
node/master cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/kube-proxy-4tggr, kube-system/weave-net-g5ckd
evicting pod "coredns-5644d7b6d9-v5z8m"
evicting pod "red-5dc59c9654-ksl5l"
pod/coredns-5644d7b6d9-v5z8m evicted
pod/red-5dc59c9654-ksl5l evicted
node/master evicted
master $


Question2:
------------>
Upgrade the master components to exact version v1.17.0

Upgrade kubeadm tool (if not already), then the master components, and finally the kubelet.
Practice referring to the kubernetes documentation page.
Note: While upgrading kubelet, if you hit dependency issue
while running the apt-get upgrade kubelet command, use the apt install kubelet=1.17.0-00 command instead

Answer2
---------->
master $ apt-get install kubeadm=1.17.0-00
master $ kubeadm upgrade apply v1.17.0 --ignore-preflight-errors=all
master $ apt-get install kubelet=1.17.0-00
master $ systemctl restart kubelet
master $ kubectl uncordon master

master $ kubectl get nodes -o wide
NAME     STATUS   ROLES    AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
master   Ready    master   10m     v1.17.0   172.17.0.47   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
node01   Ready    <none>   9m44s   v1.16.0   172.17.0.48   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
master $

Question3:
------------->
Upgrade the worker node

Answer:
-------->
master $ kubectl get nodes -o wide
NAME     STATUS                     ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
master   Ready                      master   15m   v1.17.0   172.17.0.47   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
node01   Ready,SchedulingDisabled   <none>   15m   v1.16.0   172.17.0.48   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
master $


master $ kubectl drain node01 --ignore-daemonsets
master $ ssh 172.17.0.48
node01 $ apt-get install -y kubeadm=1.17.0
node01 $ kubeadm upgrade node config --kubelet-version v1.17.0
node01 $ apt-get install -y kubelet=1.17.0
node01 $ systemctl restart kubelet

echo "Go to master node again"

master $ kubectl uncordon node01
node/node01 uncordoned
master $ kubectl get nodes -o wide
NAME     STATUS   ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
master   Ready    master   27m   v1.17.0   172.17.0.47   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
node01   Ready    <none>   27m   v1.17.0   172.17.0.48   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
master $




On the mastre node:
------------------------------------------------->
$ kubeadm upgrade plan
echo "First upgrade the kubeadm tool itself"
echo "We have to upgrade one minor version at a time"

$ apt-get upgrade -y kubeadm=1.12.0-00

$ kubeadm upgrade apply v1.12.0
Note that control plane is upgraded.please proceed with upgrading the kubelets.

$ apt-get upgrade -y kubelet=1.12.0-00

$ systemctl restart kubelet

Now upgrade the worker nodes:
-------------------------------->
Upgrade strategy is ...upgrade one node at a time.
Node-01:
-------->
1.First we need to move all workloads to another worker nodes.
$ kubectl drain node-01
$ apt-get upgrade -y kubeadm=1.12.0-00
$ apt-get upgrade -y kubelet=1.12.0-00
$ kubeadm upgrade node config --kubelet-version v1.12.0
$ systemctl restart kubelet
$ kubectl uncordon node-01


Node-02:
-------->
1.First we need to move all workloads to another worker nodes.
$ kubectl drain node-02
$ apt-get upgrade -y kubeadm=1.12.0-00
$ apt-get upgrade -y kubelet=1.12.0-00
$ kubeadm upgrade node config --kubelet-version v1.12.0
$ systemctl restart kubelet
$ kubectl uncordon node-02

Node-03:
-------->
1.First we need to move all workloads to another worker nodes.
$ kubectl drain node-03
$ apt-get upgrade -y kubeadm=1.12.0-00
$ apt-get upgrade -y kubelet=1.12.0-00
$ kubeadm upgrade node config --kubelet-version v1.12.0
$ systemctl restart kubelet
$ kubectl uncordon node-03




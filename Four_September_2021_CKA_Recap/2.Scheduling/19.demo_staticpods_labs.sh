what are the pods created as static pods -- static pods normally ends with name of the node.

root@controlplane:~# kubectl get pods --all-namespaces
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
kube-system   coredns-74ff55c5b-d74qv                1/1     Running   0          30m
kube-system   coredns-74ff55c5b-gw2ht                1/1     Running   0          30m
kube-system   etcd-controlplane                      1/1     Running   0          30m
kube-system   kube-apiserver-controlplane            1/1     Running   0          30m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          30m
kube-system   kube-flannel-ds-572ns                  1/1     Running   0          30m
kube-system   kube-flannel-ds-lbq9j                  1/1     Running   0          30m
kube-system   kube-proxy-czxw2                       1/1     Running   0          30m
kube-system   kube-proxy-xghtc                       1/1     Running   0          30m
kube-system   kube-scheduler-controlplane            1/1     Running   0          30m
root@controlplane:~# kubectl get pods --all-namespaces | awk '{print $2}' | grep "controlplane$"
etcd-controlplane
kube-apiserver-controlplane
kube-controller-manager-controlplane
kube-scheduler-controlplane
root@controlplane:~# 


On which nodes are the static pods created currently?

root@controlplane:~# kubectl get pods -o wide --all-namespaces | grep -i controlplane
kube-system   etcd-controlplane                      1/1     Running   0          33m   10.55.152.6   controlplane   <none>           <none>
kube-system   kube-apiserver-controlplane            1/1     Running   0          33m   10.55.152.6   controlplane   <none>           <none>
kube-system   kube-controller-manager-controlplane   1/1     Running   0          33m   10.55.152.6   controlplane   <none>           <none>
kube-system   kube-scheduler-controlplane            1/1     Running   0          33m   10.55.152.6   controlplane   <none>           <none>
root@controlplane:~# 

What is the path of the directory holding the static pod definition files?

root@controlplane:~# ps auxwww | grep -i "kubelet "
root      4938  0.0  0.0 3929104 106740 ?      Ssl  00:10   2:11 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.2
root     25099  0.0  0.0  11468  1120 pts/0    R+   00:48   0:00 grep --color=auto -i kubelet 
root@controlplane:~# 

root@controlplane:~# cat /var/lib/kubelet/config.yaml | grep -i static
staticPodPath: /etc/kubernetes/manifests
root@controlplane:~# 

root@controlplane:~# cd /etc/kubernetes/manifests
root@controlplane:/etc/kubernetes/manifests# ls -rtlh
total 16K
-rw------- 1 root root 3.8K Sep 20 00:09 kube-apiserver.yaml
-rw------- 1 root root 1.4K Sep 20 00:09 kube-scheduler.yaml
-rw------- 1 root root 3.3K Sep 20 00:09 kube-controller-manager.yaml
-rw------- 1 root root 2.2K Sep 20 00:09 etcd.yaml
root@controlplane:/etc/kubernetes/manifests#

root@controlplane:/etc/kubernetes/manifests# cat kube-apiserver.yaml | grep -i image
    image: k8s.gcr.io/kube-apiserver:v1.20.0
    imagePullPolicy: IfNotPresent
root@controlplane:/etc/kubernetes/manifests# 


Create a static pod named static-busybox that uses the busybox image and the command sleep 1000


root@controlplane:/etc/kubernetes/manifests# kubectl run --restart=Never --image=busybox static-busybox --dry-run=client -o yaml --command -- sleep 1000 > static-busybox.yaml
root@controlplane:/etc/kubernetes/manifests# 

root@controlplane:/etc/kubernetes/manifests# kubectl run --restart=Never --image=busybox:1.28.4 static-busybox --dry-run=client -o yaml --command -- sleep 1000 > static-busybox.yaml
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:~# ssh node01
Last login: Mon Sep 20 00:59:11 2021 from 10.55.152.4
root@node01:~# ps auxwww | grep -i "kubelet "
root     23673  0.0  0.0 3632640 97320 ?       Ssl  00:58   0:09 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.2
root     26435  0.0  0.0  11468  1016 pts/0    S+   01:01   0:00 grep --color=auto -i kubelet 
root@node01:~# cat /var/lib/kubelet/config.yaml | grep -i static
staticPodPath: /etc/just-to-mess-with-you
root@node01:~# cd /etc/just-to-mess-with-you
root@node01:/etc/just-to-mess-with-you# ls -rtlh
total 4.0K
-rw-r--r-- 1 root root 301 Sep 20 00:58 greenbox.yaml
root@node01:/etc/just-to-mess-with-you# 




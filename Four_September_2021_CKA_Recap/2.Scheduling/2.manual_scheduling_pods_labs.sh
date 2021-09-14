root@controlplane:~# cat nginx.yaml 
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  -  image: nginx
     name: nginx

root@controlplane:~# 


root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   3m11s   v1.20.0   10.60.136.3   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
node01         Ready    <none>                 2m10s   v1.20.0   10.60.136.6   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# 

root@controlplane:~# kubectl apply -f nginx.yaml 
pod/nginx created
root@controlplane:~# kubectl get pods -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP       NODE     NOMINATED NODE   READINESS GATES
nginx   0/1     Pending   0          6s    <none>   <none>   <none>           <none>
root@controlplane:~# 



root@controlplane:~# kubectl get cs
Warning: v1 ComponentStatus is deprecated in v1.19+
NAME                 STATUS      MESSAGE                                                                                       ERROR
scheduler            Unhealthy   Get "http://127.0.0.1:10251/healthz": dial tcp 127.0.0.1:10251: connect: connection refused   
controller-manager   Unhealthy   Get "http://127.0.0.1:10252/healthz": dial tcp 127.0.0.1:10252: connect: connection refused   
etcd-0               Healthy     {"health":"true"}                                                                             
root@controlplane:~# kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-74ff55c5b-4rc9j                1/1     Running   0          23m
coredns-74ff55c5b-62vqs                1/1     Running   0          23m
etcd-controlplane                      1/1     Running   0          23m
kube-apiserver-controlplane            1/1     Running   0          23m
kube-controller-manager-controlplane   1/1     Running   0          23m
kube-flannel-ds-7m6ng                  1/1     Running   0          22m
kube-flannel-ds-rmh2l                  1/1     Running   0          23m
kube-proxy-4fpwv                       1/1     Running   0          23m
kube-proxy-wccgr                       1/1     Running   0          22m
root@controlplane:~# 


root@controlplane:~# kubectl get pods --all-namespaces | grep -i "scheduler"
root@controlplane:~# kubectl get pods --all-namespaces | grep -i "kube-"
kube-system   coredns-74ff55c5b-4rc9j                1/1     Running   0          29m
kube-system   coredns-74ff55c5b-62vqs                1/1     Running   0          29m
kube-system   etcd-controlplane                      1/1     Running   0          29m
kube-system   kube-apiserver-controlplane            1/1     Running   0          29m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          29m
kube-system   kube-flannel-ds-7m6ng                  1/1     Running   0          29m
kube-system   kube-flannel-ds-rmh2l                  1/1     Running   0          29m
kube-system   kube-proxy-4fpwv                       1/1     Running   0          29m
kube-system   kube-proxy-wccgr                       1/1     Running   0          29m
root@controlplane:~#

"So there is no scheduler running"

root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   3m11s   v1.20.0   10.60.136.3   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
node01         Ready    <none>                 2m10s   v1.20.0   10.60.136.6   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# 

Manually schedule the pod on node01


root@controlplane:~# kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
controlplane   Ready    control-plane,master   35m   v1.20.0
node01         Ready    <none>                 34m   v1.20.0
root@controlplane:~# vim nginx.yaml 
root@controlplane:~# cat nginx.yaml 
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: node01
  containers:
  -  image: nginx
     name: nginx

root@controlplane:~# 


root@controlplane:~# kubectl apply -f nginx.yaml 
pod/nginx created
root@controlplane:~# kubectl get pods 
NAME    READY   STATUS              RESTARTS   AGE
nginx   0/1     ContainerCreating   0          17s
root@controlplane:~# kubectl get pods 
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          67s
root@controlplane:~# 


root@controlplane:~# vim nginx.yaml 
root@controlplane:~# cat nginx.yaml 
---
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  nodeName: controlplane 
  containers:
  -  image: nginx
     name: nginx

root@controlplane:~#


root@controlplane:~# kubectl apply -f nginx.yaml 
pod/nginx created
root@controlplane:~# kubectl get pods -o wide
NAME    READY   STATUS              RESTARTS   AGE   IP       NODE           NOMINATED NODE   READINESS GATES
nginx   0/1     ContainerCreating   0          10s   <none>   controlplane   <none>           <none>
root@controlplane:~# kubectl get pods -o wide
NAME    READY   STATUS    RESTARTS   AGE    IP           NODE           NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          3m3s   10.244.0.4   controlplane   <none>           <none>
root@controlplane:~# 


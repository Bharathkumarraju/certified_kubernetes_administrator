root@controlplane:~# kubectl get cs
Warning: v1 ComponentStatus is deprecated in v1.19+
NAME                 STATUS      MESSAGE                                                                                       ERROR
controller-manager   Unhealthy   Get "http://127.0.0.1:10252/healthz": dial tcp 127.0.0.1:10252: connect: connection refused   
scheduler            Unhealthy   Get "http://127.0.0.1:10251/healthz": dial tcp 127.0.0.1:10251: connect: connection refused   
etcd-0               Healthy     {"health":"true"}                                                                             
root@controlplane:~# kubectl get pods -n kube-system
NAME                                   READY   STATUS             RESTARTS   AGE
coredns-74ff55c5b-dmn7d                1/1     Running            0          11m
coredns-74ff55c5b-kcj74                1/1     Running            0          11m
etcd-controlplane                      1/1     Running            0          11m
kube-apiserver-controlplane            1/1     Running            0          11m
kube-controller-manager-controlplane   1/1     Running            0          11m
kube-flannel-ds-nvjfr                  1/1     Running            0          11m
kube-proxy-wsgdk                       1/1     Running            0          11m
kube-scheduler-controlplane            0/1     CrashLoopBackOff   3          89s
root@controlplane:~# 


root@controlplane:~# kubectl get cs
Warning: v1 ComponentStatus is deprecated in v1.19+
NAME                 STATUS      MESSAGE                                                                                       ERROR
controller-manager   Unhealthy   Get "http://127.0.0.1:10252/healthz": dial tcp 127.0.0.1:10252: connect: connection refused   
scheduler            Unhealthy   Get "http://127.0.0.1:10251/healthz": dial tcp 127.0.0.1:10251: connect: connection refused   
etcd-0               Healthy     {"health":"true"}                                                                             
root@controlplane:~# kubectl get pods -n kube-system
NAME                                   READY   STATUS             RESTARTS   AGE
coredns-74ff55c5b-dmn7d                1/1     Running            0          11m
coredns-74ff55c5b-kcj74                1/1     Running            0          11m
etcd-controlplane                      1/1     Running            0          11m
kube-apiserver-controlplane            1/1     Running            0          11m
kube-controller-manager-controlplane   1/1     Running            0          11m
kube-flannel-ds-nvjfr                  1/1     Running            0          11m
kube-proxy-wsgdk                       1/1     Running            0          11m
kube-scheduler-controlplane            0/1     CrashLoopBackOff   3          89s
root@controlplane:~# 



root@controlplane:/etc/kubernetes/manifests# kubectl get all 
NAME                       READY   STATUS    RESTARTS   AGE
pod/app-586bddbc54-djlqq   1/1     Running   0          38s
pod/app-586bddbc54-gkknn   1/1     Running   0          12m

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   23m

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/app   2/2     2            2           12m

NAME                             DESIRED   CURRENT   READY   AGE
replicaset.apps/app-586bddbc54   2         2         2       12m
root@controlplane:/etc/kubernetes/manifests# 


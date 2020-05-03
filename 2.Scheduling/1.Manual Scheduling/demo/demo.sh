master $ kubectl get cs
NAME                 AGE
scheduler            <unknown>
controller-manager   <unknown>
etcd-0               <unknown>
master $

master $ kubectl get nodes
NAME     STATUS   ROLES    AGE   VERSION
master   Ready    master   11m   v1.16.0
node01   Ready    <none>   10m   v1.16.0
master $



master $ kubectl apply -f nginx.yaml
pod/nginx created
master $

master $ kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   0/1     Pending   0          18s
master $

Reason for pending is there is no kube-scheduler pods in the kube-system namespace aa below.

master $ kubectl get pods -n kube-system
NAME                             READY   STATUS    RESTARTS   AGE
coredns-5644d7b6d9-ch22n         1/1     Running   0          26m
coredns-5644d7b6d9-vbtrj         1/1     Running   0          26m
etcd-master                      1/1     Running   0          25m
kube-apiserver-master            1/1     Running   0          25m
kube-controller-manager-master   1/1     Running   0          25m
kube-proxy-jrr9n                 1/1     Running   0          26m
kube-proxy-rq6pq                 1/1     Running   0          26m
weave-net-5jp5m                  2/2     Running   1          26m
weave-net-tps8g                  2/2     Running   0          26m
master $

So update the pod-definition file nginx.yaml with the new field calle nodeName as below.

apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    -  image: nginx
       name: nginx
  nodeName: node01
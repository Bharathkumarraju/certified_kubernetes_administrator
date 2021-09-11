root@controlplane:~# kubectl get namespaces
NAME              STATUS   AGE
default           Active   8m20s
dev               Active   59s
finance           Active   59s
kube-node-lease   Active   8m23s
kube-public       Active   8m23s
kube-system       Active   8m24s
manufacturing     Active   59s
marketing         Active   59s
prod              Active   59s
research          Active   59s
root@controlplane:~# kubectl get namespaces | wc -l
11
root@controlplane:~# kubectl  get pods -n research
NAME    READY   STATUS              RESTARTS   AGE
dna-1   0/1     ContainerCreating   0          96s
dna-2   0/1     ContainerCreating   0          96s
root@controlplane:~# kubectl run redis --image=redis -n finance
pod/redis created
root@controlplane:~#     



root@controlplane:~# kubectl get all --all-namespaces | grep -i service
default         service/kubernetes        ClusterIP   10.96.0.1       <none>        443/TCP                  11m
dev             service/db-service        ClusterIP   10.102.88.175   <none>        6379/TCP                 4m31s
finance         service/payroll-service   NodePort    10.96.4.206     <none>        8080:30083/TCP           4m30s
kube-system     service/kube-dns          ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP   11m
manufacturing   service/red-service       NodePort    10.96.212.35    <none>        8080:30080/TCP           4m31s
marketing       service/blue-service      NodePort    10.98.187.151   <none>        8080:30082/TCP           4m31s
marketing       service/db-service        NodePort    10.99.133.204   <none>        6379:31971/TCP           4m31s
root@controlplane:~# 


from blue service we can access another service("db-service") in same namespace(marketing) like below
db-service

from blue service we can access another service("db-service") in different namespace(dev) like below
db-service.dev.svc.cluster.local:6379





bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get nodes -o wide
NAME       STATUS   ROLES                  AGE    VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION    CONTAINER-RUNTIME
minikube   Ready    control-plane,master   117m   v1.20.2   192.168.49.2   <none>        Ubuntu 20.04.2 LTS   5.4.39-linuxkit   docker://20.10.6
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 




bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get pods --all-namespaces -o wide
NAMESPACE     NAME                               READY   STATUS    RESTARTS   AGE    IP             NODE       NOMINATED NODE   READINESS GATES
kube-system   coredns-74ff55c5b-plhmt            1/1     Running   1          119m   172.17.0.2     minikube   <none>           <none>
kube-system   etcd-minikube                      1/1     Running   1          119m   192.168.49.2   minikube   <none>           <none>
kube-system   kube-apiserver-minikube            1/1     Running   1          119m   192.168.49.2   minikube   <none>           <none>
kube-system   kube-controller-manager-minikube   1/1     Running   1          119m   192.168.49.2   minikube   <none>           <none>
kube-system   kube-proxy-w85sf                   1/1     Running   1          119m   192.168.49.2   minikube   <none>           <none>
kube-system   kube-scheduler-minikube            1/1     Running   1          119m   192.168.49.2   minikube   <none>           <none>
kube-system   storage-provisioner                1/1     Running   2          119m   192.168.49.2   minikube   <none>           <none>
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 


bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get svc --all-namespaces -o wide
NAMESPACE     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE    SELECTOR
default       kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  121m   <none>
kube-system   kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   121m   k8s-app=kube-dns
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 


harathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl run nginx --image=nginx
pod/nginx created
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $

bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get pods -n default
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          63s
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $


bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl describe pod nginx -n default 
Name:         nginx
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Sun, 05 Sep 2021 09:01:56 +0800
Labels:       run=nginx
Annotations:  <none>
Status:       Running
IP:           172.17.0.3
IPs:
  IP:  172.17.0.3
Containers:
  nginx:
    Container ID:   docker://29f805ef6ace3d5283594cd85b7d261739550297e18dcf68819b4a364e37bb23
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:a05b0cdd4fc1be3b224ba9662ebdf98fe44c09c0c9215b45f84344c12867002e
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 05 Sep 2021 09:02:25 +0800
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lxpp9 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  default-token-lxpp9:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-lxpp9
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  8m13s  default-scheduler  Successfully assigned default/nginx to minikube
  Normal  Pulling    8m12s  kubelet            Pulling image "nginx"
  Normal  Pulled     7m46s  kubelet            Successfully pulled image "nginx" in 27.0053815s
  Normal  Created    7m45s  kubelet            Created container nginx
  Normal  Started    7m45s  kubelet            Started container nginx
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 
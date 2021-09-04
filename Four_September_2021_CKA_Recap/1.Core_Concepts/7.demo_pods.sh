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



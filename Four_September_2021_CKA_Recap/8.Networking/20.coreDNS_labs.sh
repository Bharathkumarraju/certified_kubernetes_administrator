root@controlplane:~# kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-74ff55c5b-9rj2x                1/1     Running   0          10m
coredns-74ff55c5b-vdgtz                1/1     Running   0          10m
etcd-controlplane                      1/1     Running   0          11m
kube-apiserver-controlplane            1/1     Running   0          11m
kube-controller-manager-controlplane   1/1     Running   0          11m
kube-flannel-ds-z2dfx                  1/1     Running   0          10m
kube-proxy-rbb8b                       1/1     Running   0          10m
kube-scheduler-controlplane            1/1     Running   0          11m
root@controlplane:~# 



root@controlplane:~# kubectl get svc -n kube-system -o wide
NAME       TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   12m   k8s-app=kube-dns
root@controlplane:~# 



root@controlplane:~# kubectl describe deployment.apps/coredns -n kube-system | grep -iC2 "Corefile"
    Args:
      -conf
      /etc/coredns/Corefile
    Limits:
      memory:  170Mi
root@controlplane:~# 



How is the Corefile passed in to the CoreDNS POD?

root@controlplane:~# kubectl get cm -n kube-system
NAME                                 DATA   AGE
coredns                              1      27m
extension-apiserver-authentication   6      27m
kube-flannel-cfg                     2      27m
kube-proxy                           2      27m
kube-root-ca.crt                     1      26m
kubeadm-config                       2      27m
kubelet-config-1.20                  1      27m
root@controlplane:~# 

What is the root domain/zone configured for this kubernetes cluster?


root@controlplane:~# kubectl describe cm coredns -n kube-system 
Name:         coredns
Namespace:    kube-system
Labels:       <none>
Annotations:  <none>

Data
====
Corefile:
----
.:53 {
    errors
    health {
       lameduck 5s
    }
    ready
    kubernetes cluster.local in-addr.arpa ip6.arpa {
       pods insecure
       fallthrough in-addr.arpa ip6.arpa
       ttl 30
    }
    prometheus :9153
    forward . /etc/resolv.conf {
       max_concurrent 1000
    }
    cache 30
    loop
    reload
    loadbalance
}

Events:  <none>
root@controlplane:~# 



root@controlplane:~# kubectl get pods -n default
NAME                READY   STATUS    RESTARTS   AGE
hr                  1/1     Running   0          19m
simple-webapp-1     1/1     Running   0          19m
simple-webapp-122   1/1     Running   0          19m
test                1/1     Running   0          19m
root@controlplane:~# kubectl get pods -n payroll
NAME   READY   STATUS    RESTARTS   AGE
web    1/1     Running   0          19m
root@controlplane:~# 


root@controlplane:~# kubectl get svc -n default
NAME           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes     ClusterIP   10.96.0.1       <none>        443/TCP        30m
test-service   NodePort    10.96.151.101   <none>        80:30080/TCP   21m
web-service    ClusterIP   10.103.4.192    <none>        80/TCP         21m
root@controlplane:~# kubectl get svc -n payroll
NAME          TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
web-service   ClusterIP   10.105.43.19   <none>        80/TCP    21m
root@controlplane:~# 



We just deployed a web server - webapp - that accesses a database mysql - server. 
However the web server is failing to connect to the database server. Troubleshoot and fix the issue.


They could be in different namespaces. First locate the applications. 
The web server interface can be seen by clicking the tab Web Server at the top of your terminal.



root@controlplane:~# kubectl get pods,svc -n default
NAME                          READY   STATUS    RESTARTS   AGE
pod/hr                        1/1     Running   0          24m
pod/simple-webapp-1           1/1     Running   0          24m
pod/simple-webapp-122         1/1     Running   0          24m
pod/test                      1/1     Running   0          24m
pod/webapp-84ffb6ddff-kqkxl   1/1     Running   0          94s

NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP          33m
service/test-service     NodePort    10.96.151.101    <none>        80:30080/TCP     24m
service/web-service      ClusterIP   10.103.4.192     <none>        80/TCP           24m
service/webapp-service   NodePort    10.109.186.109   <none>        8080:30082/TCP   93s
root@controlplane:~#

root@controlplane:~# kubectl get pods,svc -n payroll
NAME        READY   STATUS    RESTARTS   AGE
pod/mysql   1/1     Running   0          108s
pod/web     1/1     Running   0          24m

NAME                  TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/mysql         ClusterIP   10.110.240.0   <none>        3306/TCP   108s
service/web-service   ClusterIP   10.105.43.19   <none>        80/TCP     24m
root@controlplane:~# 




root@controlplane:~# kubectl get deploy
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
webapp   1/1     1            1           3m23s
root@controlplane:~# kubectl describe deploy webapp
Name:                   webapp
Namespace:              default
CreationTimestamp:      Tue, 28 Sep 2021 00:53:34 +0000
Labels:                 name=webapp
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               name=webapp
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  name=webapp
  Containers:
   simple-webapp-mysql:
    Image:      mmumshad/simple-webapp-mysql
    Port:       8080/TCP
    Host Port:  0/TCP
    Environment:
      DB_Host:      mysql
      DB_User:      root
      DB_Password:  paswrd
    Mounts:         <none>
  Volumes:          <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   webapp-84ffb6ddff (1/1 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  3m35s  deployment-controller  Scaled up replica set webapp-84ffb6ddff to 1
root@controlplane:~#



From the hr pod nslookup the mysql service and redirect the output to a file /root/CKA/nslookup.out


oot@controlplane:~# kubectl exec -it hr -- nslookup mysql.payroll > /root/CKA/nslookup.output
root@controlplane:~# cat /root/CKA/nslookup.output
Server:         10.96.0.10
Address:        10.96.0.10#53

Name:   mysql.payroll.svc.cluster.local
Address: 10.110.240.0

root@controlplane:~# 

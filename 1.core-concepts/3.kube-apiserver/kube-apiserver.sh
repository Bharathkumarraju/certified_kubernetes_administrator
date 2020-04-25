$kubectl get nodes -o wide

when you run kubectl command first it reaches to kube-apiserver and
kube-apisever first authenticates the request and validates it and then it retrieves the data from the ETCD cluster.
and responded back as response to the user...
1. Authenticate User
2.Validate Request
3.Retrieve data from etcd
4.Update ETCD
5.Scheduler
6.Kubelet
So kube-apiserver is centre of all operations...
kube-apiserver only component has ability to update etcd cluster....

bharathdasaraju@MacBook-Pro (master) $ kubectl get nodes -o wide
NAME       STATUS   ROLES    AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE               KERNEL-VERSION   CONTAINER-RUNTIME
minikube   Ready    master   27d   v1.18.0   192.168.64.2   <none>        Buildroot 2019.02.10   4.19.107         docker://19.3.8
bharathdasaraju@MacBook-Pro (master) $

Installing kube-apiserver:
----------------------------->
if you install kube-apiserver manually you should use below certs in its service for authentication.

ExecStart=/usr/local/bin/kube-apiserver \\
...
...
   --etcd-cafile=/var/lib/kubernetes/ca.pem \\
   --etcd-certfile=/var/lib/kubernetes/kubernetes.pem \\
   --etcd-keyfile=/var/lib/kubernetes/kubernetes-key.pem \\
...
...
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.pem \\
  --kubelet-client-certificate=/var/lib/kubernetes/kubernetes.pem \\
  --kubelet-client-key=/var/lib/kubernetes/kubernetes-key.pem \\
  --kubelet-https=true \\
...
...
  --etcd-servers=https://127.0.0.1:2379 \\
...
...

bharathdasaraju@MacBook-Pro  $ kubectl get pods -n kube-system | grep -i apiserver
kube-apiserver-minikube            1/1     Running   2          27d
bharathdasaraju@MacBook-Pro  (master) $



bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl describe pod kube-apiserver-minikube  -n kube-system
Name:                 kube-apiserver-minikube
Namespace:            kube-system
Priority:             2000000000
Priority Class Name:  system-cluster-critical
Node:                 minikube/192.168.64.2
Start Time:           Sat, 18 Apr 2020 06:51:02 +0800
Labels:               component=kube-apiserver
                      tier=control-plane
Annotations:          kubeadm.kubernetes.io/kube-apiserver.advertise-address.endpoint: 192.168.64.2:8443
                      kubernetes.io/config.hash: 59a25aa23d3a8b3a2bc6157139d12f6c
                      kubernetes.io/config.mirror: 59a25aa23d3a8b3a2bc6157139d12f6c
                      kubernetes.io/config.seen: 2020-03-29T02:24:05.496567899Z
                      kubernetes.io/config.source: file
Status:               Running
IP:                   192.168.64.2
Controlled By:        Node/minikube
Containers:
  kube-apiserver:
    Container ID:  docker://426b76131aed210b2789a72df1e125dbc56a31df7874385127ab88851f1a7898
    Image:         k8s.gcr.io/kube-apiserver:v1.18.0
    Image ID:      docker-pullable://k8s.gcr.io/kube-apiserver@sha256:fc4efb55c2a7d4e7b9a858c67e24f00e739df4ef5082500c2b60ea0903f18248
    Port:          <none>
    Host Port:     <none>
    Command:
      kube-apiserver
      --advertise-address=192.168.64.2
      --allow-privileged=true
      --authorization-mode=Node,RBAC
      --client-ca-file=/var/lib/minikube/certs/ca.crt
      --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota
      --enable-bootstrap-token-auth=true
      --etcd-cafile=/var/lib/minikube/certs/etcd/ca.crt
      --etcd-certfile=/var/lib/minikube/certs/apiserver-etcd-client.crt
      --etcd-keyfile=/var/lib/minikube/certs/apiserver-etcd-client.key
      --etcd-servers=https://127.0.0.1:2379
      --insecure-port=0
      --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt
      --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key
      --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
      --proxy-client-cert-file=/var/lib/minikube/certs/front-proxy-client.crt
      --proxy-client-key-file=/var/lib/minikube/certs/front-proxy-client.key
      --requestheader-allowed-names=front-proxy-client
      --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt
      --requestheader-extra-headers-prefix=X-Remote-Extra-
      --requestheader-group-headers=X-Remote-Group
      --requestheader-username-headers=X-Remote-User
      --secure-port=8443
      --service-account-key-file=/var/lib/minikube/certs/sa.pub
      --service-cluster-ip-range=10.96.0.0/12
      --tls-cert-file=/var/lib/minikube/certs/apiserver.crt
      --tls-private-key-file=/var/lib/minikube/certs/apiserver.key
    State:          Running
      Started:      Sat, 18 Apr 2020 06:51:03 +0800
    Last State:     Terminated
      Reason:       Error
      Exit Code:    255
      Started:      Thu, 16 Apr 2020 11:55:04 +0800
      Finished:     Sat, 18 Apr 2020 06:50:51 +0800
    Ready:          True
    Restart Count:  2
    Requests:
      cpu:        250m
    Liveness:     http-get https://192.168.64.2:8443/healthz delay=15s timeout=15s period=10s #success=1 #failure=8
    Environment:  <none>
    Mounts:
      /etc/ssl/certs from ca-certs (ro)
      /usr/share/ca-certificates from usr-share-ca-certificates (ro)
      /var/lib/minikube/certs from k8s-certs (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  ca-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/ssl/certs
    HostPathType:  DirectoryOrCreate
  k8s-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /var/lib/minikube/certs
    HostPathType:  DirectoryOrCreate
  usr-share-ca-certificates:
    Type:          HostPath (bare host directory volume)
    Path:          /usr/share/ca-certificates
    HostPathType:  DirectoryOrCreate
QoS Class:         Burstable
Node-Selectors:    <none>
Tolerations:       :NoExecute
Events:            <none>
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $





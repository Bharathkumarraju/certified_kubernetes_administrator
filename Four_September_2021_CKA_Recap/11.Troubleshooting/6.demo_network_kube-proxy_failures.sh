root@controlplane:/# kubectl get all -n triton
NAME                                READY   STATUS              RESTARTS   AGE
pod/mysql                           0/1     ContainerCreating   0          44s
pod/webapp-mysql-54db464f4f-jfg42   0/1     ContainerCreating   0          43s

NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/mysql         ClusterIP   10.108.89.216    <none>        3306/TCP         44s
service/web-service   NodePort    10.101.145.126   <none>        8080:30081/TCP   43s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   0/1     1            0           43s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-54db464f4f   1         1         0       43s
root@controlplane:/# 

root@controlplane:/etc/kubernetes/manifests# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.apps/weave-net created
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:/etc/kubernetes/manifests# kubectl -n kube-system logs kube-proxy-cklbr
F0929 01:08:39.832255       1 server.go:490] failed complete: open /var/lib/kube-proxy/configuration.conf: no such file or directory
root@controlplane:/etc/kubernetes/manifests# kubectl get cm -n kube-system
NAME                                 DATA   AGE
coredns                              1      66m
extension-apiserver-authentication   6      66m
kube-proxy                           2      66m
kube-root-ca.crt                     1      66m
kubeadm-config                       2      66m
kubelet-config-1.20                  1      66m
weave-net                            0      66m
root@controlplane:/etc/kubernetes/manifests# 




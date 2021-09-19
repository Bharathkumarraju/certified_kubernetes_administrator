root@controlplane:~# kubectl get ds --all-namespaces
NAMESPACE     NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   kube-flannel-ds   1         1         1       1            1           <none>                   15m
kube-system   kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   15m
root@controlplane:~# 


Deploy a DaemonSet for FluentD Logging.
Name: elasticsearch
Namespace: kube-system
Image: k8s.gcr.io/fluentd-elasticsearch:1.20

root@controlplane:~# kubectl create deployment elasticsearch --image=k8s.gcr.io/fluentd-elasticsearch:1.20 -n kube-system --dry-run=client -o yaml > fluend_deploy.yaml
root@controlplane:~# 


root@controlplane:~# vim fluend_deploy.yaml 
root@controlplane:~# cat fluend_deploy.yaml 
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: elasticsearch
  name: elasticsearch
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: elasticsearch
  template:
    metadata:
      labels:
        app: elasticsearch
    spec:
      containers:
      - image: k8s.gcr.io/fluentd-elasticsearch:1.20
        name: fluentd-elasticsearch
root@controlplane:~# 

root@controlplane:~# kubectl apply -f fluend_deploy.yaml 
daemonset.apps/elasticsearch created
root@controlplane:~#

root@controlplane:~# kubectl get ds -o wide -n kube-system
NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS              IMAGES                                  SELECTOR
elasticsearch     1         1         0       1            0           <none>                   17s   fluentd-elasticsearch   k8s.gcr.io/fluentd-elasticsearch:1.20   app=elasticsearch
kube-flannel-ds   1         1         1       1            1           <none>                   22m   kube-flannel            quay.io/coreos/flannel:v0.13.1-rc1      app=flannel
kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   22m   kube-proxy              k8s.gcr.io/kube-proxy:v1.20.0           k8s-app=kube-proxy
root@controlplane:~# 

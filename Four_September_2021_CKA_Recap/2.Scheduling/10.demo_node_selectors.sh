bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl run nginx --image=nginx --dry-run=client -o yaml > pod-definition-nodeSelector.yaml
bharathdasaraju@MacBook-Pro 2.Scheduling % 

apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
  nodeSelector:
    size: Large  # This is the node Label


"How to Label a node"

kubectl label nodes node01 size=Large

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get nodes -o wide
NAME       STATUS   ROLES                  AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION    CONTAINER-RUNTIME
minikube   Ready    control-plane,master   11d   v1.20.2   192.168.49.2   <none>        Ubuntu 20.04.2 LTS   5.4.39-linuxkit   docker://20.10.6
bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl label nodes minikube size=Large
node/minikube labeled
bharathdasaraju@MacBook-Pro 2.Scheduling %

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl describe node minikube | grep -iB20 "size=Large"
Name:               minikube
Roles:              control-plane,master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=minikube
                    kubernetes.io/os=linux
                    minikube.k8s.io/commit=c61663e942ec43b20e8e70839dcca52e44cd85ae
                    minikube.k8s.io/name=minikube
                    minikube.k8s.io/updated_at=2021_09_04T14_52_27_0700
                    minikube.k8s.io/version=v1.20.0
                    node-role.kubernetes.io/control-plane=
                    node-role.kubernetes.io/master=
                    size=Large
bharathdasaraju@MacBook-Pro 2.Scheduling % 

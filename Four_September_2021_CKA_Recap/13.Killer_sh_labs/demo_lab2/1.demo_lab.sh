k get node # find master node
​
k describe node cluster1-master1 | grep Taint # get master node taints
​
k describe node cluster1-master1 | grep Labels -A 10 # get master node labels
​
k get node cluster1-master1 --show-labels # OR: get master node labels


MacBook-Pro:demo_lab2 bharathdasaraju$ k get node --show-labels
NAME       STATUS   ROLES                  AGE   VERSION   LABELS
minikube   Ready    control-plane,master   27d   v1.20.2   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,color=blue,kubernetes.io/arch=amd64,kubernetes.io/hostname=minikube,kubernetes.io/os=linux,minikube.k8s.io/commit=c61663e942ec43b20e8e70839dcca52e44cd85ae,minikube.k8s.io/name=minikube,minikube.k8s.io/updated_at=2021_09_04T14_52_27_0700,minikube.k8s.io/version=v1.20.0,node-role.kubernetes.io/control-plane=,node-role.kubernetes.io/master=,size=Large
MacBook-Pro:demo_lab2 bharathdasaraju$ 



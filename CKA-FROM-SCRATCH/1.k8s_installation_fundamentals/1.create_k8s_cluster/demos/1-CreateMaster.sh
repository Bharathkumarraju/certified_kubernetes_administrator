#Only on the master, download the yaml files for the pod network.
#The calico yaml file has changed since the publication of the course and is now avaialble at the URL below.
wget https://docs.projectcalico.org/manifests/calico.yaml


#Look inside calico.yaml and find the network range CALICO_IPV4POOL_CIDR, adjust if needed.
vi calico.yaml

#Create our kubernetes cluster, specifying a pod network range matching that in calico.yaml! 
#Use the samve version you specified in 0-PackageInstallation.sh
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --kubernetes-version 1.19.1

#If you want to install the latest, omit the kubernetes-version parameter
#sudo kubeadm init --pod-network-cidr=192.168.0.0/16

#Configure our account on the master to have admin access to the API server from a non-privileged account.
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Deploy yaml file for your pod network.
#This line of code has be updated since the publication of the course. 
kubectl apply -f calico.yaml


#Look for the all the system pods and calico pod to change to Running. 
#The DNS pod won't start until the Pod network is deployed and Running.
kubectl get pods --all-namespaces

#Gives you output over time, rather than repainting the screen on each iteration.
kubectl get pods --all-namespaces --watch

#All system pods should be Running
kubectl get pods --all-namespaces

#Get a list of our current nodes, just the master.
kubectl get nodes 

#Check out the systemd unit, and examine 10-kubeadm.conf
#Remeber the kubelet starts static pod manifests, and thus the core cluster pods
sudo systemctl status kubelet.service 

#check out the directory where the kubeconfig files live
ls /etc/kubernetes

#let's check out the manifests on the master
ls /etc/kubernetes/manifests

#And look more closely at API server and etcd's manifest.
sudo more /etc/kubernetes/manifests/etcd.yaml
sudo more /etc/kubernetes/manifests/kube-apiserver.yaml

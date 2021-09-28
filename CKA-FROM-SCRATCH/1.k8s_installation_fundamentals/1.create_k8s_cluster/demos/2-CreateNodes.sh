#For this demo ssh into c1-node1
ssh aen@c1-node1

#Disable swap, swapoff then edit your fstab removing any entry for swap partitions
#You can recover the space with fdisk. You may want to reboot to ensure your config is ok. 
swapoff -a
vi /etc/fstab

#Add Google's apt repository gpg key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

#Add the kuberentes apt repository
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'

#Update the package list 
sudo apt-get update
apt-cache policy kubelet | head -n 20 

#Install the required packages, if needed we can request a specific version. Pick the same version you used on the master in 0-PackageInstallation.sh
VERSION=1.19.1-00
sudo apt-get install docker.io kubelet=$VERSION kubeadm=$VERSION kubectl=$VERSION -y
sudo apt-mark hold docker.io kubelet kubeadm kubectl

#To install the latest, omit the version parameters
#sudo apt-get install docker.io kubelet kubeadm kubectl
#sudo apt-mark hold docker.io kubelet kubeadm kubectl

#Check the status of our kubelet and our container runtime, docker.
#The kubelet will enter a crashloop until it's joined
sudo systemctl status kubelet.service 
sudo systemctl status docker.service 

#Ensure both are set to start when the system starts up.
sudo systemctl enable kubelet.service
sudo systemctl enable docker.service

#Setup Docker daemon. This is a change that has been added since the recording of the course.
sudo bash -c 'cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF'

sudo systemctl daemon-reload
sudo systemctl restart docker

#Log out of c1-node1 and back on to c1-master1
exit

#On c1-master1 - if you didn't keep the output, on the master, you can get the token.
kubeadm token list

#If you need to generate a new token, perhaps the old one timed out/expired.
kubeadm token create

#On the master, you can find the ca cert hash.
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

#Back on the worker node c1-node1, using the master (API Server) IP address or name, the token and the cert has, let's join this Node to our cluster.
ssh aen@c1-node1
sudo kubeadm join 172.16.94.10:6443 \
    --token 0200wn.4fi5x3c5n21s8bfb \
    --discovery-token-ca-cert-hash sha256:ad8c95e0afc0d7fece39fa113a465a0d19bb02f6b17db6c4c0e2a506544900d0 
#Log out of c1-node1 and back on to c1-master1
exit

#Back on master, this will say NotReady until the networking pod is created on the new node. Has to schedule the pod, then pull the container.
kubectl get nodes 

#On the master, watch for the calico pod and the kube-proxy to change to Running on the newly added nodes.
kubectl get pods --all-namespaces --watch

#Still on the master, look for this added node's status as ready.
kubectl get nodes

#GO BACK TO THE TOP AND DO THE SAME FOR c1-node2 and c1-node3
#Just SSH into c1-node2 and c1-node3 and run the commands again.
ssh aen@c1-node2
#You can skip the token re-creation if you have one that's still valid.
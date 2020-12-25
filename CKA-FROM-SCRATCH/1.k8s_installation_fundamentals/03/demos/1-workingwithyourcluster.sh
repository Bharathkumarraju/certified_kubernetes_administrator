#Log into the control plane node
ssh aen@c1-master1

#Listing and Inspecting your cluster, pods, services and more.
kubectl cluster-info

#review status and roles
kubectl get nodes

#Additional information about each node in the cluster. 
kubectl get nodes -o wide

#Let's get a list of pods...but there isn't any running.
kubectl get pods 

#True, but let's get a list of system pods. A namespace is a way to group resources together.
kubectl get pods --namespace kube-system

#Let's get additional information about each pod. 
kubectl get pods --namespace kube-system -o wide

#Now let's get a list of everything that's running in all namespaces
kubectl get all --all-namespaces | more

#Asking kubernetes for the resources it knows about
#Let's look at the headers in each column. Name, Alias/shortnames, API Group (or where that resource is in the k8s API Path),
#Is the resource in a namespace, for example StorageClass issn't and is available to all namespaces and finally Kind...this is the object type.
kubectl api-resources | head -n 10

#We can easily filter using group
kubectl api-resources | grep pod

#Explain an indivdual resource in detail
kubectl explain pod | more 
kubectl explain pod.spec | more 
kubectl explain pod.spec.containers | more 
kubectl explain pod --recursive


#You'll soon find your favorite alias
kubectl get no

#Let's take a closer look at our nodes using Describe
#Check out Name, Taints, Conditions, Addresses, System Info, Non-Terminated Pods, and Events
kubectl describe nodes c1-master1
kubectl describe nodes c1-node1

#Ok, so now that we're tired of typing commands out, let's enable bash auto-complete of our kubectl commands
sudo apt-get install bash-completion
echo "source <(kubectl completion bash)" >> ~/.bashrc
source ~/.bashrc
kubectl g[tab][tab] po[tab][tab] --all[tab][tab]

kubectl -h | more
kubectl get -h | more
kubectl describe -h | more 

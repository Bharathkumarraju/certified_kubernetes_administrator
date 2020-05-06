why:
usecase:

Since static pods are not dependant on the kubernetes control plane, we can use static pods to deploy the control plane components itself
as pods on a node.
Starts by installing kubelet on all the master nodes.
Then create pod definition files that uses docker images of the various control plane components
such as the api-server, controller manager, ETCD ...etc..

i.e. Place the definition files in the designated manifests folder and the kubelet takescare of deploying the
control plane components themselves as PODS on the cluster.

This way we do not have to download the binaries configure services or worry about the service is crashing etc..
if any of these services were to crash since it is a static pod it will automatically restarted by the kubelet.

This is how the kubeadmin tool sets up a kubernetes cluster.








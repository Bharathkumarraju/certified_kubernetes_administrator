Networking configuration on the master and worker nodes

Each node have atleast one interface must connected to a network.
Each interface must have an IPAddress connected.
The hosts must have unique hostname set, as well as unique MAC address

There are some ports should be opend as well. These are used by various components in the control plane.

The master should accept connections on "6443" port.
the worker nodes, kunectl tool, external users, and all other control plane components access kube-apiserver via this port.

the kubelets on the master and worker nodes listen on port "10250".
kube-scheduler port "10251" to be open.
kube-controller-manager requires port "10252" to be open.
The worker nodes exposes services(nodePort) for external access on ports "30000" to "32767" so these should be open as well.
ETCD server listens on port "2379"

if we have multiple masters all ports should open them as well and additional port "2380" should be opened so the etcd clients can communicate with each other.





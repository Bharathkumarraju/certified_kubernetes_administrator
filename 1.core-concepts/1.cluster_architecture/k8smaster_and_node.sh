K8S Master(Control Plane Components):
--------------------------------------->
 1. storing the information regarding the different nodes
 2. Planning which container goes to which node
 3. Responsible for managing the kubernetes cluster.
 4. Monitoring the nodes and the containers in cluster etc...

K8S master node does all of the above steps using the control plane components listed below.

ETCD-Cluster:
1. There are many number of containers stopped, started and restarted in the cluster
2. And we have to maintain the information about those containers
3. i.e. when the container started or stopped or killed etc...
4. all those above information stored in the highly available key-value database store called ETCD

Kube-schduler:
1. responsible to place specific container in specific nodes based on its size and available resources in the nodes
2. identifies Right node to place right containers based on nodes available resources
3. like taints/tolerations and node affinity rules

kube-contoller-manager:
1. Node controller - responsible for onboarding new nodes to the cluster and handling situations like
    were nodes become unavailable or gets destroyed
2. Replication controller - ensures that the desired number of containers run all times in a replication group.

kube-apiserver:
 1. Kube-apiserver is the primary management component of the kubernetes cluster.
 2. Kube-apiserber is resposible for orchestrating all the operations with in the cluster.
 3. it exposes the kubernetes API to external users to perform management operations on the cluster as well as
    to monitor the state of the cluster and make necessary changes as required.


K8S Worker Node:
------------------>
container-runtime-engine:
 1. All applications in the form of containers. So we need a software to run the containers
 2. that is the container-runtime-engine
 3. e.g. docker , containerd, rkt etc...

kublet:
 1. kublet is an agent runs on each k8s cluster node.
 2. It listens for instructions from the kube-apiserver and deploys containers in the node.

kube-proxy:
1. for example a web container in one node and application container in another node
2. How does the communication between web and application container is achieved... it is through the kube-proxy network.







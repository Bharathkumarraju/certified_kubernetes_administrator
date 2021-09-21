if the node gets shutdown for more than 5 minits the pods in that node considered as dead.

this is configured on controller-manager as a setting called pod-eviction-timeout
i.e. kube-controller-manager --pod-eviction-timeout=5m0s


in order to safely move all the existing pods to another node... first drain the node

1. kubectl drain node-1 and then perform reboot of the node.
2. After reboot - kubectl uncordon node-1 to schedule the pods on the node-1 again.


kubectl drain node-1  --> it moves all pods to another node and makes unschedulable for pods on that node
kubectl uncordon node-1 --> make node to be schedulable for pods.

kubectl cordon node-1 --> it only makes node unschedulable for pods..it doesnot move existing pods to new node.




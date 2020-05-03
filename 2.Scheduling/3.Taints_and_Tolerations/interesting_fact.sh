The Scheduler does not schedule any pods on the master node....
why? why? why?

When the kubernetes cluster is first setup, A "taint" is set on the master node automatically,
that prevents any pods from being schedule on the master node.

$ kubectl describe node kubemaster | grep Taint
Taints:       node-role.kubernetes.io/master:NoSchedule
$



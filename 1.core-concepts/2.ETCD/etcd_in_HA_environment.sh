In high availabilty environment you have multiple master nodes in the kubernetes cluster..
In that you have multiple ETCD instances spread across each master node...
in that case etcd instances in each node should communicate among themselves...

in order to that we have set the below flag in the etcd service

--initial-cluster controller-0=https://${CONTROLLER0_IP}:2380,controller-1=https://${CONTROLLER1_IP}:2380 \\
--initial-cluster-state new \\



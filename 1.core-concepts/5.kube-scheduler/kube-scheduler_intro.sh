Kube-scheduler:

So kubernetes scheduler is responsible for scheduling pods on the nodes.

So kube-scheduler decides only --> Which Pod goes on which node, It does not actually place the pods on the nodes.

Then who actually places the pods on the nodes... this job is done by "kubelet"
Kubelet is the one who creates the pods on the nodes.

Kube-scheduler is only a decision maker ...i.e. decides which pod goes were.

How Scheduler decides which pods needs to be placed in which node:
---------------------------------------------------------------------->
Scheduler decides which pods goes which nodes depending on certain criteria.
  1. Scheduler looks in pod and tries to find best node for it.
  2. Lets say if you have pod tha has CPU: 10 and scheduler job is to find which node has sufficient CPUs avaiable
     and decides the correct node for that pod.
  Scheduler does below actions on nodes
  1. Filter nodes
  2. Rank Nodes ( schduler ranks the nodes to identify the best fit for the pod
     it uses a priority function to assign a score to the nodes on a scale of 0 to 10 )
  3. of course highest rank wins while deciding which node the pods needs to be placed.

Kube-Scheduler also looks below things before taking a decision
  1. Resource requirements and Limits
  2. Taints and Tolerations
  3. Node Selectors/ Affinity and Anti-Affinity rules

Installing Kube-scheduler:
------------------------------------->
Download kube-scheduler from kubernetes official downloads page and run it as service in linux box.

kube-scheduler.service:
ExecStart=/usr/local/bin/kube-scheduler \\
...
      --config=/etc/kubernetes/config/kube-scheduler.yaml \\
...

bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get pods -n kube-system -o wide | grep scheduler
kube-scheduler-minikube            1/1     Running   55         27d   192.168.64.2   minikube   <none>           <none>
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $






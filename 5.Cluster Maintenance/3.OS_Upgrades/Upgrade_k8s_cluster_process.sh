Upgrading k8s cluster is a two step process.

step1: First we upgrade our master nodes

step2: And then upgrade the worker node

while the master is being upgraded, the control plane components such as
API Server, Scheduler, and Controller Manager go down briefly.

The master node is going down does not mean your worker nodes and applications on the cluster are impacted.
All workloads hosted on the worker nodes continue to serve users as normal.

Since the master is down all management fucntions are down.
you can not access the cluster using kubectl
you can not deploy new applications or delete or modify exisitng ones.

since the master is down, The controller manager dont fucntion either, that means
If a pod is failed and new pod wont be automatically created.

But as long as the nodes and pods are up your applications should be up and users will not be impacted.

Lets say now the master is upgraded, that means our master nodes are at version V1.11 but the worker nodes are at V1.10

Now time to upgrade the worker nodes:
-------------------------------------->
There are different strategies available to upgrade the worker nodes.
1.Upgrade all worker nodes at once(requires downtime):
------------------------------------------------------->
In this case all pods are down and users are no longer able to access the applications.
once the upgrade is complete and the nodes are back up new pods are scheduled, and users can resume access.

2.Upgrade one worker node at a time(requires no downtime):
---------------------------------------------------------->
Our master nodes are upgraded. And worker nodes are waiting to be upgraded.
We first upgrade the first worker node where the workloads move to second and third worker nodes.
and then upgrade the second worker node and then subsequently the third node.

3.Add a new worker node to the cluster with the newer version:
----------------------------------------------------------------->
Move the workloads to the newer worker nodes and remove the old nodes until you finally have all new worker nodes with the
newer software version.




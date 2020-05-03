How to restrict on what pods to place on what nodes.

taints and tolerations have nothing to do with security or intrusion on the cluster.
taints and tolerations are used to set restrictions on what pods can be scheduled on a node.

Lets start with simple kubernetes cluster with three worker nodes(Node1, Node2 and Node3)
We also have set of pods(A, B and C) to be deployed on these nodes.

When the pods are created kubernetes-scheduler tries to place these pods on the available worker nodes.
As of now there are no restrictions(or)limitations and such as the scheduler places pods across all the nodes
to balance them out equally.

Now, Let us assume that we have dedicated resources on Node1 for a particular usecase or application
so we would like only those pods that belong to this application to be placed on Node1.

First we prevent all pods from being placed on that Node(Node1) by placing a taint(blue) on that node(Node1)
By default pods have no toleration which means...
unless specified otherwise none of the pods can tolerate any taint(blue) on the node(Node1).

So this means since we placed a taint on the node(Node1)... no pods going to place on this node because by default
none of the pods can tolerate any taint on the node(Node1).

So we can enable certain pods to be able to place on this node(Node1).
For this we must specify which pods are tolerant to this particular attempt.

In our case we would like to allow only Pod-D to be placed on this node(Node1) so we add toleration to that Pod(Pod-D)
So now Pod-D is tolerant to taint(blue) so when scheduler tries to place this Pod-D on Node1 it goes through sucessfully.

So Node1 can now only accept pods that can tolerate with the taint(blue).
So taints are set on nodes and tolerations are set on pods.

How to taint a node:
---------------------->
use "kubectl taint"
kubectl taint nodes <node-name> key=value:taint-effect

The "taint-effect" defines what would happens to pods.
What would happen to pods that do not tolerate this "taint-effect", there are three taint-effects
1. NoSchedule  --> means pods will not be scheduled on these nodes if pods do not tolerate the taint-effect
2. PreferNoSchedule --> means the system will try to avoid placing a pod on the node but that is not guaranteed.
3. NoExecute --> means that new pods will not be scheduled on the node and existing pods on the node if any will be
                 evicted if they do not tolerate the taint. These pods may have been scheduled on the node before the
                 taint was applied to the node.

Example:
--------->
kubectl taint nodes node1 app=blue:NoSchedule

How to add tolerations to the pod:
------------------------------------->
apiVersion: v1
kind: Pod
metadata:
  name: bharathpod
spec:
  containers:
    - name: bharathscontainer
      image: nginx
  tolerations:
    - key: app
      operator: "Equal"
      value: blue
      effect: NoSchedule



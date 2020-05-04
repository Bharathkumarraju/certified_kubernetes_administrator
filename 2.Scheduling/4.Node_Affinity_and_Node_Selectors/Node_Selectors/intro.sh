Lets say we have a 3 node kubernetes cluster of which
Two are samller nodes with lower hardware resources and one of them is a larger node,
configured with higher resources.

So, we have different kinds of workloads running in our cluster.
We would like to dedicate the data processing workloads that require higher horsepower to the larger node.
As that is the only node that will not run out of resources in case the job demands extra resources.

how to do this with NodeSelectors:
-------------------------------------->
lets modify pod-definition file

apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  nodeSelector:
    size: large  #It is the label of the node(large node)

How to label the nodes:
-------------------------->
$ kubectl label nodes <node-name>  <label-key>=<label-value>

$ kubectl label nodes node-1 size=large

So if we have much complex scenario like, we would like to say something like place the pod
in a large or medium nodes or something like place the pod any nodes that are not small.

We cannot achieve this using the Node Selectors, for this node affinity and anti affinity features were introduced.




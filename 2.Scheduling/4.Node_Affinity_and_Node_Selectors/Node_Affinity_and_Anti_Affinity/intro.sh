The primary purpose of the node affinity feature is to ensure that pods are hosted on particular nodes.

The node affinity feature provides us with advanced capabilities to limit the pod placement on specific nodes.

now th pod-definition file looks like this:
--------------------------------------------->

apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoreDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: size
            operator: In
            values:
            - Large

So what if the nodeAffinity could not match a node with a given expression.
In this case what if there are no nodes with label called size while scheduling pods on nodes.

All of these answered using the NodeAffinity Types:
----------------------------------------------------->
Available:

1. requiredDuringSchedulingIgnoreDuringExecution
2. prefferedDuringSchedulingIgnoringDuringExecution

Planned:

1. requiredDuringSchedulingRequiredDuringExecution


What IF ... if you do not have kube-scheduler in your cluster...
and you want to manually schedule the pods on the nodes.

How:
---->

lets start with simple pod-definition.yml file
Every POD has a field called nodeName that, by default, is not set.
kube-scheduler automatically assigns this nodeName as binding-object while runtime.

So if you do not have the kube-scheduler in your cluster then in the POD-definition file,
you have to specify the nodeName field to schedule the pods while creating the pods as below.

apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    name: nginx
    type: frontend
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 8080
  nodeName: node02


What IF you do not specify the nodeName while creating the POD, then how to schedule a pod on the node.

There is another way to assign a node to existing pod is to create binding object and send a POST request,
to the  binding API thus mimicking what the actual scheduler does. in the binding object you specify
the name of the node as a target as below

pod-bind-definition.yaml

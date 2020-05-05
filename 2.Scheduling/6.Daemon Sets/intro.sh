Daemonsets runs one copy of pod on each node of our cluster.

whenever a new node is added to the cluster a replica of the pod is automatically added to the node.
and when a node is removed the posd is automatically removed.



usecases for daemonsets:
------------------------->
So we would like to deploy on each node of our cluster
1. a monitoring agent
2. a log collector

And daemonset is perfect for that as it can deploy the monitoring agent in the form of pod on each node of our cluster.

example-1:
---------->
In each of the worker node in the k8s cluster we should require the "kube-proxy".
So kube-proxy can be deployed as a daemonset

bharathdasaraju@MacBook-Pro (master) $ kubectl get daemonset -n kube-system -o wide
NAME         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS   IMAGES                          SELECTOR
kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   37d   kube-proxy   k8s.gcr.io/kube-proxy:v1.18.0   k8s-app=kube-proxy
bharathdasaraju@MacBook-Pro (master) $

example-2:
---------->
Another usecase is for networking. Networking solutions like "weave-net" required an agent to be deployed on each node in the k8s cluster.

Creating a DaemonSet is similar to the Replicaset Creation process.
ReplicaSet:
------------->
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: monitoring-daemon
spec:
  selector:
    matchLabels:
      app: monitoring-agent
  template:
    metadata:
      labels:
        app: monitoring-agent
    spec:
      containers:
        - name: monitoring-agent
          image: monitoring-agent

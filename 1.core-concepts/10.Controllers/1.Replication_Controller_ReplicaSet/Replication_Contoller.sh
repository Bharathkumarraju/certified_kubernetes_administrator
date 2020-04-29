The replication controller helps us run multiple instances of a single pod in the kubernets cluster.
Thus providing high availability.

The replication controller ensures that the specified number of pods are running all times even its just one or hundread.

Loadbalancing & Scaling:
--------------------------->
Another reason for replication controller is to create multiple pods to share the load across them.

For example we have a single pod serving a set of users when the number of users increases,
We deploy additional pod to balance the load across the cluster.

if the demand further increases and if we were to run out of resources on the first node,
we could deploy additional pods across the other nodes in the cluster.

As you can see the replication controller spans pods across multiple nodes in the cluster.
It helps us balance the load across multiple pods on different nodes as well as scale our application when the demand increases.

ReplicationController and Replica Set :
----------------------------------------------->

ReplicationController is the older term now it has been changed as the ReplicaSet

ReplicaSet:
--------------->

apiVersion: v1
kind: ReplicationController
metadata:
  name: bharathapp-replicationset
  labels:
    app: bharathapp
    type: front-end
spec:
# We know that the ReplicationController creates the multiple pods, but what Pod.
# we create a template section under spec to provide a pod template to be used by ReplicationController to create replicas
# So under spec we need to define a POD template, Now how do we define a pod template...
  template:
    metadata:
      name: bharaths-pod
      labels:
        app: bharathapp
        type: front-end
    spec:
      containers:
        - name: nginx-container
          image: nginx


bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $ kubectl apply -f ReplicationController-definition.yaml
  replicationcontroller/bharathapp-replicationset created
bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $

bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $ kubectl get all
  NAME                                  READY   STATUS    RESTARTS   AGE
  pod/bharathapp-replicationset-vnm2v   1/1     Running   0          45s
  pod/bharathapp-replicationset-w2rn2   1/1     Running   0          45s
  pod/bharaths-pod                      1/1     Running   0          4m7s

  NAME                                              DESIRED   CURRENT   READY   AGE
  replicationcontroller/bharathapp-replicationset   3         3         3       45s

  NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
  service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   31d
bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $
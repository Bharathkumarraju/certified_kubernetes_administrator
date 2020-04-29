
ReplicationController and Replica Set :
----------------------------------------------->

ReplicationController is the older term now it has been changed as the ReplicaSet

The most important differece between ReplicationController and ReplicaSet is that
1. In ReplicaSet apiVersion: apps/v1
2. In ReplicaSet the kind: ReplicaSet
3. In ReplicaSet under "spec" under "template" we have to add the "selector"


there is one major difference between ReplicationController and ReplicaSet, ReplicaSet requires a selector definition
the selector section helps the replicaset identify what pods fall under it,

but why would you have to specify what pods fall under it.If we have provided the contents of the pod definition file itself
in the template, its because ReplicaSet can also manage pods that were not created as part of the ReplicaSet creation.

Say for example there were pods created before the creation of the ReplicaSet that match labels specified in the selector.
The ReplicaSet, then will also take those pods also into consideration when creating the replicas.

ReplicaSet:
--------------->

apiVersion: apps/v1
kind: ReplicaSet
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
  replicas: 3
  selector:
    matchLabels:
      type: front-end


bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $ kubectl apply -f ReplicaSet-definition.yaml
replicaset.apps/bharathapp-replicationset created
bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $ kubectl get pods
NAME                              READY   STATUS              RESTARTS   AGE
bharathapp-replicationset-bpssf   0/1     ContainerCreating   0          4s
bharathapp-replicationset-frcx9   0/1     ContainerCreating   0          4s
bharathapp-replicationset-qhz7x   0/1     ContainerCreating   0          4s
bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $

bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $ kubectl get all
NAME                                  READY   STATUS    RESTARTS   AGE
pod/bharathapp-replicationset-bpssf   1/1     Running   0          28s
pod/bharathapp-replicationset-frcx9   1/1     Running   0          28s
pod/bharathapp-replicationset-qhz7x   1/1     Running   0          28s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   31d

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/bharathapp-replicationset   3         3         3       28s

bharathdasaraju@MacBook-Pro 1.Replication_Controller_ReplicaSet (master) $

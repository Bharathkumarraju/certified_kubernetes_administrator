The deployment provides us with the capability of upgrade the underlying instances,
seamlessly using rolling updates, undo changes, and pause and resume changes as required.

The API yaml file is exactly same as ReplicaSet


ReplicaSet == Deployment
------------------------->

apiVersion: apps/v1
kind: Deployment
metadata:
  name: bharathapp-deploy
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


bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl apply -f  Deployment.yaml
deployment.apps/bharaths-deployment created
bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get all
NAME                                      READY   STATUS              RESTARTS   AGE
pod/bharaths-deployment-f7dfc67b8-6j865   0/1     ContainerCreating   0          6s
pod/bharaths-deployment-f7dfc67b8-6lzqj   0/1     ContainerCreating   0          6s
pod/bharaths-deployment-f7dfc67b8-96s2z   0/1     ContainerCreating   0          6s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   31d


NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/bharaths-deployment   0/3     3            0           6s

NAME                                            DESIRED   CURRENT   READY   AGE
replicaset.apps/bharaths-deployment-f7dfc67b8   3         3         0       6s

bharathdasaraju@MacBook-Pro 12.Deployments (master) $

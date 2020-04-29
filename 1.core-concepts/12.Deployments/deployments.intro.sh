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
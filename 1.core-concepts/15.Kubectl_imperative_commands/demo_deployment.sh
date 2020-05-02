master $ kubectl create deployment webapp --image=kodekloud/webapp-color --dry-run -o yaml > deploy-definition.yml
master $ cat deploy-definition.yml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: webapp
  name: webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webapp
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webapp
    spec:
      containers:
      - image: kodekloud/webapp-color
        name: webapp-color
        resources: {}
status: {}
master $



master $ kubectl create deployment webapp --image=kodekloud/webapp-color --dry-run -o yaml > deploy.yaml
master $ vim deploy.yaml
master $ kubectl apply -f deploy.yaml
deployment.apps/webapp created
master $

############# best way to do is as below ####################################

master $ kubectl create deployment webapp --image=kodekloud/webapp-color
deployment.apps/webapp created.

echo "Now scale the replicas using kubectl scale command simple :) "

master $ kubectl scale deployment webapp --replicas=3
deployment.apps/webapp scaled.

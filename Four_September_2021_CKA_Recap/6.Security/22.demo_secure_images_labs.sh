MacBook-Pro:6.Security bharathdasaraju$ kubectl create deployment webapp --image=nginx 
deployment.apps/webapp created
MacBook-Pro:6.Security bharathdasaraju$ 


the deployment to use a new image from myprivateregistry.com:5000
The registry is located at myprivateregistry.com:5000



Create a secret object with the credentials required to access the registry.


Name: private-reg-cred
Username: dock_user
Password: dock_password
Server: myprivateregistry.com:5000
Email: dock_user@myprivateregistry.com

Secret: private-reg-cred
Secret Type: docker-registry
Secret Data


MacBook-Pro:6.Security bharathdasaraju$ kubectl create secret docker-registry private-reg-cred --docker-server=myprivateregistry.com:5000 --docker-username=dock_user --docker-password=dock_password --docker-email=test@gmail.com
secret/private-reg-cred created
MacBook-Pro:6.Security bharathdasaraju$

MacBook-Pro:6.Security bharathdasaraju$ kubectl describe secret private-reg-cred
Name:         private-reg-cred
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/dockerconfigjson

Data
====
.dockerconfigjson:  159 bytes
MacBook-Pro:6.Security bharathdasaraju$ 


kubectl edit deploy web command and add "imagePullSecrets" section. Use private-reg-cred

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: webapp
  name: webapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webapp
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
        - image: myprivateregistry.com:5000/nginx:alpine 
          name: nginx
      imagePullSecrets:
        - name: private-reg-cred



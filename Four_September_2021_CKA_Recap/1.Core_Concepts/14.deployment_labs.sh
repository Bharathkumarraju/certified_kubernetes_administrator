root@controlplane:~# kubectl create deployment httpd-frontend --image=httpd:2.4-alpine --replicas=3 --dry-run=client -o yaml > httpd_alpine_deploy.yaml
root@controlplane:~# 



root@controlplane:~# cat httpd_alpine_deploy.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: httpd-frontend
  name: httpd-frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: httpd-frontend
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: httpd-frontend
    spec:
      containers:
      - image: httpd:2.4-alpine
        name: httpd
        resources: {}
status: {}
root@controlplane:~#



root@controlplane:~# kubectl get all -l app=httpd-frontend
NAME                                  READY   STATUS    RESTARTS   AGE
pod/httpd-frontend-5ddf995bdf-b6sft   1/1     Running   0          2m14s
pod/httpd-frontend-5ddf995bdf-mnkdz   1/1     Running   0          2m14s
pod/httpd-frontend-5ddf995bdf-z9xv4   1/1     Running   0          2m14s

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/httpd-frontend   3/3     3            3           2m14s

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/httpd-frontend-5ddf995bdf   3         3         3       2m14s
root@controlplane:~# 




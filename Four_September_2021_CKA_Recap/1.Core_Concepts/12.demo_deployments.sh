The manifest file for deployment is exactly same as replicaSet exacept the kind is Deployment now.


apiVersion: apps/v1
kind: ReplicaSet --> Deployment
metadata:
  labels:
    run: nginx
    type: front-end
  name: nginx-rs
spec:
  template:
    metadata:
      labels:
        run: nginx
        type: front-end 
    spec:
      containers:
      - image: nginx
        name: nginx
  selector:
    matchLabels:
      type: front-end
  replicas: 3





bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f deployment-definition.yaml 
deployment.apps/nginx-deployment created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/nginx-deployment-766794d85c-22z9x   1/1     Running   0          33s
pod/nginx-deployment-766794d85c-gkzkn   1/1     Running   0          33s
pod/nginx-deployment-766794d85c-q7pn7   1/1     Running   0          33s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6d17h

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-deployment   3/3     3            3           3m56s

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-deployment-766794d85c   3         3         3       33s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



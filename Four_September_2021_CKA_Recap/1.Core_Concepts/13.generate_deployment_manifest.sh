kubectl create deployment redis-deploy --image=redis --replicas=4 --dry-run=client -o yaml > redis-deployment.yaml


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create deployment redis-deploy --image=redis --replicas=4 --dry-run=client -o yaml > redis-deployment.yaml


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f redis-deployment.yaml 
deployment.apps/redis-deploy created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create deployment redis-deploy --image=redis --replicas=4 --dry-run=client -o yaml > redis-deployment.yaml
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f redis-deployment.yaml 
deployment.apps/redis-deploy created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get all -l app=redis-deploy
NAME                                READY   STATUS    RESTARTS   AGE
pod/redis-deploy-68fb445555-2rhp9   1/1     Running   0          3m47s
pod/redis-deploy-68fb445555-h6rx5   1/1     Running   0          3m47s
pod/redis-deploy-68fb445555-qz4st   1/1     Running   0          3m47s
pod/redis-deploy-68fb445555-tvzfk   1/1     Running   0          3m47s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-deploy   4/4     4            4           3m47s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-deploy-68fb445555   4         4         4       3m47s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



The generated deployment file is like below:
------------------------------------------------>
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: redis-deploy
  name: redis-deploy
spec:
  replicas: 4
  selector:
    matchLabels:
      app: redis-deploy
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: redis-deploy
    spec:
      containers:
      - image: redis
        name: redis
        resources: {}
status: {}

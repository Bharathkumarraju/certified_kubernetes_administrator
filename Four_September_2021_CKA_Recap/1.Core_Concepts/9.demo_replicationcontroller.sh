multiple instances of pods
loadbalancing and pods


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f rc-definition.yaml 
replicationcontroller/bkapp-rc created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME             READY   STATUS              RESTARTS   AGE
bkapp-rc-8l5p4   0/1     ContainerCreating   0          10s
bkapp-rc-ksd2j   1/1     Running             0          11s
bkapp-rc-zlxcw   0/1     ContainerCreating   0          11s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME             READY   STATUS              RESTARTS   AGE
bkapp-rc-8l5p4   1/1     Running             0          18s
bkapp-rc-ksd2j   1/1     Running             0          19s
bkapp-rc-zlxcw   0/1     ContainerCreating   0          19s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
bkapp-rc-8l5p4   1/1     Running   0          26s
bkapp-rc-ksd2j   1/1     Running   0          27s
bkapp-rc-zlxcw   1/1     Running   0          27s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get all -n default
NAME                 READY   STATUS    RESTARTS   AGE
pod/bkapp-rc-8l5p4   1/1     Running   0          65s
pod/bkapp-rc-ksd2j   1/1     Running   0          66s
pod/bkapp-rc-zlxcw   1/1     Running   0          66s

NAME                             DESIRED   CURRENT   READY   AGE
replicationcontroller/bkapp-rc   3         3         3       66s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   26h
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl  get replicationcontroller
NAME       DESIRED   CURRENT   READY   AGE
bkapp-rc   3         3         3       100s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl  get rc
NAME       DESIRED   CURRENT   READY   AGE
bkapp-rc   3         3         3       105s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
bkapp-rc-8l5p4   1/1     Running   0          6m13s
bkapp-rc-ksd2j   1/1     Running   0          6m14s
bkapp-rc-zlxcw   1/1     Running   0          6m14s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 








bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl api-resources | grep -i replica
replicationcontrollers            rc                                          true         ReplicationController
replicasets                       rs           apps                           true         ReplicaSet
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl api-versions | grep -i apps
apps/v1
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

the difference between replication controller and replicaset is...for ReplicaSet we need specify the selector definition in manifest file.

selector:
  matchLabels:
    type: front-end



replicaset.apps/bkapp-replicaset created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get rs
NAME               DESIRED   CURRENT   READY   AGE
bkapp-replicaset   3         3         1       9s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get rs
NAME               DESIRED   CURRENT   READY   AGE
bkapp-replicaset   3         3         2       15s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get rs
NAME               DESIRED   CURRENT   READY   AGE
bkapp-replicaset   3         3         3       20s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
bkapp-rc-8l5p4           1/1     Running   0          19m
bkapp-rc-ksd2j           1/1     Running   0          19m
bkapp-rc-zlxcw           1/1     Running   0          19m
bkapp-replicaset-5hnxx   1/1     Running   0          33s
bkapp-replicaset-hbtkt   1/1     Running   0          33s
bkapp-replicaset-zkcdg   1/1     Running   0          33s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get all -n default
NAME                         READY   STATUS    RESTARTS   AGE
pod/bkapp-rc-8l5p4           1/1     Running   0          19m
pod/bkapp-rc-ksd2j           1/1     Running   0          19m
pod/bkapp-rc-zlxcw           1/1     Running   0          19m
pod/bkapp-replicaset-5hnxx   1/1     Running   0          53s
pod/bkapp-replicaset-hbtkt   1/1     Running   0          53s
pod/bkapp-replicaset-zkcdg   1/1     Running   0          53s

NAME                             DESIRED   CURRENT   READY   AGE
replicationcontroller/bkapp-rc   3         3         3       19m

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   27h

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/bkapp-replicaset   3         3         3       53s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 




Number of ways to scale the replicas:
---------------------------------------------------->
1. Update replicaset-definition.yaml as replicas: 4 and run below -->
1. kubectl replace -f replicaset-definition.yaml
2. kubectl scale --replicas=5 -f replicaset-definition.yaml
3. kubectl scale --replicas=6 replicaset bkapp-replicaset

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl replace -f replicaset-definition.yaml 
replicaset.apps/bkapp-replicaset replaced
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
bkapp-replicaset-5hnxx   1/1     Running   0          157m
bkapp-replicaset-bghvv   1/1     Running   0          20s
bkapp-replicaset-hbtkt   1/1     Running   0          157m
bkapp-replicaset-zkcdg   1/1     Running   0          157m
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl scale --replicas=5 -f replicaset-definition.yaml 
replicaset.apps/bkapp-replicaset scaled
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl edit rs bkapp-replicaset
Edit cancelled, no changes made.
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
bkapp-replicaset-5hnxx   1/1     Running   0          160m
bkapp-replicaset-bghvv   1/1     Running   0          3m26s
bkapp-replicaset-hbtkt   1/1     Running   0          160m
bkapp-replicaset-nfhwp   1/1     Running   0          58s
bkapp-replicaset-zkcdg   1/1     Running   0          160m
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl scale --replicas=6 replicaset bkapp-replicaset
replicaset.apps/bkapp-replicaset scaled
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
bkapp-replicaset-5hnxx   1/1     Running   0          167m
bkapp-replicaset-7pq6p   1/1     Running   0          6m31s
bkapp-replicaset-bghvv   1/1     Running   0          10m
bkapp-replicaset-hbtkt   1/1     Running   0          167m
bkapp-replicaset-nfhwp   1/1     Running   0          8m
bkapp-replicaset-zkcdg   1/1     Running   0          167m
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f replicaset_recap.yaml 
replicaset.apps/nginx-rs created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get all
NAME                 READY   STATUS    RESTARTS   AGE
pod/nginx            1/1     Running   0          7m13s
pod/nginx-rs-fxjkk   1/1     Running   0          34s
pod/nginx-rs-mkkqc   1/1     Running   0          34s
pod/nginx-rs-tfnjq   1/1     Running   0          34s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6d17h

NAME                       DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-rs   3         3         3       34s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


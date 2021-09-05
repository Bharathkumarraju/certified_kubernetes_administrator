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





How to rollback deployment to previous revision.
Run the "kubectl rollout undo followed by the name of the deployment".
The Deployment will then destroy the PODS in the new replicaset and bring the older ones up in the old replicaset

bharathdasaraju@MacBook-Pro (master) $ kubectl rollout undo deployment/myapp-deployment
deployment.apps/myapp-deployment rolled back
bharathdasaraju@MacBook-Pro (master) $


Newer Replicaset:
---------------------------------------------------------------------------->
bharathdasaraju@MacBook-Pro (master) $ clear
bharathdasaraju@MacBook-Pro (master) $ kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/myapp-deployment-6c47ff47db-8b5xj   1/1     Running   0          12m
pod/myapp-deployment-6c47ff47db-gc9gp   1/1     Running   0          13m
pod/myapp-deployment-6c47ff47db-kszc9   1/1     Running   0          13m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/myapp-deployment   3/3     3            3           20m

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/myapp-deployment-6c47ff47db   3         3         3       13m
replicaset.apps/myapp-deployment-75ff5c9c5c   0         0         0       14m
replicaset.apps/myapp-deployment-7995d9946d   0         0         0       20m
replicaset.apps/myapp-deployment-877df9495    0         0         0       20m
bharathdasaraju@MacBook-Pro (master) $


after rollback changed to Older Replicaset:
---------------------------------------------------------------------------->
bharathdasaraju@MacBook-Pro (master) $ kubectl get all
NAME                                    READY   STATUS    RESTARTS   AGE
pod/myapp-deployment-75ff5c9c5c-bcc48   1/1     Running   0          114s
pod/myapp-deployment-75ff5c9c5c-ltrnq   1/1     Running   0          105s
pod/myapp-deployment-75ff5c9c5c-mtdvz   1/1     Running   0          97s

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/myapp-deployment   3/3     3            3           40m

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/myapp-deployment-6c47ff47db   0         0         0       33m
replicaset.apps/myapp-deployment-75ff5c9c5c   3         3         3       34m
replicaset.apps/myapp-deployment-7995d9946d   0         0         0       40m
replicaset.apps/myapp-deployment-877df9495    0         0         0       39m

bharathdasaraju@MacBook-Pro (master) $
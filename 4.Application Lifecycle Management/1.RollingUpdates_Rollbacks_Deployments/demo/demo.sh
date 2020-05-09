First lets run curl pod in the kube-public namespace.

master $ kubectl edit deployment frontend
deployment.apps/frontend edited
master $

master $ kubectl get all
NAME                            READY   STATUS        RESTARTS   AGE
pod/frontend-57d7bb8dbd-55sns   1/1     Terminating   0          16m
pod/frontend-57d7bb8dbd-8mzjq   1/1     Running       0          16m
pod/frontend-57d7bb8dbd-jcgqk   1/1     Running       0          16m
pod/frontend-57d7bb8dbd-xtg9v   1/1     Running       0          16m
pod/frontend-84bb97f469-czb6r   1/1     Running       0          17s
pod/frontend-84bb97f469-fm7p8   1/1     Running       0          17s

NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.96.0.1      <none>        443/TCP          17m
service/webapp-service   NodePort    10.98.62.117   <none>        8080:30080/TCP   16m

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/frontend   5/4     2            3           16m

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/frontend-57d7bb8dbd   3         3         3       16m
replicaset.apps/frontend-84bb97f469   2         2         2       17s
master $


https://2886795302-30080-kitek06.environments.katacoda.com/


bharathdasaraju@MacBook-Pro (master) $ curl -k -I "https://2886795302-30080-kitek06.environments.katacoda.com/"
HTTP/2 200
server: nginx/1.15.0
date: Fri, 08 May 2020 03:56:04 GMT
content-type: text/html; charset=utf-8
content-length: 301
via: 1.1 google
alt-svc: clear

bharathdasaraju@MacBook-Pro (master) $

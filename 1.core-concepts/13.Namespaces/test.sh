master $ kubectl run redis --image=redis --generator=run-pod/v1 -n finance
pod/redis created

master $ kubectl get pods -n finance
NAME      READY   STATUS    RESTARTS   AGE
payroll   1/1     Running   0          2m54s
redis     1/1     Running   0          19s
master $

Question:
What DNS name should the Blue application use to access the database 'db-service' in the 'dev' namespace
You can try it in the web application UI. Use port 3306.

db-service.dev.svc.cluster.local:3306


master $ kubectl get all -n  marketing
NAME           READY   STATUS    RESTARTS   AGE
pod/blue       1/1     Running   0          5m17s
pod/mysql-db   1/1     Running   0          5m17s

NAME                   TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/blue-service   NodePort   10.111.23.97   <none>        8080:30082/TCP   5m17s
service/db-service     NodePort   10.104.55.29   <none>        3306:30402/TCP   5m17s


master $ kubectl get all -n  manufacturing
NAME          READY   STATUS    RESTARTS   AGE
pod/red-app   1/1     Running   0          5m34s

NAME                  TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/red-service   NodePort   10.103.42.162   <none>        8080:30080/TCP   5m33s


master $ kubectl get all -n dev
NAME           READY   STATUS    RESTARTS   AGE
pod/mysql-db   1/1     Running   0          6m39s

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/db-service   ClusterIP   10.99.150.94   <none>        3306/TCP   6m38s
master $
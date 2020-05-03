master $ kubectl get pods
NAME          READY   STATUS    RESTARTS   AGE
app-1-75bnt   1/1     Running   0          28s
app-1-89kkj   1/1     Running   0          28s
app-1-rjvqb   1/1     Running   0          28s
app-1-zzxdf   1/1     Running   0          28s
app-2-mq58g   1/1     Running   0          28s
auth          1/1     Running   0          28s
db-1-9j4c6    1/1     Running   0          28s
db-1-crp6n    1/1     Running   0          28s
db-1-rv849    1/1     Running   0          28s
db-1-srz7q    1/1     Running   0          28s
db-2-w5sjs    1/1     Running   0          28s
master $

master $ kubectl get pods --selector env=dev
NAME          READY   STATUS    RESTARTS   AGE
app-1-75bnt   1/1     Running   0          90s
app-1-89kkj   1/1     Running   0          90s
app-1-rjvqb   1/1     Running   0          90s
db-1-9j4c6    1/1     Running   0          90s
db-1-crp6n    1/1     Running   0          90s
db-1-rv849    1/1     Running   0          90s
db-1-srz7q    1/1     Running   0          90s
master $

master $ kubectl get pods --selector bu=finance
NAME          READY   STATUS    RESTARTS   AGE
app-1-75bnt   1/1     Running   0          2m23s
app-1-89kkj   1/1     Running   0          2m23s
app-1-rjvqb   1/1     Running   0          2m23s
app-1-zzxdf   1/1     Running   0          2m23s
auth          1/1     Running   0          2m23s
db-2-w5sjs    1/1     Running   0          2m23s
master $


master $ kubectl get pods --selector bu=finance
NAME          READY   STATUS    RESTARTS   AGE
app-1-75bnt   1/1     Running   0          2m23s
app-1-89kkj   1/1     Running   0          2m23s
app-1-rjvqb   1/1     Running   0          2m23s
app-1-zzxdf   1/1     Running   0          2m23s
auth          1/1     Running   0          2m23s
db-2-w5sjs    1/1     Running   0          2m23s
master $ kubectl get all --selector env=prod
NAME              READY   STATUS    RESTARTS   AGE
pod/app-1-zzxdf   1/1     Running   0          3m35s
pod/app-2-mq58g   1/1     Running   0          3m35s
pod/auth          1/1     Running   0          3m35s
pod/db-2-w5sjs    1/1     Running   0          3m35s

NAME            TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/app-1   ClusterIP   10.107.3.91   <none>        3306/TCP   3m35s

NAME                    DESIRED   CURRENT   READY   AGE
replicaset.apps/app-2   1         1         1       3m35s
replicaset.apps/db-2    1         1         1       3m35s
master $

=====================================================================================:

Identify the POD which is 'prod', part of 'finance' BU and is a 'frontend' tier?

master $ kubectl get pods --selector env=prod,bu=finance,tier=frontend
NAME          READY   STATUS    RESTARTS   AGE
app-1-zzxdf   1/1     Running   0          6m33s
master $

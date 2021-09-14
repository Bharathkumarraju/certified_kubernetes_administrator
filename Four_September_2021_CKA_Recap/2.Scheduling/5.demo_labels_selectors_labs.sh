bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get pods --selector app=App1
NAME               READY   STATUS    RESTARTS   AGE
nginx              1/1     Running   0          108m
sample-web-sdfsx   1/1     Running   0          14m
sample-web-x648g   1/1     Running   0          14m
bharathdasaraju@MacBook-Pro 2.Scheduling % 


We have deployed a number of PODs. They are labelled with tier, env and bu. How many PODs exist in the dev environment?

root@controlplane:~# kubectl get pods --selector env=dev
NAME          READY   STATUS    RESTARTS   AGE
app-1-7pdj8   1/1     Running   0          7m26s
app-1-848jw   1/1     Running   0          7m26s
app-1-9qzgq   1/1     Running   0          7m26s
db-1-4jl5f    1/1     Running   0          7m26s
db-1-j5xpx    1/1     Running   0          7m26s
db-1-ltqng    1/1     Running   0          7m26s
db-1-s2w87    1/1     Running   0          7m26s
root@controlplane:~#

root@controlplane:~# kubectl get pods --selector bu=finance
NAME          READY   STATUS    RESTARTS   AGE
app-1-7pdj8   1/1     Running   0          8m12s
app-1-848jw   1/1     Running   0          8m12s
app-1-9qzgq   1/1     Running   0          8m12s
app-1-zzxdf   1/1     Running   0          8m11s
auth          1/1     Running   0          8m12s
db-2-kwxn9    1/1     Running   0          8m12s
root@controlplane:~# 


root@controlplane:~# kubectl get all --selector env=prod
NAME              READY   STATUS    RESTARTS   AGE
pod/app-1-zzxdf   1/1     Running   0          9m
pod/app-2-whmqr   1/1     Running   0          9m1s
pod/auth          1/1     Running   0          9m1s
pod/db-2-kwxn9    1/1     Running   0          9m1s

NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/app-1   ClusterIP   10.109.116.5   <none>        3306/TCP   9m

NAME                    DESIRED   CURRENT   READY   AGE
replicaset.apps/app-2   1         1         1       9m1s
replicaset.apps/db-2    1         1         1       9m1s
root@controlplane:~# 


root@controlplane:~# kubectl get all --selector env=prod,bu=finance,tier=frontend
NAME              READY   STATUS    RESTARTS   AGE
pod/app-1-zzxdf   1/1     Running   0          12m
root@controlplane:~#


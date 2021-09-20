root@controlplane:~# kubectl get all 
NAME                            READY   STATUS    RESTARTS   AGE
pod/frontend-7776cb7d57-9gd9n   1/1     Running   0          29s
pod/frontend-7776cb7d57-nfgrt   1/1     Running   0          29s
pod/frontend-7776cb7d57-t7gvg   1/1     Running   0          29s
pod/frontend-7776cb7d57-vr7zg   1/1     Running   0          29s

NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP          116s
service/webapp-service   NodePort    10.104.185.173   <none>        8080:30080/TCP   29s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/frontend   4/4     4            0           29s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/frontend-7776cb7d57   4         4         4       29s
root@controlplane:~# 


root@controlplane:~# ls -rtlh
total 8.0K
-rwxr-xr-x 1 root root 216 Sep 14 01:32 curl-test.sh
-rw-rw-rw- 1 root root 186 Sep 14 01:32 curl-pod.yaml
root@controlplane:~# 



root@controlplane:~# ./curl-test.sh 
Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

root@controlplane:~# 



root@controlplane:~# kubectl describe deploy frontend
Name:                   frontend
Namespace:              default
CreationTimestamp:      Mon, 20 Sep 2021 12:54:01 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               name=webapp
Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        20
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  name=webapp
  Containers:
   simple-webapp:
    Image:        kodekloud/webapp-color:v1
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   frontend-7776cb7d57 (4/4 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  5m50s  deployment-controller  Scaled up replica set frontend-7776cb7d57 to 4
root@controlplane:~# 


root@controlplane:~# kubectl describe deploy frontend | grep -i strategy
StrategyType:           RollingUpdate
RollingUpdateStrategy:  25% max unavailable, 25% max surge
root@controlplane:~# 

root@controlplane:~# kubectl edit deploy frontend
deployment/frontend edited
root@controlplane:~#


root@controlplane:~# kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
frontend-7776cb7d57   3         3         3       8m25s
frontend-7c7fcfc8cb   2         2         0       10s
root@controlplane:~# kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
frontend-7776cb7d57   3         3         3       8m28s
frontend-7c7fcfc8cb   2         2         2       13s
root@controlplane:~# kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
frontend-7776cb7d57   3         3         3       8m33s
frontend-7c7fcfc8cb   2         2         2       18s
root@controlplane:~# kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
frontend-7776cb7d57   1         1         1       8m47s
frontend-7c7fcfc8cb   4         4         2       32s
root@controlplane:~# kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
frontend-7776cb7d57   1         1         1       9m5s
frontend-7c7fcfc8cb   4         4         4       50s
root@controlplane:~# kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
frontend-7776cb7d57   0         0         0       9m21s
frontend-7c7fcfc8cb   4         4         4       66s
root@controlplane:~#


root@controlplane:~# ./curl-test.sh 
Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

root@controlplane:~# 


root@controlplane:~# kubectl edit deploy frontend 
deployment.apps/frontend edited
root@controlplane:~# 


root@controlplane:~# kubectl edit deploy frontend 
deployment.apps/frontend edited
root@controlplane:~# 

root@controlplane:~# ./curl-test.sh 
Hello, Application Version: v3 ; Color: red OK

Hello, Application Version: v3 ; Color: red OK

Hello, Application Version: v3 ; Color: red OK

Hello, Application Version: v3 ; Color: red OK

Hello, Application Version: v3 ; Color: red OK

Hello, Application Version: v3 ; Color: red OK

Hello, Application Version: v3 ; Color: red OK

Hello, Application Version: v3 ; Color: red OK

Hello, Application Version: v3 ; Color: red OK

root@controlplane:~# 
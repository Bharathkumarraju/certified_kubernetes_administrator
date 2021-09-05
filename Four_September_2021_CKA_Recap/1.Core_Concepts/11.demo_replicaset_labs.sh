root@controlplane:~# kubectl get rs -n default
NAME              DESIRED   CURRENT   READY   AGE
new-replica-set   4         4         0       17s
root@controlplane:~# 


root@controlplane:~# kubectl get pods
NAME                    READY   STATUS             RESTARTS   AGE
new-replica-set-cz24w   0/1     ImagePullBackOff   0          56s
new-replica-set-dd8qv   0/1     ImagePullBackOff   0          56s
new-replica-set-nhq2b   0/1     ImagePullBackOff   0          56s
new-replica-set-w7qqj   0/1     ImagePullBackOff   0          56s
root@controlplane:~# kubectl describe pod  new-replica-set-cz24w -n default
Name:         new-replica-set-cz24w
Namespace:    default
Priority:     0
Node:         controlplane/10.42.79.3
Start Time:   Sun, 05 Sep 2021 20:58:58 +0000
Labels:       name=busybox-pod
Annotations:  <none>
Status:       Pending
IP:           10.244.0.4
IPs:
  IP:           10.244.0.4
Controlled By:  ReplicaSet/new-replica-set
Containers:
  busybox-container:
    Container ID:  
    Image:         busybox777
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo Hello Kubernetes! && sleep 3600
    State:          Waiting
      Reason:       ImagePullBackOff
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-k65w6 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  default-token-k65w6:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-k65w6
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  86s                default-scheduler  Successfully assigned default/new-replica-set-cz24w to controlplane
  Normal   Pulling    36s (x3 over 81s)  kubelet            Pulling image "busybox777"
  Warning  Failed     35s (x3 over 79s)  kubelet            Failed to pull image "busybox777": rpc error: code = Unknown desc = Error response from daemon: pull access denied for busybox777, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
  Warning  Failed     35s (x3 over 79s)  kubelet            Error: ErrImagePull
  Normal   BackOff    13s (x5 over 79s)  kubelet            Back-off pulling image "busybox777"
  Warning  Failed     13s (x5 over 79s)  kubelet            Error: ImagePullBackOff
root@controlplane:~# 



root@controlplane:~# kubectl delete pod new-replica-set-cz24w -n default
pod "new-replica-set-cz24w" deleted
root@controlplane:~# 
root@controlplane:~# kubectl get pods
NAME                    READY   STATUS             RESTARTS   AGE
new-replica-set-dd8qv   0/1     ImagePullBackOff   0          4m33s
new-replica-set-nhq2b   0/1     ImagePullBackOff   0          4m33s
new-replica-set-vflzg   0/1     ImagePullBackOff   0          83s
new-replica-set-w7qqj   0/1     ImagePullBackOff   0          4m33s
root@controlplane:~# 




NAME              DESIRED   CURRENT   READY   AGE
new-replica-set   4         4         0       16m
replicaset-1      2         2         2       6m20s
replicaset-2      2         2         2       51s
root@controlplane:~# 



root@controlplane:~# kubectl edit rs new-replica-set -n default
replicaset.apps/new-replica-set edited
root@controlplane:~#
root@controlplane:~# kubectl delete pod new-replica-set-dd8qv new-replica-set-nhq2b new-replica-set-vflzg new-replica-set-w7qqj 
pod "new-replica-set-dd8qv" deleted
pod "new-replica-set-nhq2b" deleted
pod "new-replica-set-vflzg" deleted
pod "new-replica-set-w7qqj" deleted
root@controlplane:~# 

root@controlplane:~# kubectl edit rs new-replica-set -n default
replicaset.apps/new-replica-set edited
root@controlplane:~# 

root@controlplane:~# kubectl scale rs new-replica-set --replicas=2 -n default
replicaset.apps/new-replica-set scaled
root@controlplane:~# kubectl get pods
NAME                    READY   STATUS        RESTARTS   AGE
new-replica-set-424fn   1/1     Terminating   0          3m33s
new-replica-set-98mdn   1/1     Terminating   0          3m33s
new-replica-set-9rh6l   1/1     Running       0          3m33s
new-replica-set-hrqmq   1/1     Running       0          3m33s
new-replica-set-k7bbq   1/1     Terminating   0          74s
root@controlplane:~# kubectl get pods
NAME                    READY   STATUS        RESTARTS   AGE
new-replica-set-424fn   1/1     Terminating   0          3m39s
new-replica-set-98mdn   1/1     Terminating   0          3m39s
new-replica-set-9rh6l   1/1     Running       0          3m39s
new-replica-set-hrqmq   1/1     Running       0          3m39s
new-replica-set-k7bbq   1/1     Terminating   0          80s
root@controlplane:~# 


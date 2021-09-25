root@controlplane:~# kubectl get pods
NAME     READY   STATUS    RESTARTS   AGE
webapp   1/1     Running   0          14s
root@controlplane:~# 


root@controlplane:~# kubectl describe pod webapp 
Name:         webapp
Namespace:    default
Priority:     0
Node:         controlplane/10.51.220.9
Start Time:   Sat, 25 Sep 2021 00:57:24 +0000
Labels:       <none>
Annotations:  <none>
Status:       Running
IP:           10.244.0.4
IPs:
  IP:  10.244.0.4
Containers:
  event-simulator:
    Container ID:   docker://6b01ef3409ea8fa1044717f94d8fc3c5a85fd468ac4049b67cd981b1453a4ab1
    Image:          kodekloud/event-simulator
    Image ID:       docker-pullable://kodekloud/event-simulator@sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sat, 25 Sep 2021 00:57:34 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      LOG_HANDLERS:  file
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-rqj8k (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  default-token-rqj8k:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-rqj8k
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  49s   default-scheduler  Successfully assigned default/webapp to controlplane
  Normal  Pulling    47s   kubelet            Pulling image "kodekloud/event-simulator"
  Normal  Pulled     40s   kubelet            Successfully pulled image "kodekloud/event-simulator" in 7.353654278s
  Normal  Created    39s   kubelet            Created container event-simulator
  Normal  Started    39s   kubelet            Started container event-simulator
root@controlplane:~#



root@controlplane:~# kubectl exec webapp -- cat /log/app.log
[2021-09-25 00:57:34,911] INFO in event-simulator: USER2 logged in
[2021-09-25 00:57:35,911] INFO in event-simulator: USER1 logged out
[2021-09-25 00:57:36,913] INFO in event-simulator: USER1 logged in
[2021-09-25 00:57:37,913] INFO in event-simulator: USER1 is viewing page1
[2021-09-25 00:57:38,915] INFO in event-simulator: USER3 logged out
[2021-09-25 00:57:39,916] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-25 00:57:39,916] INFO in event-simulator: USER1 logged in
[2021-09-25 00:57:40,917] INFO in event-simulator: USER2 is viewing page1
[2021-09-25 00:57:41,918] INFO in event-simulator: USER2 is viewing page2
[2021-09-25 00:57:42,919] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2021-09-25 00:57:42,920] INFO in event-simulator: USER3 logged out
[2021-09-25 00:57:43,920] INFO in event-simulator: USER1 is viewing page2
[2021-09-25 00:57:44,922] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-25 00:57:44,922] INFO in event-simulator: USER2 is viewing page1
[2021-09-25 00:57:45,922] INFO in event-simulator: USER3 is viewing page2
[2021-09-25 00:57:46,924] INFO in event-simulator: USER4 logged out
[2021-09-25 00:57:47,925] INFO in event-simulator: USER3 logged out
[2021-09-25 00:57:48,925] INFO in event-simulator: USER2 is viewing page3
[2021-09-25 00:57:49,926] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-25 00:57:49,927] INFO in event-simulator: USER2 is viewing page2
[2021-09-25 00:57:50,928] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2021-09-25 00:57:50,928] INFO in event-simulator: USER2 is viewing page3
[2021-09-25 00:57:51,929] INFO in event-simulator: USER4 logged in
[2021-09-25 00:57:52,930] INFO in event-simulator: USER3 is viewing page1
[2021-09-25 00:57:53,932] INFO in event-simulator: USER4 is viewing page3
root@controlplane:~# 

Configure a volume to store these logs at /var/log/webapp on the host.

#===============================================================================

apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  containers:
  - name: event-simulator
    image: kodekloud/event-simulator
    env:
    - name: LOG_HANDLERS
      value: file
    volumeMounts:
    - mountPath: /log
      name: log-volume

  volumes:
  - name: log-volume
    hostPath:
      # directory location on host
      path: /var/log/webapp
      # this field is optional
      type: Directory

#===============================================================================




root@controlplane:~# kubectl edit pod webapp 
error: pods "webapp" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-6ic2t.yaml"
error: Edit cancelled, no valid changes were saved.
root@controlplane:~# kubectl delete pod webapp
pod "webapp" deleted


root@controlplane:/var/log/webapp# pwd
/var/log/webapp
root@controlplane:/var/log/webapp# ls -rtlh
total 8.0K
-rw-r--r-- 1 root root 4.1K Sep 25 01:08 app.log
root@controlplane:/var/log/webapp# tail -f app.log 
[2021-09-25 01:08:48,417] INFO in event-simulator: USER1 is viewing page2
[2021-09-25 01:08:49,417] INFO in event-simulator: USER1 logged in
[2021-09-25 01:08:50,419] INFO in event-simulator: USER1 is viewing page1
[2021-09-25 01:08:51,420] INFO in event-simulator: USER3 logged in
[2021-09-25 01:08:52,421] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-25 01:08:52,421] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2021-09-25 01:08:52,421] INFO in event-simulator: USER1 logged out
[2021-09-25 01:08:53,422] INFO in event-simulator: USER4 is viewing page1
[2021-09-25 01:08:54,423] INFO in event-simulator: USER4 is viewing page1
[2021-09-25 01:08:55,424] INFO in event-simulator: USER4 is viewing page2
[2021-09-25 01:08:56,426] INFO in event-simulator: USER2 is viewing page2
[2021-09-25 01:08:57,426] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-25 01:08:57,427] INFO in event-simulator: USER1 is viewing page3
[2021-09-25 01:08:58,428] INFO in event-simulator: USER2 logged in
[2021-09-25 01:08:59,429] INFO in event-simulator: USER3 is viewing page3
[2021-09-25 01:09:00,430] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2021-09-25 01:09:00,430] INFO in event-simulator: USER2 logged out
[2021-09-25 01:09:01,432] INFO in event-simulator: USER1 is viewing page3
[2021-09-25 01:09:02,433] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-25 01:09:02,433] INFO in event-simulator: USER1 is viewing page1
[2021-09-25 01:09:03,434] INFO in event-simulator: USER3 is viewing page1
^C
root@controlplane:/var/log/webapp#


Create a Persistent Volume with the given specification.
Volume Name: pv-log
Storage: 100Mi
Access Modes: ReadWriteMany
Host Path: /pv/log
Reclaim Policy: Retain

root@controlplane:~# vim pv.yaml
root@controlplane:~# kubectl apply -f pv.yaml
persistentvolume/pv-log created
root@controlplane:~# 



Let us claim some of that storage for our application. Create a Persistent Volume Claim with the given specification.

Volume Name: claim-log-1
Storage Request: 50Mi
Access Modes: ReadWriteOnce



root@controlplane:~# kubectl get pv,pvc
NAME                      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
persistentvolume/pv-log   100Mi      RWX            Retain           Available                                   6m33s

NAME                                STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/claim-log-1   Pending                                                     26s
root@controlplane:~# 


AccessModes also should match on bot PV and PVC 



root@controlplane:~# kubectl delete pvc claim-log-1
persistentvolumeclaim "claim-log-1" deleted
root@controlplane:~# kubectl apply -f pvc.yaml
persistentvolumeclaim/claim-log-1 created
root@controlplane:~# kubectl get pv,pvc -o wide
NAME                      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   REASON   AGE   VOLUMEMODE
persistentvolume/pv-log   100Mi      RWX            Retain           Bound    default/claim-log-1                           12m   Filesystem

NAME                                STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE   VOLUMEMODE
persistentvolumeclaim/claim-log-1   Bound    pv-log   100Mi      RWX                           18s   Filesystem
root@controlplane:~# 



root@controlplane:~# kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM                 STORAGECLASS   REASON   AGE
pv-log   100Mi      RWX            Retain           Released   default/claim-log-1                           25m
root@controlplane:~# 









root@controlplane:~# kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
blue    1/1     Running   0          103s
green   2/2     Running   0          103s
red     1/1     Running   0          103s
root@controlplane:~#


root@controlplane:~# kubectl describe pod blue                 
Name:         blue
Namespace:    default
Priority:     0
Node:         controlplane/10.8.36.3
Start Time:   Tue, 21 Sep 2021 05:35:44 +0000
Labels:       <none>
Annotations:  <none>
Status:       Running
IP:           10.244.0.6
IPs:
  IP:  10.244.0.6
Init Containers:
  init-myservice:
    Container ID:  docker://cb6b4b67652aaab333bc31891c817b30804888aa1070f310d8bcd278d65e93ef
    Image:         busybox
    Image ID:      docker-pullable://busybox@sha256:52f73a0a43a16cf37cd0720c90887ce972fe60ee06a687ee71fb93a7ca601df7
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleep 5
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 21 Sep 2021 05:35:53 +0000
      Finished:     Tue, 21 Sep 2021 05:35:58 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-5lj6j (ro)
Containers:
  green-container-1:
    Container ID:  docker://e4e921212ffdb2dde1ea8823172327b8cdce5ff51dbc4cdeca704ef5b7280d5a
    Image:         busybox:1.28
    Image ID:      docker-pullable://busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo The app is running! && sleep 3600
    State:          Running
      Started:      Tue, 21 Sep 2021 05:35:59 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-5lj6j (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  default-token-5lj6j:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-5lj6j
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  67s   default-scheduler  Successfully assigned default/blue to controlplane
  Normal  Pulling    63s   kubelet            Pulling image "busybox"
  Normal  Pulled     59s   kubelet            Successfully pulled image "busybox" in 3.086779983s
  Normal  Created    59s   kubelet            Created container init-myservice
  Normal  Started    58s   kubelet            Started container init-myservice
  Normal  Pulled     53s   kubelet            Container image "busybox:1.28" already present on machine
  Normal  Created    53s   kubelet            Created container green-container-1
  Normal  Started    52s   kubelet            Started container green-container-1
root@controlplane:~#



root@controlplane:~# kubectl get pods
NAME     READY   STATUS     RESTARTS   AGE
blue     1/1     Running    0          3m2s
green    2/2     Running    0          3m2s
purple   0/1     Init:0/2   0          9s
red      1/1     Running    0          3m2s
root@controlplane:~# 



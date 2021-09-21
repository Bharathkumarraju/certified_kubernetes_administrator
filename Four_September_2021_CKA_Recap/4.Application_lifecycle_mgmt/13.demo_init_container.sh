if we want to run a process that runs to completion in a container. 
For example a process that pulls a code or binary from a repository that will be used by the main web application.


That is a task that will be run only one time when the pod is first created. 
Or a process that waits for an external service or database to be up before the actual application starts. 
That’s where initContainers comes in



MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl apply -f 14.demo_init_container_example.yaml 
pod/bkapp-pod created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl get pods
NAME        READY   STATUS             RESTARTS   AGE
bkapp-pod   0/1     Init:Error         0          10s
nginx       1/2     CrashLoopBackOff   16         59m
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl describe pod bkapp-pod
Name:         bkapp-pod
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Tue, 21 Sep 2021 13:31:40 +0800
Labels:       app=bkapp
Annotations:  <none>
Status:       Pending
IP:           172.17.0.4
IPs:
  IP:  172.17.0.4
Init Containers:
  init-bkservice:
    Container ID:  docker://56d6fdf4e53adf06947b10fa1457c2ae266ba5e3110a99a10091af8d9ae09101
    Image:         busybox
    Image ID:      docker-pullable://busybox@sha256:52f73a0a43a16cf37cd0720c90887ce972fe60ee06a687ee71fb93a7ca601df7
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      git clone git@github.com:Bharathkumarraju/certified_kubernetes_administrator.git;
    State:          Terminated
      Reason:       Error
      Exit Code:    127
      Started:      Tue, 21 Sep 2021 13:32:12 +0800
      Finished:     Tue, 21 Sep 2021 13:32:12 +0800
    Last State:     Terminated
      Reason:       Error
      Exit Code:    127
      Started:      Tue, 21 Sep 2021 13:31:50 +0800
      Finished:     Tue, 21 Sep 2021 13:31:50 +0800
    Ready:          False
    Restart Count:  2
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lxpp9 (ro)
  init-bkdb:
    Container ID:  
    Image:         busybox
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      until nslookup mydb; do echo waiting for mydb; sleep 2; done;
    State:          Waiting
      Reason:       PodInitializing
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lxpp9 (ro)
Containers:
  bkapp-container:
    Container ID:  
    Image:         busybox:1.28
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo the app is running!! && sleep 3600
    State:          Waiting
      Reason:       PodInitializing
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lxpp9 (ro)
Conditions:
  Type              Status
  Initialized       False 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  default-token-lxpp9:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-lxpp9
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  37s                default-scheduler  Successfully assigned default/bkapp-pod to minikube
  Normal   Pulled     32s                kubelet            Successfully pulled image "busybox" in 4.0991627s
  Normal   Pulled     27s                kubelet            Successfully pulled image "busybox" in 3.8770697s
  Normal   Pulling    10s (x3 over 36s)  kubelet            Pulling image "busybox"
  Normal   Created    5s (x3 over 32s)   kubelet            Created container init-bkservice
  Normal   Started    5s (x3 over 31s)   kubelet            Started container init-bkservice
  Normal   Pulled     5s                 kubelet            Successfully pulled image "busybox" in 5.2892604s
  Warning  BackOff    4s (x3 over 25s)   kubelet            Back-off restarting failed container
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 
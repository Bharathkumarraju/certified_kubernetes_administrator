In a single pod we can use two containers like 1.WEB Server and 2.Logging Agent
can share same storage and network, can communicate via localhost

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl run nginx --image=nginx --dry-run=client -o yaml > multi_container_pod.yaml
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl apply -f multi_container_pod.yaml
pod/nginx created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl describe pod nginx
Name:         nginx
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Tue, 21 Sep 2021 12:32:17 +0800
Labels:       run=nginx
Annotations:  <none>
Status:       Pending
IP:           
IPs:          <none>
Containers:
  nginx:
    Container ID:   
    Image:          nginx
    Image ID:       
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lxpp9 (ro)
  busybox:
    Container ID:   
    Image:          busybox
    Image ID:       
    Port:           <none>
    Host Port:      <none>
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lxpp9 (ro)
Conditions:
  Type              Status
  Initialized       True 
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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  15s   default-scheduler  Successfully assigned default/nginx to minikube
  Normal  Pulling    14s   kubelet            Pulling image "nginx"
  Normal  Pulled     8s    kubelet            Successfully pulled image "nginx" in 6.110889s
  Normal  Created    8s    kubelet            Created container nginx
  Normal  Started    8s    kubelet            Started container nginx
  Normal  Pulling    8s    kubelet            Pulling image "busybox"
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 


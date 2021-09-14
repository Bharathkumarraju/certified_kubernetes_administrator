Labels and selectors in the kubernetes

app=App1
function=Front-end

app=App2
function=Back-end

app=App3
function=Database


bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl run nginx --image=nginx --port=80 -l app=App1,function=Front-end --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    app: App1
    function: Front-end
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
    - containerPort: 80
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
bharathdasaraju@MacBook-Pro 2.Scheduling % 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl apply -f pod_with_labales.yaml                                                                                   
pod/nginx created
bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get pod nginx -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          11s   172.17.0.2   minikube   <none>           <none>
bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl describe  pod nginx 
Name:         nginx
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Tue, 14 Sep 2021 19:50:13 +0800
Labels:       app=App1
              function=Front-end
Annotations:  <none>
Status:       Running
IP:           172.17.0.2
IPs:
  IP:  172.17.0.2
Containers:
  nginx:
    Container ID:   docker://acd72109ba5fd062466487124e89cea38d84e94c48e5f21bc35015ddbcc811ef
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:853b221d3341add7aaadf5f81dd088ea943ab9c918766e295321294b035f3f3e
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 14 Sep 2021 19:50:19 +0800
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lxpp9 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
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
  Normal  Scheduled  27s   default-scheduler  Successfully assigned default/nginx to minikube
  Normal  Pulling    26s   kubelet            Pulling image "nginx"
  Normal  Pulled     21s   kubelet            Successfully pulled image "nginx" in 5.4914337s
  Normal  Created    21s   kubelet            Created container nginx
  Normal  Started    21s   kubelet            Started container nginx
bharathdasaraju@MacBook-Pro 2.Scheduling %

how to select specific pods 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get pods --selector app=App1
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          2m19s
bharathdasaraju@MacBook-Pro 2.Scheduling % 


ReplicaSet labels are two types 
1. one is replicaset labels.
2. another one is pod labels.

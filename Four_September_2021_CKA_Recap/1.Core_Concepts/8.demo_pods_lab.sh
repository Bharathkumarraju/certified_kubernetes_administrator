root@controlplane:~# kubectl run nginx --image=nginx
pod/nginx created
root@controlplane:~# 


root@controlplane:~# kubectl get pods
NAME            READY   STATUS    RESTARTS   AGE
newpods-54kvg   1/1     Running   0          2m3s
newpods-bmpxk   1/1     Running   0          2m3s
newpods-w66pw   1/1     Running   0          2m3s
nginx           1/1     Running   0          2m38s
root@controlplane:~# 

root@controlplane:~# kubectl run redis --image=redis123
pod/redis created
root@controlplane:~# kubectl get pods
NAME            READY   STATUS             RESTARTS   AGE
newpods-54kvg   1/1     Running            0          9m34s
newpods-bmpxk   1/1     Running            0          9m34s
newpods-w66pw   1/1     Running            0          9m34s
nginx           1/1     Running            0          10m
redis           0/1     ImagePullBackOff   0          6s
root@controlplane:~# 

root@controlplane:~# kubectl run redis --image=redis   
Error from server (AlreadyExists): pods "redis" already exists

# Edit pod definition file and update the image
root@controlplane:~# kubectl edit pod redis  
pod/redis edited
root@controlplane:~# 



bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl run redis --image=redis123 --dry-run=client -o yaml > Four_September_2021_CKA_Recap/sample_pod.yaml
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 
---------------------------------------------------------------------------
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: redis
  name: redis
spec:
  containers:
  - image: redis123
    name: redis
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
---------------------------------------------------------------------------

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl apply -f sample_pod.yaml
pod/redis created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl describe pod redis | grep -iA20 Events
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  86s                default-scheduler  Successfully assigned default/redis to minikube
  Normal   Pulling    28s (x3 over 86s)  kubelet            Pulling image "redis123"
  Warning  Failed     20s (x3 over 79s)  kubelet            Failed to pull image "redis123": rpc error: code = Unknown desc = Error response from daemon: pull access denied for redis123, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
  Warning  Failed     20s (x3 over 79s)  kubelet            Error: ErrImagePull
  Normal   BackOff    9s (x3 over 79s)   kubelet            Back-off pulling image "redis123"
  Warning  Failed     9s (x3 over 79s)   kubelet            Error: ImagePullBackOff
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl apply -f sample_pod.yaml 
pod/redis configured
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          7h44m
redis   1/1     Running   0          2m41s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl describe pod redis | grep -iA10 Events
Events:
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  2m56s                default-scheduler  Successfully assigned default/redis to minikube
  Normal   BackOff    74s (x5 over 2m48s)  kubelet            Back-off pulling image "redis123"
  Warning  Failed     74s (x5 over 2m48s)  kubelet            Error: ImagePullBackOff
  Normal   Pulling    60s (x4 over 2m55s)  kubelet            Pulling image "redis123"
  Warning  Failed     53s (x4 over 2m48s)  kubelet            Failed to pull image "redis123": rpc error: code = Unknown desc = Error response from daemon: pull access denied for redis123, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
  Warning  Failed     53s (x4 over 2m48s)  kubelet            Error: ErrImagePull
  Normal   Pulling    45s                  kubelet            Pulling image "redis"
  Normal   Pulled     25s                  kubelet            Successfully pulled image "redis" in 20.0685611s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl edit pod redis
Edit cancelled, no changes made.
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl delete pod redis nginx
pod "redis" deleted
pod "nginx" deleted
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl run nginx --image=nginx1818 --dry-run=client -o yaml > sample_pod_nginx.yaml
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl apply -f sample_pod_nginx.yaml 
pod/nginx created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl describe pod nginx | grep -iA20 "Events"
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  60s                default-scheduler  Successfully assigned default/nginx to minikube
  Normal   BackOff    21s (x2 over 51s)  kubelet            Back-off pulling image "nginx1818"
  Warning  Failed     21s (x2 over 51s)  kubelet            Error: ImagePullBackOff
  Normal   Pulling    9s (x3 over 59s)   kubelet            Pulling image "nginx1818"
  Warning  Failed     1s (x3 over 51s)   kubelet            Failed to pull image "nginx1818": rpc error: code = Unknown desc = Error response from daemon: pull access denied for nginx1818, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
  Warning  Failed     1s (x3 over 51s)   kubelet            Error: ErrImagePull
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl edit pod nginx
pod/nginx edited
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl delete pod nginx
pod "nginx" deleted
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl run redis --image=redis1234 --dry-run=client -o yaml > sample_pod_redis.yaml
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl apply -f sample_pod_redis.yaml 
pod/redis created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl describe pod redis | grep -iA25 "Events"
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  5s    default-scheduler  Successfully assigned default/redis to minikube
  Normal  Pulling    5s    kubelet            Pulling image "redis1234"
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl describe pod redis | grep -iA25 "Events"
Events:
  Type     Reason     Age   From               Message
  ----     ------     ----  ----               -------
  Normal   Scheduled  9s    default-scheduler  Successfully assigned default/redis to minikube
  Normal   Pulling    8s    kubelet            Pulling image "redis1234"
  Warning  Failed     1s    kubelet            Failed to pull image "redis1234": rpc error: code = Unknown desc = Error response from daemon: pull access denied for redis1234, repository does not exist or may require 'docker login': denied: requested access to the resource is denied
  Warning  Failed     1s    kubelet            Error: ErrImagePull
  Normal   BackOff    1s    kubelet            Back-off pulling image "redis1234"
  Warning  Failed     1s    kubelet            Error: ImagePullBackOff
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl edit pod redis
pod/redis edited
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl apply -f sample_pod_redis.yaml 
pod/redis configured
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
redis   1/1     Running   1          2m54s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


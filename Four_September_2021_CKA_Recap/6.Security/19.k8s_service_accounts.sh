service accounts in kubernetes:
------------------------------------>

There are two types of accounts in k8s

1. User accounts --> used by users
user accounts is an administrator who performing the cluster upgrade or node reboot :) 

2. Service accounts --> used by machines
A service account could be an account used by an application to interact with a kubernetes cluster.

For example: A monitoring application like prometheus uses a service account to poll the kubernetes API for performance metrics
and an automated build tool like jenkins uses a service account to deploy the application in kubernetes cluster.


MacBook-Pro:6.Security bharathdasaraju$ kubectl create serviceaccount dashboard-sa
serviceaccount/dashboard-sa created
MacBook-Pro:6.Security bharathdasaraju$ kubectl get sa
NAME           SECRETS   AGE
dashboard-sa   1         42s
default        1         19d
MacBook-Pro:6.Security bharathdasaraju$ 


MacBook-Pro:6.Security bharathdasaraju$ kubectl describe sa dashboard-sa
Name:                dashboard-sa
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   dashboard-sa-token-zvz8j
Tokens:              dashboard-sa-token-zvz8j
Events:              <none>
MacBook-Pro:6.Security bharathdasaraju$ 


MacBook-Pro:6.Security bharathdasaraju$ kubectl describe secret dashboard-sa-token-zvz8j
Name:         dashboard-sa-token-zvz8j
Namespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: dashboard-sa
              kubernetes.io/service-account.uid: f8f95fe6-d654-4cac-a8c2-26d50d4995df

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1066 bytes
namespace:  7 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IjNZMmtub0JrMENOVG91QW1TdUYwR1RKUTRkTEJldXdaUllCaDhKOGFlLVkifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRhc2hib2FyZC1zYS10b2tlbi16dno4aiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkYXNoYm9hcmQtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJmOGY5NWZlNi1kNjU0LTRjYWMtYThjMi0yNmQ1MGQ0OTk1ZGYiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkYXNoYm9hcmQtc2EifQ.m1SBFXAh1UBxyDbyo8q4C3b55oE_GKZv3YW6kwF_IuEz0s9oVYa4i0G7nh8zs1LB2D6mrwGK2G9Y9BV6dH08woCdXJJOpkZH_h8gdwAMWVsMByuBJUwwm-hyRx0X7-O332v6kjhCd7XDQ8TPfz2GLMKC2YO9m_Oe3E1EbQkBWfzJnFHoIN7mWwwvHXdeov3rlDQSxM7MwxHx4JHT1NoSu15SJarcOQ8LXsulYW394InejrR1eQBwYa9yLBuN0Fgj8QwWqY60hJihd-T9vGqfuzRGm3FWePhosZirVjiajR2-pwAAd2o5cfCpr5ZPO4WKdoMLs81r4KOLB4Wbh_RB_A
MacBook-Pro:6.Security bharathdasaraju$ 


We can use this token as "Bearer Token" to query the kubernetes API and get the resutls to our app.

curl https://192.168.56.70:6443/api --insecure --header "Authorization: Bearer eyJhbGciOiJSU....81r4KOLB4Wbh_RB_A"

if you run the application inside the same  kubernetes cluster, we can mount the secret token as a volume so that it automatically availble inside a pod.

MacBook-Pro:6.Security bharathdasaraju$ kubectl get sa
NAME           SECRETS   AGE
dashboard-sa   1         9m21s
default        1         19d
MacBook-Pro:6.Security bharathdasaraju$ kubectl describe sa default
Name:                default
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   default-token-lxpp9
Tokens:              default-token-lxpp9
Events:              <none>
MacBook-Pro:6.Security bharathdasaraju$ kubectl describe secret default-token-lxpp9
Name:         default-token-lxpp9
Namespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 7a0dc882-5dd6-4233-90c7-e8502644250e

Type:  kubernetes.io/service-account-token

Data
====
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IjNZMmtub0JrMENOVG91QW1TdUYwR1RKUTRkTEJldXdaUllCaDhKOGFlLVkifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tbHhwcDkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjdhMGRjODgyLTVkZDYtNDIzMy05MGM3LWU4NTAyNjQ0MjUwZSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.DNsKGkklsdZ9dpaTH_hT29tHhD3-HiFQ8lctdPGaZGudKSkfe2nSEFoWsc5nO_sqrAg-t-s4ZLf5xsR1cYfbdh7Dqshx5MFS9RzZN5gy05em7Q3aoKfx3nXtN8wsnHlWejSAgrTUYjIhcmy3lJCFWZzFQO66OScVI2Dl9tqXM8plnLEmHGSd-InEZSI4B_Y4EWlYQi6Q8rQBzHVnn1pioztQzIQlhDIw0s0D7MGikVLdWChNDn0fdHqcBbGGasS0jxHrtu9WbYGy26q3ZqIjEsgGzygOv15L92AAnmXYcvDMcMKlRcRgpH02kodWLrmMxSj9-3pnXfkwqcoRqRBfOA
ca.crt:     1066 bytes
namespace:  7 bytes
MacBook-Pro:6.Security bharathdasaraju$ 



MacBook-Pro:6.Security bharathdasaraju$ kubectl run nginx --image=nginx
pod/nginx created
MacBook-Pro:6.Security bharathdasaraju$

"if we deacribe the pod....we can see below secret token mounted to pod"
"========================================================================================================="
Containers:
  nginx:
    Container ID:   docker://f4fcdfa20357c5fcd21548a564214ecc6c9eb7bb0a08c4f385ec8cb65791c02d
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:853b221d3341add7aaadf5f81dd088ea943ab9c918766e295321294b035f3f3e
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 23 Sep 2021 21:19:33 +0800
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-lxpp9 (ro)
Volumes:
  default-token-lxpp9:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-lxpp9
    Optional:    false
"============================================================================================="

MacBook-Pro:6.Security bharathdasaraju$ kubectl describe pod nginx
Name:         nginx
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Thu, 23 Sep 2021 21:19:26 +0800
Labels:       run=nginx
Annotations:  <none>
Status:       Running
IP:           172.17.0.4
IPs:
  IP:  172.17.0.4
Containers:
  nginx:
    Container ID:   docker://f4fcdfa20357c5fcd21548a564214ecc6c9eb7bb0a08c4f385ec8cb65791c02d
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:853b221d3341add7aaadf5f81dd088ea943ab9c918766e295321294b035f3f3e
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 23 Sep 2021 21:19:33 +0800
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
  Normal  Scheduled  16s   default-scheduler  Successfully assigned default/nginx to minikube
  Normal  Pulling    15s   kubelet            Pulling image "nginx"
  Normal  Pulled     9s    kubelet            Successfully pulled image "nginx" in 5.7508824s
  Normal  Created    9s    kubelet            Created container nginx
  Normal  Started    9s    kubelet            Started container nginx
MacBook-Pro:6.Security bharathdasaraju$

MacBook-Pro:6.Security bharathdasaraju$ kubectl run nginx --image=nginx --dry-run=client -o yaml > pod_with_serviceaccount.yaml
MacBook-Pro:6.Security bharathdasaraju$ 


By default ....default serviceaccount token gets mounted to pod specification file.
if you do not want default service account to get mounted to pod we need use "automountServiceAccountToken: false"

apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
  automountServiceAccountToken: false
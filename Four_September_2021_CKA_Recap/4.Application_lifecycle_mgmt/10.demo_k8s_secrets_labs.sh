root@controlplane:~# kubectl get secrets
NAME                  TYPE                                  DATA   AGE
default-token-2sjz4   kubernetes.io/service-account-token   3      10m
root@controlplane:~# kubectl describe secret default-token-2sjz4                   
Name:         default-token-2sjz4
Namespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: default
              kubernetes.io/service-account.uid: 90c997a2-3d2f-4d56-ae75-37f1950e68d8

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1066 bytes
namespace:  7 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6ImhzVDRDcHQwdVFRYTZQSTFVYlRFcUZVX3JIbmxxWE9EcWxDWUpaUmpkdlUifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRlZmF1bHQtdG9rZW4tMnNqejQiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiZGVmYXVsdCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjkwYzk5N2EyLTNkMmYtNGQ1Ni1hZTc1LTM3ZjE5NTBlNjhkOCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpkZWZhdWx0OmRlZmF1bHQifQ.thnQGTwepuST8EFY9lzMLDTqWZk87q_9nQ1sNMEaqxToxNgba7feuvjK7TQjIt9mwhSMRGym8LaztUAfP8QcYRjGlUR_hb91pJGsYA09d4XpYkycMUk5xpYPa6ppzndzkdYeLEaXZHXBbI6eESuolyjdvhlgDq9z-zjxc0wnnClW9xs_WYVacQx9j6qBRPonwlmNfykboK2SKQu-Uex4VPD2ksWVX_64mf7CmiGMbzqzO52V977vvsQFZ8VZ7465LTtaupgyj2wZ23I2R-85Uich22z3CX-wWKK3RmbGjSBjvQkH1E3Uu9CoBnFOBPJipM1PVkA5fXx1xQhMcQ5ROA
root@controlplane:~# 


root@controlplane:~# kubectl get all
NAME             READY   STATUS    RESTARTS   AGE
pod/mysql        1/1     Running   0          65s
pod/webapp-pod   1/1     Running   0          65s

NAME                     TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP          13m
service/sql01            ClusterIP   10.103.199.107   <none>        3306/TCP         65s
service/webapp-service   NodePort    10.98.251.213    <none>        8080:30080/TCP   65s
root@controlplane:~# 



root@controlplane:~# kubectl create secret generic db-secret --from-literal=DB_Host=sql01 --dry-run=client -o yaml > db-secret.yaml
root@controlplane:~# vim db-secret.yaml 
root@controlplane:~# echo -n "root" | base64
cm9vdA==
root@controlplane:~# echo -n "password123" | base64
cGFzc3dvcmQxMjM=
root@controlplane:~# vim db-secret.yaml 
root@controlplane:~# vim db-secret.yaml 
root@controlplane:~# kubectl apply -f db-secret.yaml
secret/db-secret created
root@controlplane:~# 



root@controlplane:~# kubectl get secrets
NAME                  TYPE                                  DATA   AGE
db-secret             Opaque                                3      5m5s
default-token-2sjz4   kubernetes.io/service-account-token   3      22m
root@controlplane:~# 


root@controlplane:~# kubectl describe pod webapp-pod 
Name:         webapp-pod
Namespace:    default
Priority:     0
Node:         controlplane/10.3.212.3
Start Time:   Tue, 21 Sep 2021 03:36:02 +0000
Labels:       name=webapp-pod
Annotations:  <none>
Status:       Running
IP:           10.244.0.6
IPs:
  IP:  10.244.0.6
Containers:
  webapp:
    Container ID:   docker://58376983854ab2f58fccca3623fb6f0a5b79439dfe2a5a8d612320a9cde9c901
    Image:          kodekloud/simple-webapp-mysql
    Image ID:       docker-pullable://kodekloud/simple-webapp-mysql@sha256:92943d2b3ea4a1db7c8a9529cd5786ae3b9999e0246ab665c29922e9800d1b41
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 21 Sep 2021 03:36:41 +0000
    Ready:          True
    Restart Count:  0
    Environment Variables from:
      db-secret   Secret  Optional: false
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-2sjz4 (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  default-token-2sjz4:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-2sjz4
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason   Age   From     Message
  ----    ------   ----  ----     -------
  Normal  Pulling  67s   kubelet  Pulling image "kodekloud/simple-webapp-mysql"
  Normal  Pulled   67s   kubelet  Successfully pulled image "kodekloud/simple-webapp-mysql" in 253.892074ms
  Normal  Created  66s   kubelet  Created container webapp
  Normal  Started  65s   kubelet  Started container webapp
root@controlplane:~# 


root@controlplane:~# kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   11m
root@controlplane:~# 


root@controlplane:~# kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   11m
root@controlplane:~# kubectl edit service kubernetes
Edit cancelled, no changes made.
root@controlplane:~# kubectl edit service kubernetes
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2021-09-12T23:44:04Z"
  labels:
    component: apiserver
    provider: kubernetes
  name: kubernetes
  namespace: default
  resourceVersion: "201"
  uid: a2ebf456-c63a-4923-851d-b27bd3b55906
spec:
  clusterIP: 10.96.0.1
  clusterIPs:
  - 10.96.0.1
  ports:
  - name: https
    port: 443
    protocol: TCP
    targetPort: 6443
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
~                                                                                                                
~                                                                                                                
"/tmp/kubectl-edit-fuoo7.yaml" 28L, 664C   

root@controlplane:~# 

root@controlplane:~# kubectl get ep          
NAME         ENDPOINTS          AGE
kubernetes   10.49.247.3:6443   19m
root@controlplane:~# kubectl edit ep kubernetes 
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
kind: Endpoints
metadata:
  creationTimestamp: "2021-09-12T23:44:04Z"
  labels:
    endpointslice.kubernetes.io/skip-mirror: "true"
  name: kubernetes
  namespace: default
  resourceVersion: "203"
  uid: bd579fd9-da5e-4d32-be46-33b6ab16e376
subsets:
- addresses:
  - ip: 10.49.247.3
  ports:
  - name: https
    port: 6443
    protocol: TCP
root@controlplane:~# 

root@controlplane:~# kubectl get deploy
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
simple-webapp-deployment   0/4     4            0           11s
root@controlplane:~# 

root@controlplane:~# kubectl describe deploy  simple-webapp-deployment
Name:                   simple-webapp-deployment
Namespace:              default
CreationTimestamp:      Mon, 13 Sep 2021 00:05:24 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               name=simple-webapp
Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  name=simple-webapp
  Containers:
   simple-webapp:
    Image:        kodekloud/simple-webapp:red
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
NewReplicaSet:   simple-webapp-deployment-b56f88b77 (4/4 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  19m   deployment-controller  Scaled up replica set simple-webapp-deployment-b56f88b77 to 4
root@controlplane:~# 

root@controlplane:~# vim service-definition-1.yaml 
root@controlplane:~# cat service-definition-1.yaml
---
apiVersion: v1
kind: Service
metadata: webapp-service
  name:
spec:
  type: NodePort
  ports:
    - targetPort: 8080
      port: 8080
      nodePort: 30080
  selector:
    name: simple-webapp
root@controlplane:~# 


root@controlplane:~# kubectl create -f service-definition-1.yaml 
service/webapp-service created
root@controlplane:~# 


root@controlplane:~# 
root@controlplane:~# kubectl get svc
NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP          41m
webapp-service   NodePort    10.101.212.188   <none>        8080:30080/TCP   98s
root@controlplane:~# kubectl describe service webapp-service
Name:                     webapp-service
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 name=simple-webapp
Type:                     NodePort
IP Families:              <none>
IP:                       10.101.212.188
IPs:                      10.101.212.188
Port:                     <unset>  8080/TCP
TargetPort:               8080/TCP
NodePort:                 <unset>  30080/TCP
Endpoints:                10.244.0.4:8080,10.244.0.5:8080,10.244.0.6:8080 + 1 more...
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>
root@controlplane:~# 



Minikube test:
---------------------->


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create deployment simple-webapp-deployment --replicas=3 --image=kodekloud/simple-webapp:red --dry-run=client -o yaml > simple-webapp-deployment.yaml
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f simple-webapp-deployment.yaml
The Deployment "simple-webapp-deployment" is invalid: spec.template.metadata.labels: Invalid value: map[string]string{"app":"simple-webapp-deployment"}: `selector` does not match template `labels`
kubectl create -f simple-webapp-deployment.yaml


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f simple-webapp-deployment.yaml
deployment.apps/simple-webapp-deployment created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get all
NAME                                            READY   STATUS    RESTARTS   AGE
pod/simple-webapp-deployment-85db7b94cf-prmrk   1/1     Running   0          2m4s
pod/simple-webapp-deployment-85db7b94cf-r6jqs   1/1     Running   0          2m4s
pod/simple-webapp-deployment-85db7b94cf-ss226   1/1     Running   0          2m4s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   8d

NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/simple-webapp-deployment   3/3     3            3           2m5s

NAME                                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/simple-webapp-deployment-85db7b94cf   3         3         3       2m5s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get svc
NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP          8d
webapp-service   NodePort    10.102.158.105   <none>        8080:30080/TCP   6s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


Create a service with "kubectl expose" command
"kubectl expose deployment simple-webapp-deployment --name=webapp-service --target-port=8080 --type=NodePort --port=8080 --dry-run=client -o yaml > simple_webapp_service.yaml"


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl delete svc webapp-service
service "webapp-service" deleted
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get deploy
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
simple-webapp-deployment   3/3     3            3           12m
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl expose deployment simple-webapp-deployment --name=webapp-service --target-port=8080 --type=NodePort --port=8080 --dry-run=client -o yaml > simple_webapp_service.yaml
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 
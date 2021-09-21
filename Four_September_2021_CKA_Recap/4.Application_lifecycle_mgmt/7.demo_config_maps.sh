ENV variables in kubernetes

1. use directly as env in pod specification file
2. use configMaps
3. Use secrets

apiVersion: v1
kind: Pod
metadata:
  labels:
    run: webapp-green
  name: webapp-green
spec:
  containers:
  - image: kodekloud/webapp-color
    name: webapp-green
    env:
     - name: APP_COLOR
       value: pink
     - name: APP_VERSION
       valueFrom:
         configMapKeyRef:
     - name: APP_BUILD
       valueFrom:
         secretKeyRef:


1. Create configMaps
2. Inject configMaps into the pod

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl create configmap applicatio-config --from-literal=APP_COLOR=pink --from-literal=APP_BUILD=prod --from-literal=APP_VERSION=1.0
configmaps "applicatio-config" created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl get cm 
NAME                DATA   AGE
applicatio-config   3      44s
kube-root-ca.crt    1      16d
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl get cm applicatio-config -o yaml
apiVersion: v1
data:
  APP_BUILD: prod
  APP_COLOR: pink
  APP_VERSION: "1.0"
kind: ConfigMap
metadata:
  creationTimestamp: "2021-09-20T23:41:13Z"
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:data:
        .: {}
        f:APP_BUILD: {}
        f:APP_COLOR: {}
        f:APP_VERSION: {}
    manager: kubectl-create
    operation: Update
    time: "2021-09-20T23:41:13Z"
  name: applicatio-config
  namespace: default
  resourceVersion: "100911"
  uid: 5495db4a-30e6-45cf-bfb1-923ab7e75791


MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl create cm  bkapp-config1 --from-file=./app_config.properties 
configmap/bkapp-config1 created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl get cm bkapp-config1 -o yaml
apiVersion: v1
data:
  app_config.properties: |-
    APP_COLOR=red
    APP_BUILD=preprod
    APP_VERSION=2.0
kind: ConfigMap
metadata:
  creationTimestamp: "2021-09-20T23:45:36Z"
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:data:
        .: {}
        f:app_config.properties: {}
    manager: kubectl-create
    operation: Update
    time: "2021-09-20T23:45:36Z"
  name: bkapp-config1
  namespace: default
  resourceVersion: "101103"
  uid: 684590da-7d86-4214-b67e-79bdfa7c06fc
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$


Declaratively create configmaps:
---------------------------------------------------------------->
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl apply -f demo_configmap.yaml 
configmap/bkconfigmap created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl get cm bkconfigmap -o yaml
apiVersion: v1
data:
  APP_BUID: dev
  APP_COLOR: pink
  APP_VERSION: "3.0"
kind: ConfigMap
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","data":{"APP_BUID":"dev","APP_COLOR":"pink","APP_VERSION":"3.0"},"kind":"ConfigMap","metadata":{"annotations":{},"labels":{"app":"bkapplication"},"name":"bkconfigmap","namespace":"default"}}
  creationTimestamp: "2021-09-20T23:49:38Z"
  labels:
    app: bkapplication
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:data:
        .: {}
        f:APP_BUID: {}
        f:APP_COLOR: {}
        f:APP_VERSION: {}
      f:metadata:
        f:annotations:
          .: {}
          f:kubectl.kubernetes.io/last-applied-configuration: {}
        f:labels:
          .: {}
          f:app: {}
    manager: kubectl-client-side-apply
    operation: Update
    time: "2021-09-20T23:49:38Z"
  name: bkconfigmap
  namespace: default
  resourceVersion: "101273"
  uid: 9e2932e7-06db-4a0c-b855-146a80928ad3
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 



MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl describe cm bkconfigmap
Name:         bkconfigmap
Namespace:    default
Labels:       app=bkapplication
Annotations:  <none>

Data
====
APP_BUID:
----
dev
APP_COLOR:
----
pink
APP_VERSION:
----
3.0
Events:  <none>
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 



MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl run nginx --image=nginx --port=8080 --dry-run=client -o yaml > use_configmaps_in_pod.yaml
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 


MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl apply -f use_configmaps_in_pod.yaml 
pod/nginx created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl describe pod nginx
Name:         nginx
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Tue, 21 Sep 2021 07:57:25 +0800
Labels:       run=nginx
Annotations:  <none>
Status:       Running
IP:           172.17.0.3
IPs:
  IP:  172.17.0.3
Containers:
  nginx:
    Container ID:   docker://c3ef07e5d47eb4c688c6096ce122cbe0d0bf8e32861c9c76789ebab030a4bb37
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:853b221d3341add7aaadf5f81dd088ea943ab9c918766e295321294b035f3f3e
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Tue, 21 Sep 2021 07:57:32 +0800
    Ready:          True
    Restart Count:  0
    Environment Variables from:
      bkconfigmap  ConfigMap  Optional: false
    Environment:   <none>
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
  Normal  Scheduled  9s    default-scheduler  Successfully assigned default/nginx to minikube
  Normal  Pulling    8s    kubelet            Pulling image "nginx"
  Normal  Pulled     2s    kubelet            Successfully pulled image "nginx" in 5.7820856s
  Normal  Created    2s    kubelet            Created container nginx
  Normal  Started    2s    kubelet            Started container nginx
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 
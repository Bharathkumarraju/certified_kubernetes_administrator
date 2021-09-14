root@controlplane:~# kubectl run nginx-pod --image=nginx:alpine
pod/nginx-pod created
root@controlplane:~# 


root@controlplane:~# kubectl run redis --image=redis:alpine --dry-run=client -o yaml > redis-pod.yamlroot@controlplane:~# vim redis-pod.yaml 
root@controlplane:~# kubectl apply -f redis-pod.yaml
pod/redis created
root@controlplane:~# 

Create a service redis-service to expose the redis application within the cluster on port 6379.



Use imperative commands.

root@controlplane:~# kubectl expose pod redis  --port=6379 --name=redis-service --dry-run=client -o yaml > redis-service.yaml
root@controlplane:~# vim 


root@controlplane:~# cat redis-service.yaml 
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    tier: db
  name: redis-service
spec:
  ports:
  - port: 6379
    protocol: TCP
    targetPort: 6379
  selector:
    tier: db
  type: ClusterIP
status:
  loadBalancer: {}
root@controlplane:~# 


root@controlplane:~# kubectl get all
NAME            READY   STATUS    RESTARTS   AGE
pod/nginx-pod   1/1     Running   0          8m15s
pod/redis       1/1     Running   0          5m52s

NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP    13m
service/redis-service   ClusterIP   10.106.124.133   <none>        6379/TCP   19s
root@controlplane:~# 


root@controlplane:~# kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3 --dry-run=client -o yaml > webapp-deployment.yaml

root@controlplane:~# cat webapp-deployment.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: webapp
  name: webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webapp
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webapp
    spec:
      containers:
      - image: kodekloud/webapp-color
        name: webapp-color
        resources: {}
status: {}
root@controlplane:~# 


root@controlplane:~# kubectl apply -f webapp-deployment.yaml
deployment.apps/webapp created
root@controlplane:~# 




Create a new pod called custom-nginx using the nginx image and expose it on container port 8080.

kubectl run custom-nginx --image=nginx --port=8080

root@controlplane:~# kubectl expose pod custom-nginx --port=8 --name=custom-nginx-service --dry-run=client -o yaml > custom-nginx-service.yaml
root@controlplane:~#

root@controlplane:~# vim custom-nginx-service.yaml
root@controlplane:~# kubectl apply -f custom-nginx-service.yaml
service/custom-nginx-service created
root@controlplane:~# kubectl get svc
NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
custom-nginx-service   ClusterIP   10.96.71.30      <none>        8080/TCP   5s
kubernetes             ClusterIP   10.96.0.1        <none>        443/TCP    19m
redis-service          ClusterIP   10.106.124.133   <none>        6379/TCP   6m34s
root@controlplane:~# 


root@controlplane:~# kubectl run custom-nginx --image=nginx --port=8080 --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: custom-nginx
  name: custom-nginx
spec:
  containers:
  - image: nginx
    name: custom-nginx
    ports:
    - containerPort: 8080
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
root@controlplane:~# 

root@controlplane:~# kubectl run custom-nginx --image=nginx --port=8080                         
pod/custom-nginx created
root@controlplane:~# kubectl get pods
NAME                      READY   STATUS              RESTARTS   AGE
custom-nginx              0/1     ContainerCreating   0          6s
nginx-pod                 1/1     Running             0          26m
redis                     1/1     Running             0          23m
webapp-56847f875b-56dcw   1/1     Running             0          16m
webapp-56847f875b-khmk5   1/1     Running             0          16m
webapp-56847f875b-rpfcj   1/1     Running             0          16m
root@controlplane:~# 



root@controlplane:~# kubectl run nginx-pod --image=nginx:alpine
pod/nginx-pod created
root@controlplane:~# ls
sample.yaml
root@controlplane:~# kubectl run redis --image=redis:alpine -l tier=db
pod/redis created
root@controlplane:~# 

root@controlplane:~# kubectl get pods
NAME        READY   STATUS              RESTARTS   AGE
nginx-pod   1/1     Running             0          64s
redis       0/1     ContainerCreating   0          11s
root@controlplane:~# 

root@controlplane:~# kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml > redis-service.yaml 
root@controlplane:~#


root@controlplane:~# kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml                     
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    tier: db
  name: redis-service
spec:
  ports:
  - port: 6379
    protocol: TCP
    targetPort: 6379
  selector:
    tier: db
status:
  loadBalancer: {}
root@controlplane:~# 

root@controlplane:~# vim redis-service.yaml 
root@controlplane:~# kubectl apply -f redis-service.yaml
service/redis-service created
root@controlplane:~# 

root@controlplane:~# kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP    11m
redis-service   ClusterIP   10.103.54.86   <none>        6379/TCP   13s
root@controlplane:~# 


root@controlplane:~# kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3 --dry-run=client -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: webapp
  name: webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webapp
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webapp
    spec:
      containers:
      - image: kodekloud/webapp-color
        name: webapp-color
        resources: {}
status: {}
root@controlplane:~# 



root@controlplane:~# kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3 --dry-run=client -o yaml > webapp.yaml
root@controlplane:~# kubectl apply -f webapp.yaml 
deployment.apps/webapp created
root@controlplane:~# kubectl get deploy webapp -o wide
NAME     READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS     IMAGES                   SELECTOR
webapp   3/3     3            3           23s   webapp-color   kodekloud/webapp-color   app=webapp
root@controlplane:~# 



Create a new pod called custom-nginx using the nginx image and expose it on container port 8080.

root@controlplane:~# kubectl run custom-nginx --image=nginx --port=8080 --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: custom-nginx
  name: custom-nginx
spec:
  containers:
  - image: nginx
    name: custom-nginx
    ports:
    - containerPort: 8080
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
root@controlplane:~# 


root@controlplane:~# kubectl run custom-nginx --image=nginx --port=8080 --dry-run=client -o yaml > custom-nginx.yaml
root@controlplane:~# kubectl apply -f custom-nginx.yaml 
pod/custom-nginx created
root@controlplane:~# 


root@controlplane:~# kubectl create namespace dev-ns --dry-run=client -o yaml
apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: null
  name: dev-ns
spec: {}
status: {}
root@controlplane:~# 


root@controlplane:~# kubectl create namespace dev-ns --dry-run=client -o yaml > namespace.yaml
root@controlplane:~# kubectl apply -f namespace.yaml
namespace/dev-ns created
root@controlplane:~# 


root@controlplane:~# kubectl create deployment redis-deploy --image=redis --replicas=2 -n dev-ns --dry-run=client -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: redis-deploy
  name: redis-deploy
  namespace: dev-ns
spec:
  replicas: 2
  selector:
    matchLabels:
      app: redis-deploy
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: redis-deploy
    spec:
      containers:
      - image: redis
        name: redis
        resources: {}
status: {}
root@controlplane:~# 



root@controlplane:~# kubectl create deployment redis-deploy --image=redis --replicas=2 -n dev-ns --dry-run=client -o yaml > redis-deploy.yaml
root@controlplane:~# kubectl apply -f redis-deploy.yaml
deployment.apps/redis-deploy created
root@controlplane:~# 


root@controlplane:~# kubectl run httpd --image=httpd:alpine --dry-run=client -o yaml > httpd_pod.yamlroot@controlplane:~# kubectl apply -f httpd_pod.yaml
pod/httpd created
root@controlplane:~# kubectl expose pod httpd --name=httpd --port=80 --dry-run=client -o yaml > httpd_service.yaml
root@controlplane:~# vim httpd_service.yaml
root@controlplane:~# kubectl apply -f httpd_service.yaml
service/httpd created
root@controlplane:~# 


The shortcut is: kubectl run httpd --image=httpd:alpine --port=80 --expose


root@controlplane:~# kubectl get all -n default
NAME                          READY   STATUS    RESTARTS   AGE
pod/custom-nginx              1/1     Running   0          7m47s
pod/httpd                     1/1     Running   0          2m22s
pod/nginx-pod                 1/1     Running   0          14m
pod/redis                     1/1     Running   0          13m
pod/webapp-56847f875b-6zp5q   1/1     Running   0          9m35s
pod/webapp-56847f875b-8xwh7   1/1     Running   0          9m35s
pod/webapp-56847f875b-txvwg   1/1     Running   0          9m35s

NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/httpd           ClusterIP   10.109.119.111   <none>        80/TCP     60s
service/kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP    22m
service/redis-service   ClusterIP   10.103.54.86     <none>        6379/TCP   11m

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp   3/3     3            3           9m35s

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-56847f875b   3         3         3       9m35s
root@controlplane:~# 


root@controlplane:~# kubectl get all -n dev-ns 
NAME                                READY   STATUS    RESTARTS   AGE
pod/redis-deploy-68fb445555-kr5w8   1/1     Running   0          4m25s
pod/redis-deploy-68fb445555-zrxfn   1/1     Running   0          4m25s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-deploy   2/2     2            2           4m25s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-deploy-68fb445555   2         2         2       4m25s
root@controlplane:~# 




















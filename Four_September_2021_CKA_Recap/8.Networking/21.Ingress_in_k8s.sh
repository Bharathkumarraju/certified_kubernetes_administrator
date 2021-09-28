difference between service and ingress:
---------------------------------------------->
for example: if we want to access the application on www.my-online-store.com

and if you are using GKE in google cloud... we can create serviceType LoadBalancer

if we want to access different services  like videos, news, games
http://www.my-online-store.com/videos 
http://www.my-online-store.com/news
http://www.my-online-store.com/games

"Ingress" helps users to access the application using a single externally accessible URL that we can configure to route different services in the cluster based on the URL path.
At the same time implement the SSL security as well.

We can think of ingress as a layer-7 loadbalancer built-in to the k8s cluster that can be configured.


Even with ingress you still need to expose it to make it accessible outside the cluster, 
so we still have to either publish it as a node port or with a cloud native loadbalancer, that just onetime confgiration.

Going forward we are going to perform all our loadbalancing,auth,ssl and URL based configurations on the ingress controller.


"Without ingress":
---------------------------------------------------------------------------------------->
we used a reverse-proxy (or) loadbalancing solution like nginx, haproxy, traefik.
we deployed them on k8s cluster and configure them to route traffic to other services.
configuration invloves defining URL Routes, configuring SSL certs etc...

"With ingress":
---------------------------------------------------------------------------------------->
Ingress is implemented ny kubernetes in kind of the same way.
we first deploy a supported solution(nginx,haproxy,traefik) and then specify a set of rules to configure ingress.

The solution(nginx, haproxy, traefik) we deploy is called as an ingress-controller and set of rules we configure are called ingress resources.
ingress resources are created using definition files like pods,deployments etc...

kubernetes cluster does not come with an ingress-controller by default.

"Create Ingress Controller:"
------------------------------------------------------------>
There are number of solutions available for ingress those are
1. GCP http(s) loadbalancer
2. nginx 
3. Contour
4. haproxy
5. traefik
6. Istion


lets take nginx.  we can deploy nginx ingress controller as a deployment

MacBook-Pro:8.Networking bharathdasaraju$ kubectl create deployment nginx-ingress-controller --image=quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21.0 --replicas=1 --dry-run=client -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx-ingress-controller
  name: nginx-ingress-controller
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-ingress-controller
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-ingress-controller
    spec:
      containers:
      - image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21.0
        name: nginx-ingress-controller
        resources: {}
status: {}
MacBook-Pro:8.Networking bharathdasaraju$ 


1. Add configmap for ingress controller to change confgiration settings for nginx
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-confoguration

2. add envs

3. expose ports 

4. deploy a service to expose a nginx-ingress-controller


apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-ingress-controller
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx-ingress
  strategy: {}
  template:
    metadata:
      labels:
        app: nginx-ingress
    spec:
      containers:
        - image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21.0
          name: nginx-ingress-controller
      args:
        - /nginx-ingress-controller
        - --configmap=$(POD_NAMESPACE)/nginx-configuration
      env:
        - name: POD_NAME
          valueFrom:
            filedRef:
              fieldPath: metadata.name 
        - name: POD_NAMESPACE
          valueFrom:
            filedRef:
              fieldPath: metadata.namespace

     ports:
       - name: http 
         containerPort: 80
       - name: https
         containerPort: 443


            
MacBook-Pro:8.Networking bharathdasaraju$ kubectl create service nodeport  nginx-ingress --tcp=80:80 --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: nginx-ingress
  name: nginx-ingress
spec:
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 80
  - name: https
    port: 443
    protocol: TCP
    targetPort: 443
  selector:
    app: nginx-ingress
  type: NodePort
MacBook-Pro:8.Networking bharathdasaraju$ 

MacBook-Pro:8.Networking bharathdasaraju$ kubectl create service nodeport  nginx-ingress --tcp=80:80 --dry-run=client -o yaml > nginx-ingress-service.yaml
MacBook-Pro:8.Networking bharathdasaraju$ kubectl create sa nginx-ingress-serviceaccount --dry-run=client -o yaml > nginx-ingress-serviceaccount.yaml
MacBook-Pro:8.Networking bharathdasaraju$ 

For nginx-ingress-controller to work properly we need to give it to peroper roles and rolebindings by creating a "serviceaccount"



"Create Ingress Resources:"
----------------------------------------------------------------------------------------------------------------------------------->
We can specify set of rules to route traffic to differnt URLs based in URL paths.

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wear
spec:
  rules:
    backend:
      service:
        name: wear-service
        port: 80


two types of ingress rules:
---------------------------------> 
Type1(URL paths):
---------------------->
http://my-online-store.com/wear
http://my-online-store.com/watch

Type2(URL names - hostnames):
------------------------------------>
http://wear.my-online-store.com
http://watch.my-online-store.com

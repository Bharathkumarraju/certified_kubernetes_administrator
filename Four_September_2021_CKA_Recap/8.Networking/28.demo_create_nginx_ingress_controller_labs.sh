root@controlplane:~# kubectl get all --all-namespaces
NAMESPACE     NAME                                       READY   STATUS    RESTARTS   AGE
app-space     pod/default-backend-5cf9bfb9d-xkrb8        1/1     Running   0          2m25s
app-space     pod/webapp-video-84f8655bd8-htjjm          1/1     Running   0          2m25s
app-space     pod/webapp-wear-6ff9445955-d2pn6           1/1     Running   0          2m24s
kube-system   pod/coredns-74ff55c5b-vcptv                1/1     Running   0          4m19s
kube-system   pod/coredns-74ff55c5b-zspgq                1/1     Running   0          4m19s
kube-system   pod/etcd-controlplane                      1/1     Running   0          4m30s
kube-system   pod/kube-apiserver-controlplane            1/1     Running   0          4m30s
kube-system   pod/kube-controller-manager-controlplane   1/1     Running   0          4m30s
kube-system   pod/kube-flannel-ds-ss84c                  1/1     Running   0          4m20s
kube-system   pod/kube-proxy-89b88                       1/1     Running   0          4m20s
kube-system   pod/kube-scheduler-controlplane            1/1     Running   0          4m30s

NAMESPACE     NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE
app-space     service/default-http-backend   ClusterIP   10.106.141.152   <none>        80/TCP                   2m24s
app-space     service/video-service          ClusterIP   10.103.191.8     <none>        8080/TCP                 2m25s
app-space     service/wear-service           ClusterIP   10.107.70.55     <none>        8080/TCP                 2m25s
default       service/kubernetes             ClusterIP   10.96.0.1        <none>        443/TCP                  4m39s
kube-system   service/kube-dns               ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   4m37s

NAMESPACE     NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/kube-flannel-ds   1         1         1       1            1           <none>                   4m34s
kube-system   daemonset.apps/kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   4m37s

NAMESPACE     NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
app-space     deployment.apps/default-backend   1/1     1            1           2m25s
app-space     deployment.apps/webapp-video      1/1     1            1           2m25s
app-space     deployment.apps/webapp-wear       1/1     1            1           2m25s
kube-system   deployment.apps/coredns           2/2     2            2           4m37s

NAMESPACE     NAME                                        DESIRED   CURRENT   READY   AGE
app-space     replicaset.apps/default-backend-5cf9bfb9d   1         1         1       2m25s
app-space     replicaset.apps/webapp-video-84f8655bd8     1         1         1       2m25s
app-space     replicaset.apps/webapp-wear-6ff9445955      1         1         1       2m25s
kube-system   replicaset.apps/coredns-74ff55c5b           2         2         2       4m20s
root@controlplane:~# 


root@controlplane:~# kubectl create namespace ingress-space
namespace/ingress-space created
root@controlplane:~# 

root@controlplane:~# kubectl get namespaces
NAME              STATUS   AGE
app-space         Active   7m45s
default           Active   9m59s
ingress-space     Active   30s
kube-node-lease   Active   10m
kube-public       Active   10m
kube-system       Active   10m
root@controlplane:~# 



The NGINX Ingress Controller requires a ConfigMap object. Create a ConfigMap object in the ingress-space.
root@controlplane:~#kubectl create configmap nginx-configuration --namespace ingress-space
root@controlplane:~# kubectl get cm -n ingress-space 
NAME                  DATA   AGE
kube-root-ca.crt      1      3m5s
nginx-configuration   0      27s
root@controlplane:~# 


root@controlplane:~# kubectl create sa ingress-serviceaccount -n ingress-space 
serviceaccount/ingress-serviceaccount created
root@controlplane:~# 

root@controlplane:~# kubectl get sa -n ingress-space
NAME                     SECRETS   AGE
default                  1         4m47s
ingress-serviceaccount   1         21s
root@controlplane:~# 

Create Role and Rolebindings for the service account

root@controlplane:~# kubectl get roles -n ingress-space -o wide
NAME           CREATED AT
ingress-role   2021-09-28T06:01:47Z
root@controlplane:~# kubectl get rolebindings -n ingress-space -o wide
NAME                   ROLE                AGE   USERS   GROUPS   SERVICEACCOUNTS
ingress-role-binding   Role/ingress-role   83s                    /ingress-serviceaccount
root@controlplane:~# 

root@controlplane:~# kubectl describe role ingress-role -n ingress-space         
Name:         ingress-role
Labels:       app.kubernetes.io/name=ingress-nginx
              app.kubernetes.io/part-of=ingress-nginx
Annotations:  <none>
PolicyRule:
  Resources   Non-Resource URLs  Resource Names                     Verbs
  ---------   -----------------  --------------                     -----
  configmaps  []                 []                                 [get create]
  configmaps  []                 [ingress-controller-leader-nginx]  [get update]
  endpoints   []                 []                                 [get]
  namespaces  []                 []                                 [get]
  pods        []                 []                                 [get]
  secrets     []                 []                                 [get]
root@controlplane:~# 


root@controlplane:~# kubectl describe rolebindings ingress-role-binding  -n ingress-space 
Name:         ingress-role-binding
Labels:       app.kubernetes.io/name=ingress-nginx
              app.kubernetes.io/part-of=ingress-nginx
Annotations:  <none>
Role:
  Kind:  Role
  Name:  ingress-role
Subjects:
  Kind            Name                    Namespace
  ----            ----                    ---------
  ServiceAccount  ingress-serviceaccount  
root@controlplane:~# 



---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ingress-controller
  namespace: ingress-space
spec:
  replicas: 1
  selector:
    matchLabels:
      name: nginx-ingress
  template:
    metadata:
      labels:
        name: nginx-ingress
    spec:
      serviceAccountName: ingress-serviceaccount
      containers:
        - name: nginx-ingress-controller
          image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21.0
          args:
            - /nginx-ingress-controller
            - --configmap=$(POD_NAMESPACE)/nginx-configuration
            - --default-backend-service=app-space/default-http-backend
          env:
            - name: POD_NAME
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
          ports:
            - name: http
                containerPort: 80
            - name: https
              containerPort: 443



root@controlplane:~# kubectl get all -n ingress-space 
NAME                                     READY   STATUS    RESTARTS   AGE
pod/ingress-controller-5857685bf-d9kkm   1/1     Running   0          5m54s

NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/ingress-controller   1/1     1            1           5m54s

NAME                                           DESIRED   CURRENT   READY   AGE
replicaset.apps/ingress-controller-5857685bf   1         1         1       5m54s
root@controlplane:~# 




create a service to make Ingress available to external users.

Name: ingress
Type: NodePort
Port: 80
TargetPort: 80
NodePort: 30080
Namespace: ingress-space
Use the right selector


root@controlplane:~# kubectl expose deployment ingress-controller --type=NodePort --port=80 --name=ingress -n ingress-space  --dry-run=client  -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  name: ingress
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    name: nginx-ingress
  type: NodePort
status:
  loadBalancer: {}
root@controlplane:~# 



root@controlplane:~# kubectl apply -f ingress_controller_service.yaml -n ingress-space  
service/ingress created
root@controlplane:~# kubectl get all -n ingress-space 
NAME                                     READY   STATUS    RESTARTS   AGE
pod/ingress-controller-5857685bf-d9kkm   1/1     Running   0          18m

NAME              TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
service/ingress   NodePort   10.101.203.157   <none>        80:30080/TCP,443:30404/TCP   17s

NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/ingress-controller   1/1     1            1           18m

NAME                                           DESIRED   CURRENT   READY   AGE
replicaset.apps/ingress-controller-5857685bf   1         1         1       18m
root@controlplane:~# 



root@controlplane:~# kubectl get all -n app-space
NAME                                  READY   STATUS    RESTARTS   AGE
pod/default-backend-5cf9bfb9d-xkrb8   1/1     Running   0          37m
pod/webapp-video-84f8655bd8-htjjm     1/1     Running   0          37m
pod/webapp-wear-6ff9445955-d2pn6      1/1     Running   0          37m

NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/default-http-backend   ClusterIP   10.106.141.152   <none>        80/TCP     37m
service/video-service          ClusterIP   10.103.191.8     <none>        8080/TCP   37m
service/wear-service           ClusterIP   10.107.70.55     <none>        8080/TCP   37m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/default-backend   1/1     1            1           37m
deployment.apps/webapp-video      1/1     1            1           37m
deployment.apps/webapp-wear       1/1     1            1           37m

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/default-backend-5cf9bfb9d   1         1         1       37m
replicaset.apps/webapp-video-84f8655bd8     1         1         1       37m
replicaset.apps/webapp-wear-6ff9445955      1         1         1       37m
root@controlplane:~# 


Create the ingress resource to make the applications available at /wear and /watch on the Ingress service.
Create the ingress in the app-space

#----------------------------------------------------------------------------
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - path: /wear
        pathType: Prefix
        backend:
          service:
           name: wear-service
           port: 
            number: 8080
      - path: /watch
        pathType: Prefix
        backend:
          service:
           name: video-service
           port:
            number: 8080
    
#-------------------------------------------------------------------------------

root@controlplane:~# kubectl apply -f ingress-resource-rule.yaml -n app-space 
ingress.networking.k8s.io/ingress-wear-watch created
root@controlplane:~# 



root@controlplane:~# kubectl  get ingress -n app-space
NAME                 CLASS    HOSTS   ADDRESS   PORTS   AGE
ingress-wear-watch   <none>   *                 80      36s
root@controlplane:~# kubectl describe ingress ingress-wear-watch -n app-space 
Name:             ingress-wear-watch
Namespace:        app-space
Address:          
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
Rules:
  Host        Path  Backends
  ----        ----  --------
  *           
              /wear    wear-service:8080 (10.244.0.5:8080)
              /watch   video-service:8080 (10.244.0.4:8080)
Annotations:  nginx.ingress.kubernetes.io/rewrite-target: /
              nginx.ingress.kubernetes.io/ssl-redirect: false
Events:       <none>
root@controlplane:~# 
root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   7m32s   v1.20.0   10.7.27.3     <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# 



root@controlplane:~# kubectl get deploy --all-namespaces
NAMESPACE       NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
app-space       default-backend            1/1     1            1           76s
app-space       webapp-video               1/1     1            1           76s
app-space       webapp-wear                1/1     1            1           76s
ingress-space   nginx-ingress-controller   1/1     1            1           77s
kube-system     coredns                    2/2     2            2           8m19s
root@controlplane:~# 


root@controlplane:~# kubectl get deploy  -n ingress-space -o wide
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE    CONTAINERS                 IMAGES                                                                  SELECTOR
nginx-ingress-controller   1/1     1            1           107s   nginx-ingress-controller   quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.21.0   name=nginx-ingress
root@controlplane:~# 



root@controlplane:~# kubectl get pods --all-namespaces
NAMESPACE       NAME                                        READY   STATUS    RESTARTS   AGE
app-space       default-backend-5cf9bfb9d-jv2md             1/1     Running   0          2m53s
app-space       webapp-video-84f8655bd8-m5sgh               1/1     Running   0          2m53s
app-space       webapp-wear-6ff9445955-sn5zq                1/1     Running   0          2m52s
ingress-space   nginx-ingress-controller-697cfbd4d9-6lhdm   1/1     Running   0          2m53s
kube-system     coredns-74ff55c5b-5cw7x                     1/1     Running   0          9m43s
kube-system     coredns-74ff55c5b-894fr                     1/1     Running   0          9m43s
kube-system     etcd-controlplane                           1/1     Running   0          9m52s
kube-system     kube-apiserver-controlplane                 1/1     Running   0          9m52s
kube-system     kube-controller-manager-controlplane        1/1     Running   0          9m52s
kube-system     kube-flannel-ds-ghng8                       1/1     Running   0          9m43s
kube-system     kube-proxy-bpz6t                            1/1     Running   0          9m43s
kube-system     kube-scheduler-controlplane                 1/1     Running   0          9m52s
root@controlplane:~# 


root@controlplane:~# kubectl get deploy -n app-space
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
default-backend   1/1     1            1           3m41s
webapp-video      1/1     1            1           3m41s
webapp-wear       1/1     1            1           3m41s
root@controlplane:~# 



root@controlplane:~# kubectl  get ingress --all-namespaces
NAMESPACE   NAME                 CLASS    HOSTS   ADDRESS   PORTS   AGE
app-space   ingress-wear-watch   <none>   *                 80      4m13s
root@controlplane:~# 

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
              /watch   video-service:8080 (10.244.0.6:8080)
Annotations:  nginx.ingress.kubernetes.io/rewrite-target: /
              nginx.ingress.kubernetes.io/ssl-redirect: false
Events:       <none>
root@controlplane:~# 



root@controlplane:~# kubectl get svc -n app-space 
NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
default-http-backend   ClusterIP   10.103.118.81   <none>        80/TCP     7m40s
video-service          ClusterIP   10.102.90.47    <none>        8080/TCP   7m40s
wear-service           ClusterIP   10.97.148.142   <none>        8080/TCP   7m40s
root@controlplane:~# 


root@controlplane:~# kubectl get deploy -n app-space
NAME              READY   UP-TO-DATE   AVAILABLE   AGE
default-backend   1/1     1            1           12m
webapp-food       1/1     1            1           27s
webapp-video      1/1     1            1           12m
webapp-wear       1/1     1            1           12m
root@controlplane:~# 


root@controlplane:~# kubectl get svc -n app-space 
NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
default-http-backend   ClusterIP   10.103.118.81   <none>        80/TCP     13m
food-service           ClusterIP   10.98.163.89    <none>        8080/TCP   76s
video-service          ClusterIP   10.102.90.47    <none>        8080/TCP   13m
wear-service           ClusterIP   10.97.148.142   <none>        8080/TCP   13m
root@controlplane:~# 


root@controlplane:~# kubectl get ingress -n app-space
NAME                 CLASS    HOSTS   ADDRESS   PORTS   AGE
ingress-wear-watch   <none>   *                 80      13m
root@controlplane:~# 


root@controlplane:~# kubectl get ingress -n app-space -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
    annotations:
      nginx.ingress.kubernetes.io/rewrite-target: /
      nginx.ingress.kubernetes.io/ssl-redirect: "false"
    name: ingress-wear-watch
    namespace: app-space
    resourceVersion: "2024"
  spec:
    rules:
    - http:
        paths:
        - backend:
            service:
              name: wear-service
              port:
                number: 8080
          path: /wear
          pathType: Prefix
        - backend:
            service:
              name: video-service
              port:
                number: 8080
          path: /stream
          pathType: Prefix
root@controlplane:~#


root@controlplane:~# kubectl get namespaces
NAME              STATUS   AGE
app-space         Active   20m
critical-space    Active   37s
default           Active   27m
ingress-space     Active   20m
kube-node-lease   Active   27m
kube-public       Active   27m
kube-system       Active   27m
root@controlplane:~# kubectl get all -n critical-space 
NAME                            READY   STATUS    RESTARTS   AGE
pod/webapp-pay-f74b9fc6-vpr59   1/1     Running   0          53s

NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/pay-service   ClusterIP   10.111.149.156   <none>        8282/TCP   53s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-pay   1/1     1            1           53s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-pay-f74b9fc6   1         1         1       53s
root@controlplane:~# 




root@controlplane:~# vim pay-ingress.yaml
root@controlplane:~# 

root@controlplane:~# kubectl apply -f pay-ingress.yaml -n critical-space
ingress.networking.k8s.io/test-ingress created
root@controlplane:~# 

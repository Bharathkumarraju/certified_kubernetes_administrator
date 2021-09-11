bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get namespaces
NAME              STATUS   AGE
default           Active   6d18h
kube-node-lease   Active   6d18h
kube-public       Active   6d18h
kube-system       Active   6d18h
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


Default namespace  --> 1.web-pod 2.db-service 3.web-deployment
In the same namespace web-pod can use DB simply by its name like mysql.connect("db-service")

and web-pod in default namespace can access the "db-service" in another namespace(dev) as well. but we need to specify like below.
mysql.connect("db-service.dev.svc.cluster.local")

cluster.local is the default domain name for the kubernetes cluster


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods -n kube-system
NAME                               READY   STATUS    RESTARTS   AGE
coredns-74ff55c5b-plhmt            1/1     Running   1          6d18h
etcd-minikube                      1/1     Running   1          6d18h
kube-apiserver-minikube            1/1     Running   1          6d18h
kube-controller-manager-minikube   1/1     Running   1          6d18h
kube-proxy-w85sf                   1/1     Running   1          6d18h
kube-scheduler-minikube            1/1     Running   1          6d18h
storage-provisioner                1/1     Running   22         6d18h
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create namespace dev --dry-run=client -o yaml > create_namespace.yaml
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f  create_namespace.yaml 
namespace/dev created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get namespaces
NAME              STATUS   AGE
default           Active   6d18h
dev               Active   14s
kube-node-lease   Active   6d18h
kube-public       Active   6d18h
kube-system       Active   6d18h
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl config set-context $(kubectl config current-context) --namespace=dev
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/bharathdasaraju/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Sat, 04 Sep 2021 14:54:48 +08
        provider: minikube.sigs.k8s.io
        version: v1.20.0
      name: cluster_info
    server: https://127.0.0.1:32774
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Sat, 04 Sep 2021 14:54:48 +08
        provider: minikube.sigs.k8s.io
        version: v1.20.0
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /Users/bharathdasaraju/.minikube/profiles/minikube/client.crt
    client-key: /Users/bharathdasaraju/.minikube/profiles/minikube/client.key
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl config set-context $(kubectl config current-context) --namespace=dev
Context "minikube" modified.
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/bharathdasaraju/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Sat, 04 Sep 2021 14:54:48 +08
        provider: minikube.sigs.k8s.io
        version: v1.20.0
      name: cluster_info
    server: https://127.0.0.1:32774
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Sat, 04 Sep 2021 14:54:48 +08
        provider: minikube.sigs.k8s.io
        version: v1.20.0
      name: context_info
    namespace: dev
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /Users/bharathdasaraju/.minikube/profiles/minikube/client.crt
    client-key: /Users/bharathdasaraju/.minikube/profiles/minikube/client.key
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods -n default
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-766794d85c-22z9x   1/1     Running   0          80m
nginx-deployment-766794d85c-gkzkn   1/1     Running   0          80m
nginx-deployment-766794d85c-q7pn7   1/1     Running   0          80m
redis-deploy-68fb445555-2rhp9       1/1     Running   0          67m
redis-deploy-68fb445555-h6rx5       1/1     Running   0          67m
redis-deploy-68fb445555-qz4st       1/1     Running   0          67m
redis-deploy-68fb445555-tvzfk       1/1     Running   0          67m
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl delete deploy redis-deploy -n default
deployment.apps "redis-deploy" deleted
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get rs -n default
NAME                          DESIRED   CURRENT   READY   AGE
nginx-deployment-766794d85c   3         3         3       81m
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl delete deploy nginx-deployment -n default
deployment.apps "nginx-deployment" deleted
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get all -n default
NAME                                    READY   STATUS        RESTARTS   AGE
pod/nginx-deployment-766794d85c-22z9x   0/1     Terminating   0          82m
pod/nginx-deployment-766794d85c-gkzkn   0/1     Terminating   0          82m
pod/nginx-deployment-766794d85c-q7pn7   0/1     Terminating   0          82m

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6d18h
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get all -n default
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6d18h
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 
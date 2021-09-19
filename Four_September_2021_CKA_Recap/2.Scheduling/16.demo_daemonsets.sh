daemonset runs one copy of pod on each node in the cluster

Whenever a new node joins a cluster a replica of pod automatically added to that node.


Examples like 
1.deploying a monitoring agent and 
2.log collector in each node


Kube-proxy an worker node component deployed as a daemonset :) 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get ds --all-namespaces -o wide
NAMESPACE     NAME         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS   IMAGES                          SELECTOR
kube-system   kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   13d   kube-proxy   k8s.gcr.io/kube-proxy:v1.20.2   k8s-app=kube-proxy
bharathdasaraju@MacBook-Pro 2.Scheduling % 


bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get all --all-namespaces -o wide | grep -i "daemonset"
kube-system   daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   13d   kube-proxy   k8s.gcr.io/kube-proxy:v1.20.2   k8s-app=kube-proxy
bharathdasaraju@MacBook-Pro 2.Scheduling % 


how to write daemonset specification file
first create a deployment --dry-run=client  and get the replicaset yaml file and edit kind to daemonset like below

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl create deployment webapp --image=nginx --dry-run=client -o yaml > web_app_deployment.yaml
bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl apply -f web_app_deployment.yaml 
deployment.apps/webapp created
bharathdasaraju@MacBook-Pro 2.Scheduling % 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get all
NAME                         READY   STATUS    RESTARTS   AGE
pod/webapp-5654c984c-qlz76   1/1     Running   0          63s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   14d

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp   1/1     1            1           63s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-5654c984c   1         1         1       63s
bharathdasaraju@MacBook-Pro 2.Scheduling % 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get rs webapp-5654c984c -o yaml > web_app_replicaset.yaml
bharathdasaraju@MacBook-Pro 2.Scheduling % cp web_app_replicaset.yaml web_app_daemonset.yaml
bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl delete deploy webapp
deployment.apps "webapp" deleted
bharathdasaraju@MacBook-Pro 2.Scheduling % 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl apply -f web_app_daemonset.yaml
daemonset.apps/webapp-daemon created
bharathdasaraju@MacBook-Pro 2.Scheduling % 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get ds webapp-daemon -o wide
NAME            DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE    CONTAINERS   IMAGES   SELECTOR
webapp-daemon   1         1         1       1            1           <none>          3m3s   nginx        nginx    app=webapp-agent
bharathdasaraju@MacBook-Pro 2.Scheduling % 






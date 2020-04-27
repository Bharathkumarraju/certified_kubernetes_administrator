master $ kubectl get nodes
NAME     STATUS   ROLES    AGE     VERSION
master   Ready    master   7m31s   v1.16.0
node01   Ready    <none>   7m14s   v1.16.0
master $


master $ kubectl get pods -n default
No resources found in default namespace.

echo "Create pod with --generator flag as below"

master $ kubectl run nginx --image=nginx --generator=run-pod/v1
pod/nginx created
master $

master $ kubectl get pod -w  -n default
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          31s
....

master $ kubectl get pods -n default
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          46s
master $



kubectl run redis --image=redis123 --generator=run-pod/v1

bharathdasaraju@MacBook-Pro external $ kubectl run nginx --image=nginx --generator=run-pod/v1
pod/nginx created
bharathdasaraju@MacBook-Pro external $
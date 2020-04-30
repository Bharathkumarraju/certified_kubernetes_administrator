Lets say we have deployed our pod having a web application running on it.

So how do we as an external user access the web page.

So lets say my minikube k8s node has IP as 192.168.64.2

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get nodes -o wide
NAME       STATUS   ROLES    AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE               KERNEL-VERSION   CONTAINER-RUNTIME
minikube   Ready    master   32d   v1.18.0   192.168.64.2   <none>        Buildroot 2019.02.10   4.19.107         docker://19.3.8
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

Internal pod ip range is 172.17.0.0

Internal POD has an IP of 172.17.0.3

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
bkdeployment-7b979d6b55-wxgqk   1/1     Running   0          11s   172.17.0.3   minikube   <none>           <none>
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

Lets say we ran nginx pod as below
kubectl create deployment bkdeployment --image=nginx

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
bkdeployment-7b979d6b55-wxgqk   1/1     Running   0          9m53s
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

Login to inside a pod, you would be able to curl with local pod IP as below.

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl exec -it bkdeployment-7b979d6b55-wxgqk bash
root@bkdeployment-7b979d6b55-wxgqk:/# curl http://172.17.0.3
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
root@bkdeployment-7b979d6b55-wxgqk:/#



How to access this nginx webpage from outside of the cluster ... here services helps us to achieve this.



NodePort range between 30000 - 32767 

apiVersion: v1
kind: Service
metadata:
  name: bkapp-service

spec:
  type: NodePort
  ports:
   - targetPort: 80 # Pod listens on this port, if we do not specify this value it assumes same as port.
     port: 80  # Service Port this is the only mandatory files
     nodePort: 30008  # Node listens on this port...can access using node IP-Address
  selector:
    app: bkapp
    type: front-end


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f bkweb_pod.yaml 
pod/bkweb created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
bkweb   1/1     Running   0          9s
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f service_nodeport.yaml 
service/bkapp-service created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
bkapp-service   NodePort    10.102.41.98   <none>        80:30009/TCP   6s
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        6d19h
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $
 

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get svc
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
bkapp-service   NodePort    10.102.41.98   <none>        80:30009/TCP   9m58s
kubernetes      ClusterIP   10.96.0.1      <none>        443/TCP        6d19h
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get nodes -o wide
NAME       STATUS   ROLES                  AGE     VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION    CONTAINER-RUNTIME
minikube   Ready    control-plane,master   6d19h   v1.20.2   192.168.49.2   <none>        Ubuntu 20.04.2 LTS   5.4.39-linuxkit   docker://20.10.6
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

create tunnel using "minikube service"

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ minikube service bkapp-service --url
🏃  Starting tunnel for service bkapp-service.
|-----------|---------------|-------------|------------------------|
| NAMESPACE |     NAME      | TARGET PORT |          URL           |
|-----------|---------------|-------------|------------------------|
| default   | bkapp-service |             | http://127.0.0.1:54535 |
|-----------|---------------|-------------|------------------------|
http://127.0.0.1:54535
❗  Because you are using a Docker driver on darwin, the terminal needs to be open to run it.
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $



bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ curl http://127.0.0.1:54535
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
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
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ curl -I http://127.0.0.1:54535
HTTP/1.1 200 OK
Server: nginx/1.21.3
Date: Sat, 11 Sep 2021 02:48:20 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Tue, 07 Sep 2021 15:21:03 GMT
Connection: keep-alive
ETag: "6137835f-267"
Accept-Ranges: bytes

bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 


  
  


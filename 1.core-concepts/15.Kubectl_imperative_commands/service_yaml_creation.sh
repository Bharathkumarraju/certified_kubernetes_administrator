bharathdasaraju@MacBook-Pro (master) $ kubectl run nginx --image=nginx --generator=run-pod/v1
pod/nginx created
bharathdasaraju@MacBook-Pro (master) $

echo "Below imperative gives you default service type: ClusterIP"
bharathdasaraju@MacBook-Pro (master) $ kubectl expose pod nginx --port=80 --name nginx-service --dry-run -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx-service
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx
status:
  loadBalancer: {}
bharathdasaraju@MacBook-Pro (master) $

echo "Imperative command to create a service with NodePort"

bharathdasaraju@MacBook-Pro 15.Kubectl_imperative_commands (master) $ kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: nginx
spec:
  ports:
  - name: 80-80
    nodePort: 30080
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx
  type: NodePort
status:
  loadBalancer: {}
bharathdasaraju@MacBook-Pro 15.Kubectl_imperative_commands (master) $


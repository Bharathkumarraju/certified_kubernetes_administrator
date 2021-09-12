# ClusterIP service type

1. front-end pods
2. back-end pods
3. redis pods

front-end pods need to connect to back-end pods for internal communication
And back-end pods needs to communicate to redis pods for internal configuration



apiVersion: v1 
kind: Service
metadata:
  name: back-end 
spec:
  type: ClusterIP
  ports:
   - targetPort : 80
     port: 80
  selector:
    app: bkapp2
    type: back-end


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl run redis --image=redis --dry-run=client -o yaml > bkweb_pod2.yaml
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f bkweb_pod2.yaml
pod/redis created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create -f service_ClusterIP.yaml 
service/back-end created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get svc
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
back-end        ClusterIP   10.102.211.63   <none>        80/TCP         7s
bkapp-service   NodePort    10.102.41.98    <none>        80:30009/TCP   45h
kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP        8d
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $



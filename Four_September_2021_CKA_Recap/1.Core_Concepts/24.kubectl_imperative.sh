bharathdasaraju@MacBook-Pro Four_September_2021_CKA_Recap (master) $ kubectl run nginx --image=nginx --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
bharathdasaraju@MacBook-Pro Four_September_2021_CKA_Recap (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create deployment nginx --image=nginx --replicas=4 --dry-run=client -o yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nginx
  name: nginx
spec:
  replicas: 4
  selector:
    matchLabels:
      app: nginx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl run nginx --image=nginx 
pod/nginx created
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl expose pod nginx --port=80 --name web-service --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: web-service
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx
status:
  loadBalancer: {}
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl expose pod nginx --port=80 --name web-service 
service/web-service exposed
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get svc web-service -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2021-09-13T05:08:42Z"
  labels:
    run: nginx
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:labels:
          .: {}
          f:run: {}
      f:spec:
        f:ports:
          .: {}
          k:{"port":80,"protocol":"TCP"}:
            .: {}
            f:port: {}
            f:protocol: {}
            f:targetPort: {}
        f:selector:
          .: {}
          f:run: {}
        f:sessionAffinity: {}
        f:type: {}
    manager: kubectl-expose
    operation: Update
    time: "2021-09-13T05:08:42Z"
  name: web-service
  namespace: default
  resourceVersion: "50739"
  uid: d08bd0c8-1649-40a6-8edb-28dd9a2f191b
spec:
  clusterIP: 10.106.66.87
  clusterIPs:
  - 10.106.66.87
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



"The problem with below approach is this will not use the pods labels as selectors, instead it will assume slectors as app=nginx so we need to modify it"
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create service clusterip nginx --tcp=80:80 --dry-run=client -o yaml
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
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx
  type: ClusterIP
status:
  loadBalancer: {}
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 



bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl expose pod nginx --type=NodePort --port=80 --name=nginx-service-np --dry-run=client -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx-service-np
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
  selector:
    run: nginx
  type: NodePort
status:
  loadBalancer: {}
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 

"using expose command"
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl create service nodeport nginx --tcp=80:80 --node-port=30090 --dry-run=client -o yaml
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
    nodePort: 30090
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx
  type: NodePort
status:
  loadBalancer: {}
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 
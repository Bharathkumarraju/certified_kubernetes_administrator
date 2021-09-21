if we have application that uses to connect to databse we need to pass the password in secured way...

so k8s secrets helps us to provide secrets to pod specification file

1. Create a secret
2. Inject the secret to the pod specification file


kubectl create secret generic app-secret --from-literal=DB_password=password123456

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl create secret generic app-secret --from-literal=DB_password=password123456 --dry-run=client -o yaml > create_secret.yaml
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl apply -f create_secret.yaml
secret/app-secret created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl describe secret app-secret 
Name:         app-secret
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
DB_password:  14 bytes
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 



MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl create secret generic db-secret --from-file=app_secrets.properties 
secret/db-secret created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 



MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ echo "cGFzc3dvcmQxMjM0NTY=" | base64 --decode
password123456MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$
password123456MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ echo -n "mysqluser" | base64
bXlzcWx1c2Vy
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ echo -n "mysqldb" | base64
bXlzcWxkYg==
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 

Secrets specification file:
------------------------------------------->
apiVersion: v1
data:
  DB_password: cGFzc3dvcmQxMjM0NTY=
  DB_user: bXlzcWx1c2Vy
  DB_Name: bXlzcWxkYg==
kind: Secret
metadata:
  name: app-secret




apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
    - containerPort: 80
    envFrom:
      - secretRef:
          name: db-secret
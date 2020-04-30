bharathdasaraju@MacBook-Pro external $ kubectl create deployment bharathsnginx --image=nginx --dry-run -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: bharathsnginx
  name: bharathsnginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: bharathsnginx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: bharathsnginx
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}
bharathdasaraju@MacBook-Pro external $ kubectl create deployment bharathsnginx --image=nginx
deployment.apps/bharathsnginx created
bharathdasaraju@MacBook-Pro external $

Update the replicas as 5 in above file and update the deployment with the kubectl apply -f as below.

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ vim test_deploy_from_dryrun_yaml.yaml
bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl apply -f test_deploy_from_dryrun_yaml.yaml
Warning: kubectl apply should be used on resource created by either kubectl create --save-config or kubectl apply
deployment.apps/bharathsnginx configured
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get all
NAME                                 READY   STATUS    RESTARTS   AGE
pod/bharathsnginx-5495746d74-4fkt5   1/1     Running   0          58s
pod/bharathsnginx-5495746d74-77kxv   1/1     Running   0          3m39s
pod/bharathsnginx-5495746d74-dr5np   1/1     Running   0          58s
pod/bharathsnginx-5495746d74-gzg7g   1/1     Running   0          58s
pod/bharathsnginx-5495746d74-q5jb5   1/1     Running   0          58s


NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   32d


NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/bharathsnginx   5/5     5            5           3m39s

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/bharathsnginx-5495746d74   5         5         5       3m39s

bharathdasaraju@MacBook-Pro 12.Deployments (master) $

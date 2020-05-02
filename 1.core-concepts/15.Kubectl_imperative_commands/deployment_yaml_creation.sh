bharathdasaraju@MacBook-Pro (master) $ kubectl run bhrath-nginx --image=nginx --generator=deployment/v1beta1 --dry-run -o yaml
kubectl run --generator=deployment/v1beta1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
error: no matches for kind "Deployment" in version "extensions/v1beta1"
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl run --generator=deployment/v1beta1 nginx --image=nginx --dry-run --replicas=4 -o yaml
kubectl run --generator=deployment/v1beta1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
error: no matches for kind "Deployment" in version "extensions/v1beta1"
bharathdasaraju@MacBook-Pro (master) $


bharathdasaraju@MacBook-Pro (master)$ kubectl create deployment bharathsweb --image=nginx --dry-run -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: bharathsweb
  name: bharathsweb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: bharathsweb
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: bharathsweb
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
status: {}
bharathdasaraju@MacBook-Pro (master) $




master $ kubectl run nginx-pod  --image=nginx:alpine --generator=run-pod/v1
pod/nginx-pod created
master $

master $ kubectl run redis --image=redis:alpine --generator=run-pod/v1 --dry-run -o yaml > redis-pod.yaml
master $ vim redis-pod.yaml
master $ kubectl  apply -f redis-pod.yaml
pod/redis created
master $

master $ cat redis-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: redis
    tier: db
  name: redis
spec:
  containers:
  - image: redis:alpine
    name: redis
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
master $
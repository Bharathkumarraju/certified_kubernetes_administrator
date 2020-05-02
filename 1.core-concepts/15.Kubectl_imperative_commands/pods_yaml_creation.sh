bharathdasaraju@MacBook-Pro 15.Kubectl_imperative_commands (master) $ kubectl run bharath-nginx --image=nginx --generator=run-pod/v1 --dry-run -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bharath-nginx
  name: bharath-nginx
spec:
  containers:
  - image: nginx
    name: bharath-nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
bharathdasaraju@MacBook-Pro 15.Kubectl_imperative_commands (master) $


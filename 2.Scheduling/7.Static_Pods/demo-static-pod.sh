Q: Create a static pod named static-busybox that uses the busybox image and the command sleep 1000?

master $ kubectl run --restart=Never --image=busybox static-busybox --dry-run -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-busybox.yaml
master $

bharathdasaraju@MacBook-Pro ~ $ kubectl run --restart=Never --image=busybox static-busy-box --dry-run -o yaml --command -- sleep 1000
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: static-busy-box
  name: static-busy-box
spec:
  containers:
  - command:
    - sleep
    - "1000"
    image: busybox
    name: static-busy-box
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Never
status: {}
bharathdasaraju@MacBook-Pro ~ $
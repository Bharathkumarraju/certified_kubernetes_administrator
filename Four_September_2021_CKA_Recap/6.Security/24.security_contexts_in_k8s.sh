in kubernetes containers are encapsulated in pods.

We can choose to configure security settings at a container level and a pod level.




MacBook-Pro:6.Security bharathdasaraju$ kubectl run webpod --image=ubuntu --command -- "sleep 100" --dry-run=client -o yaml
pod/webpod created
MacBook-Pro:6.Security bharathdasaraju$ kubectl run webpod --image=ubuntu --dry-run=client -o yaml --command -- "sleep 100"
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: webpod
  name: webpod
spec:
  containers:
  - command:
    - sleep 100
    image: ubuntu
    name: webpod
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
MacBook-Pro:6.Security bharathdasaraju$ 

securityContext configured at pod level:
------------------------------------------------------------------>

apiVersion: v1
kind: Pod
metadata:
  labels:
    run: webpod
  name: webpod
spec:
  securityContext:
    runAsUser: 1000
  containers:
  - command: ["sleep", "100"]
    image: ubuntu
    name: webpod


securityContext configured at container level:
------------------------------------------------------------------>

apiVersion: v1
kind: Pod
metadata:
  labels:
    run: webpod
  name: webpod
spec:
  containers:
  - command: ["sleep", "100"]
    image: ubuntu
    name: webpod
    securityContext:
      runAsUser: 1000
      capabilities:
        add: ["MAC_ADMIN"]

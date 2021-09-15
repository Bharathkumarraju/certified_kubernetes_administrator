taints on nodes

use tolerations on pods to schedule a pod on that tainted node 


Lets say we have 3 nodes node1,node2,node3

taint a node:
------------------>
kubectl taint nodes node1 key=value:taint-effect

kubectl taint nodes node1 app=blue:Noschedule -- No pods gets scheduled here unless they tolerates the taint
kubectl taint nodes node1 app=blue:PreferNoSchedule  -- it doesnot guaranteed
kubectl taint nodes node1 app=blue:NoExecute -- New pods will not schedule on the node and existing pods on the node if any will get evicted.

in the node:
-------------------->
kubectl taint nodes node1 app=blue:Noschedule 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl run nginx --image=nginx --dry-run=client -o yaml > 8.demo_taint_tolerations.yaml
bharathdasaraju@MacBook-Pro 2.Scheduling % 

in the pod specification file:
---------------------------------->
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
  tolerations:
    - key: "app"
      operator: "Equal"
      value: "blue"
      effect: "NoSchedule"




bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl run nginx --image=nginx --generator=run-pod/v1 --dry-run -o yaml
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
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl apply -f test_pod_from_dryrun_yaml.yaml
pod/nginx created
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ vim test_pod_from_dryrun_yaml.yaml
bharathdasaraju@MacBook-Pro 12.Deployments (master) $
Now add the new label to the pod manifest file and run again

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl apply -f test_pod_from_dryrun_yaml.yaml
pod/nginx configured
bharathdasaraju@MacBook-Pro 12.Deployments (master) $



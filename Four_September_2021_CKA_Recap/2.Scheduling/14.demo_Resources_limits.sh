Resource Requests:

minimum memory,cpu resources utilized by container can be set by 

requests:
  memory: "1Gi"
  cpu: 1

1G --> 1 Giga Byte(1000 Mega bytes)
1Gi --> 1 Gibi byte(1024 Mega bytes)

We can also set maximum resources utilized by container with 

limits:
  memory: "2Gi"
  cpu: 2

if container uses more than specified limits for cpu and memory pod will get terminated


bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl apply -f pod_with_resource_limits.yaml
pod/nginx18 created
bharathdasaraju@MacBook-Pro 2.Scheduling % 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl apply -f pod_with_resource_limits.yaml 
pod/nginx created
bharathdasaraju@MacBook-Pro 2.Scheduling % 
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


We can also set at namespace level to set default requests and limits for both cpu and memory by creating the LimitRange in the namespace

apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container



apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-limit-range
spec:
  limits:
  - default:
      cpu: 1
    defaultRequest:
      cpu: 0.5
    type: Container




bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl api-resources | grep -i "limit"
limitranges                       limits                                      true         LimitRange
bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get limits --all-namespaces    
No resources found
bharathdasaraju@MacBook-Pro 2.Scheduling % 

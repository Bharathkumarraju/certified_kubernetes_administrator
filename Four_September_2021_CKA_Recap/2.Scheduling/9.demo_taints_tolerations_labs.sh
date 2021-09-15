By default k8s master has a taint to not to schedule any pods there

root@controlplane:~# kubectl describe node controlplane | grep -i "taint"
Taints:             node-role.kubernetes.io/master:NoSchedule
root@controlplane:~#

root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   15m   v1.20.0   10.63.25.9    <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
node01         Ready    <none>                 14m   v1.20.0   10.63.25.12   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# 

No tanits on worker node:
------------------------------------------------------->

root@controlplane:~# kubectl describe node node01 | grep -i taint
Taints:             <none>
root@controlplane:~#

root@controlplane:~# kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
controlplane   Ready    control-plane,master   17m   v1.20.0
node01         Ready    <none>                 16m   v1.20.0
root@controlplane:~# 

root@controlplane:~# kubectl taint node node01 spray=mortein:NoSchedule
node/node01 tainted
root@controlplane:~# kubectl describe node node01 | grep -i "taint"
Taints:             spray=mortein:NoSchedule
root@controlplane:~# 

root@controlplane:~# kubectl run mosquito --image=nginx
pod/mosquito created
root@controlplane:~# 


root@controlplane:~# kubectl get pod mosquito -o wide
NAME       READY   STATUS    RESTARTS   AGE   IP       NODE     NOMINATED NODE   READINESS GATES
mosquito   0/1     Pending   0          35s   <none>   <none>   <none>           <none>
root@controlplane:~# 


root@controlplane:~# kubectl run bee --image=nginx --dry-run=client -o yaml > bee_pod_tolerations.yaml
root@controlplane:~#

root@controlplane:~# vim bee_pod_tolerations.yaml
root@controlplane:~# kubectl apply -f bee_pod_tolerations.yaml
pod/bee created
root@controlplane:~# 

root@controlplane:~# kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
bee        1/1     Running   0          5m18s
mosquito   0/1     Pending   0          17m
root@controlplane:~# 


Untaint the node

root@controlplane:~# kubectl taint node controlplane node-role.kubernetes.io/master:NoSchedule-
node/controlplane untainted
root@controlplane:~# 

root@controlplane:~# kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
bee        1/1     Running   0          13m
mosquito   1/1     Running   0          25m
root@controlplane:~# 


How to see documentation when we have errors in pod definition or Replicaset definition or Deployment definition files


bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl explain pods --recursive | grep -iwA5 tolerations
      tolerations       <[]Object>
         effect <string>
         key    <string>
         operator       <string>
         tolerationSeconds      <integer>
         value  <string>
bharathdasaraju@MacBook-Pro 2.Scheduling % 


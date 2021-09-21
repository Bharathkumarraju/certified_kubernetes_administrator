root@controlplane:~# kubectl get nodes -o wide
NAME           STATUS   ROLES                  AGE     VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane,master   6m45s   v1.20.0   10.15.47.11   <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
node01         Ready    <none>                 6m4s    v1.20.0   10.15.47.3    <none>        Ubuntu 18.04.5 LTS   5.4.0-1052-gcp   docker://19.3.0
root@controlplane:~# 


root@controlplane:~# kubectl get all    
NAME                        READY   STATUS    RESTARTS   AGE
pod/blue-746c87566d-fppk7   1/1     Running   0          25s
pod/blue-746c87566d-gtss7   1/1     Running   0          25s
pod/blue-746c87566d-vg78s   1/1     Running   0          25s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   7m19s

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/blue   3/3     3            3           25s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/blue-746c87566d   3         3         3       25s
root@controlplane:~# 



root@controlplane:~# kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE     NOMINATED NODE   READINESS GATES
blue-746c87566d-fppk7   1/1     Running   0          68s   10.244.1.2   node01   <none>           <none>
blue-746c87566d-gtss7   1/1     Running   0          68s   10.244.1.4   node01   <none>           <none>
blue-746c87566d-vg78s   1/1     Running   0          68s   10.244.1.3   node01   <none>           <none>
root@controlplane:~# 


We need to take node01 out for maintenance. Empty the node of all applications and mark it unschedulable.

root@controlplane:~# kubectl drain node01 --ignore-daemonsets
node/node01 already cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/kube-flannel-ds-8s2k4, kube-system/kube-proxy-tx4tg
evicting pod default/blue-746c87566d-vg78s
evicting pod default/blue-746c87566d-gtss7
evicting pod default/blue-746c87566d-fppk7
pod/blue-746c87566d-vg78s evicted
pod/blue-746c87566d-gtss7 evicted
pod/blue-746c87566d-fppk7 evicted
node/node01 evicted
root@controlplane:~# 



root@controlplane:~# kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
blue-746c87566d-7ps97   1/1     Running   0          85s   10.244.0.4   controlplane   <none>           <none>
blue-746c87566d-9h99k   1/1     Running   0          84s   10.244.0.5   controlplane   <none>           <none>
blue-746c87566d-frk9j   1/1     Running   0          84s   10.244.0.6   controlplane   <none>           <none>
root@controlplane:~# 



The maintenance tasks have been completed. Configure the node node01 to be schedulable again.

root@controlplane:~# kubectl uncordon node01
node/node01 uncordoned
root@controlplane:~# 


root@controlplane:~# kubectl describe node controlplane | grep -i taint
Taints:             <none>
root@controlplane:~# 


We need to carry out a maintenance activity on node01 again. Try draining the node again using the same command as before: kubectl drain node01 --ignore-daemonsets


root@controlplane:~# kubectl drain node01 --ignore-daemonsets
node/node01 already cordoned
error: unable to drain node "node01", aborting command...

There are pending nodes to be drained:
 node01
error: cannot delete Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet (use --force to override): default/hr-app
root@controlplane:~# 


root@controlplane:~# kubectl get all
NAME                        READY   STATUS    RESTARTS   AGE
pod/blue-746c87566d-7ps97   1/1     Running   0          6m53s
pod/blue-746c87566d-9h99k   1/1     Running   0          6m52s
pod/blue-746c87566d-frk9j   1/1     Running   0          6m52s
pod/hr-app                  1/1     Running   0          2m37s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   16m

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/blue   3/3     3            3           9m13s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/blue-746c87566d   3         3         3       9m13s
root@controlplane:~# 


a single pod scheduled on node01 which is not part of a replicaset.
The drain command will not work in this case. To forcefully drain the node we now have to use the --force flag.



Mark node01 as unschedulable so that no new pods are scheduled on this node.
Make sure that hr-app is not affected

root@controlplane:~# kubectl cordon node01
node/node01 cordoned
root@controlplane:~#


root@controlplane:~# kubectl get pods -o wide
NAME                      READY   STATUS    RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
blue-746c87566d-7ps97     1/1     Running   0          10m     10.244.0.4   controlplane   <none>           <none>
blue-746c87566d-9h99k     1/1     Running   0          10m     10.244.0.5   controlplane   <none>           <none>
blue-746c87566d-frk9j     1/1     Running   0          10m     10.244.0.6   controlplane   <none>           <none>
hr-app-76d475c57d-j7fkq   1/1     Running   0          2m14s   10.244.1.6   node01         <none>           <none>
root@controlplane:~# 


root@controlplane:~# kubectl create deployment bkapp --image=nginx --replicas=5 
deployment.apps/bkapp created
root@controlplane:~# 



root@controlplane:~# kubectl get pods -o wide
NAME                      READY   STATUS              RESTARTS   AGE     IP           NODE           NOMINATED NODE   READINESS GATES
bkapp-765748f886-6gl57    0/1     ContainerCreating   0          34s     <none>       controlplane   <none>           <none>
bkapp-765748f886-cn8kb    0/1     ContainerCreating   0          33s     <none>       controlplane   <none>           <none>
bkapp-765748f886-cndct    0/1     ContainerCreating   0          33s     <none>       controlplane   <none>           <none>
bkapp-765748f886-dtc6h    0/1     ContainerCreating   0          33s     <none>       controlplane   <none>           <none>
bkapp-765748f886-sfr2d    0/1     ContainerCreating   0          33s     <none>       controlplane   <none>           <none>
blue-746c87566d-7ps97     1/1     Running             0          11m     10.244.0.4   controlplane   <none>           <none>
blue-746c87566d-9h99k     1/1     Running             0          11m     10.244.0.5   controlplane   <none>           <none>
blue-746c87566d-frk9j     1/1     Running             0          11m     10.244.0.6   controlplane   <none>           <none>
hr-app-76d475c57d-j7fkq   1/1     Running             0          3m29s   10.244.1.6   node01         <none>           <none>
root@controlplane:~# 


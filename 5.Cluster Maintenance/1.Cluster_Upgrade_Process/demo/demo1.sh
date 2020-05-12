master $ kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP          NODE     NOMINATED NODE   READINESS GATES
blue-68df9fb9d9-l74qp   1/1     Running   0          2m24s   10.36.0.2   node02   <none>           <none>
blue-68df9fb9d9-tr2k6   1/1     Running   0          2m24s   10.39.0.2   node03   <none>           <none>
blue-68df9fb9d9-wx52c   1/1     Running   0          2m24s   10.44.0.1   node01   <none>           <none>red-5dc59c9654-d2vps    1/1     Running   0          2m24s   10.39.0.1   node03   <none>           <none>
red-5dc59c9654-zjhh5    1/1     Running   0          2m24s   10.36.0.1   node02   <none>           <none>
master $

Question:
----------->
We need to take node01 out for maintenance. Empty the node of all applications and mark it unschedulable.
Node node01 Unschedulable
Pods evicted from node01

Answer: $kubectl drain node01 --ignore-daemonsets

master $ kubectl drain node01 --ignore-daemonsets
node/node01 cordoned
WARNING: ignoring DaemonSet-managed Pods: kube-system/kube-proxy-f4n28, kube-system/weave-net-bnhqb
evicting pod "blue-68df9fb9d9-wx52c"
pod/blue-68df9fb9d9-wx52c evicted
node/node01 evicted
master $

master $ kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE     IP          NODE     NOMINATED NODE   READINESS GATES
blue-68df9fb9d9-l74qp   1/1     Running   0          6m10s   10.36.0.2   node02   <none>           <none>
blue-68df9fb9d9-qxlgt   1/1     Running   0          57s     10.39.0.3   node03   <none>           <none>
blue-68df9fb9d9-tr2k6   1/1     Running   0          6m10s   10.39.0.2   node03   <none>           <none>
red-5dc59c9654-d2vps    1/1     Running   0          6m10s   10.39.0.1   node03   <none>           <none>
red-5dc59c9654-zjhh5    1/1     Running   0          6m10s   10.36.0.1   node02   <none>           <none>
master $

Question:
--------->
The maintenance tasks have been completed. Configure the node to be schedulable again.

$kubectl uncordon node01

master $ kubectl uncordon node01
node/node01 uncordoned
master $

Question:
---------->
It is now time to take down node02 for maintenance. Before you remove all workload from node02
$kubectl drain node02 --ignore-daemonsets

master $ kubectl drain node02 --ignore-daemonsets
node/node02 cordoned
error: unable to drain node "node02", aborting command...

There are pending nodes to be drained:
 node02
error: cannot delete Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet (use --force to override): default/hr-app
master $

master $ kubectl get all -o wide
NAME                        READY   STATUS    RESTARTS   AGE     IP          NODE     NOMINATED NODE   READINESS GATES
pod/blue-68df9fb9d9-l74qp   1/1     Running   0          13m     10.36.0.2   node02   <none>           <none>
pod/blue-68df9fb9d9-qxlgt   1/1     Running   0          8m21s   10.39.0.3   node03   <none>           <none>
pod/blue-68df9fb9d9-tr2k6   1/1     Running   0          13m     10.39.0.2   node03   <none>           <none>
pod/hr-app                  1/1     Running   0          3m32s   10.36.0.3   node02   <none>           <none>
pod/red-5dc59c9654-d2vps    1/1     Running   0          13m     10.39.0.1   node03   <none>           <none>
pod/red-5dc59c9654-zjhh5    1/1     Running   0          13m     10.36.0.1   node02   <none>           <none>

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE   SELECTOR
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   16m   <none>

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES         SELECTOR
deployment.apps/blue   3/3     3            3           13m   nginx        nginx:alpine   app=blue
deployment.apps/red    2/2     2            2           13m   nginx        nginx:alpine   app=red

NAME                              DESIRED   CURRENT   READY   AGE   CONTAINERS   IMAGES         SELECTOR
replicaset.apps/blue-68df9fb9d9   3         3         3       13m   nginx        nginx:alpine   app=blue,pod-template-hash=68df9fb9d9
replicaset.apps/red-5dc59c9654    2         2         2       13m   nginx        nginx:alpine   app=red,pod-template-hash=5dc59c9654
master $


Reason: there is standalone pod pod/hr-app which is not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet.

master $ kubectl drain node02 --ignore-daemonsets --force
node/node02 already cordoned
WARNING: deleting Pods not managed by ReplicationController, ReplicaSet, Job, DaemonSet or StatefulSet: default/hr-app; ignoring DaemonSet-managed Pods: kube-system/kube-proxy-z2flh, kube-system/weave-net-np8zf
evicting pod "red-5dc59c9654-zjhh5"
evicting pod "blue-68df9fb9d9-l74qp"
evicting pod "hr-app"
pod/blue-68df9fb9d9-l74qp evicted
pod/hr-app evicted
pod/red-5dc59c9654-zjhh5 evicted
node/node02 evicted
master $

Question:
---------->
Node03 has our critical applications. We do not want to schedule any more apps on node03.
Mark node03 as unschedulable but do not remove any apps currently running on it.


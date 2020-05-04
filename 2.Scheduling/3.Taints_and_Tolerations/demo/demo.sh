master $ kubectl get nodes -o wide
NAME     STATUS   ROLES    AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION      CONTAINER-RUNTIME
master   Ready    master   66s   v1.16.0   172.17.0.8    <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
node01   Ready    <none>   37s   v1.16.0   172.17.0.36   <none>        Ubuntu 16.04.6 LTS   4.4.0-166-generic   docker://18.9.7
master $

master $ kubectl describe node master | grep Taint
Taints:             node-role.kubernetes.io/master:NoSchedule
master $

master $ kubectl describe node node01 | grep -i taint
Taints:             <none>
master $

Q: Create a taint on node01 with key of 'spray', value of 'mortein' and effect of 'NoSchedule'

master $ kubectl taint node node01  spray=mortein:NoSchedule
node/node01 tainted
master $

master $ kubectl describe node node01 | grep -i taint
Taints:             spray=mortein:NoSchedule
master $

master $ kubectl run mosquito --image=nginx --generator=run-pod/v1
pod/mosquito created
master $ kubectl  get pods
NAME       READY   STATUS    RESTARTS   AGE
mosquito   0/1     Pending   0          10s

master $ kubectl describe pod mosquito
Name:         mosquito
Namespace:    default
Priority:     0
Node:         <none>
Labels:       run=mosquito
Annotations:  <none>
Status:       Pending
IP:
IPs:          <none>
Containers:
  mosquito:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-vptjg (ro)
Conditions:
  Type           Status
  PodScheduled   False
Volumes:
  default-token-vptjg:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-vptjg
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason            Age        From               Message
  ----     ------            ----       ----               -------
  Warning  FailedScheduling  <unknown>  default-scheduler  0/2 nodes are available: 2 node(s) had taints that the pod didn't tolerate.
  Warning  FailedScheduling  <unknown>  default-scheduler  0/2 nodes are available: 2 node(s) had taints that the pod didn't tolerate.
master $



root@controlplane:~# kubectl get deploy
No resources found in default namespace.
root@controlplane:~# kubectl get pods  
NAME     READY   STATUS             RESTARTS   AGE
rabbit   0/1     CrashLoopBackOff   2          56s
root@controlplane:~# 

root@controlplane:~# kubectl get pod rabbit -o yaml | grep -iwA4  " resources:"
    resources:
      limits:
        cpu: "2"
      requests:
        cpu: "1"
root@controlplane:~# 




root@controlplane:~# kubectl describe pod elephant | grep -iA5 state
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       OOMKilled
      Exit Code:    1
      Started:      Sat, 18 Sep 2021 01:18:37 +0000
      Finished:     Sat, 18 Sep 2021 01:18:37 +0000
    Ready:          False
root@controlplane:~# 



root@controlplane:~# kubectl edit pod elephant 
error: pods "elephant" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-ffi5t.yaml"
error: Edit cancelled, no valid changes were saved.
root@controlplane:~# kubectl delete pod elephant 
pod "elephant" deleted
root@controlplane:~# kubectl apply -f /tmp/kubectl-edit-ffi5t.yaml
pod/elephant created
root@controlplane:~# kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
elephant   1/1     Running   0          31s
root@controlplane:~# 

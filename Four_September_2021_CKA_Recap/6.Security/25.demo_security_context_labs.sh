root@controlplane:~# kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          22s
root@controlplane:~# kubectl get pods ubuntu-sleeper -o yaml
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
  namespace: default
spec:
  containers:
  - command:
    - sleep
    - "4800"
    image: ubuntu
    imagePullPolicy: Always
    name: ubuntu
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-pkzgr
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext:
    runAsUser: 1010
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: default-token-pkzgr
    secret:
      defaultMode: 420
      secretName: default-token-pkzgr
root@controlplane:~#



root@controlplane:~# kubectl delete pod ubuntu-sleeper 
pod "ubuntu-sleeper" deleted

kubectl appltroot@controlplane:~# 
root@controlplane:~# kubectl apply -f /tmp/kubectl-edit-vquy1.yaml
pod/ubuntu-sleeper created
root@controlplane:~# kubectl exec -it ubuntu-sleeper sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
$ id
uid=1010 gid=0(root) groups=0(root)
$ 



root@controlplane:~# cat multi-pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: multi-pod
spec:
  securityContext:
    runAsUser: 1001
  containers:
  -  image: ubuntu
     name: web
     command: ["sleep", "5000"]
     securityContext:
      runAsUser: 1002

  -  image: ubuntu
     name: sidecar
     command: ["sleep", "5000"]

root@controlplane:~# 



Update pod ubuntu-sleeper to run as Root user and with the SYS_TIME capability.
----------------------------------------------------------------------------------------->
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
  namespace: default
spec:
  containers:
  - command:
    - sleep
    - "4800"
    image: ubuntu
    imagePullPolicy: Always
    name: ubuntu
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-pkzgr
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext:
    capabilities:
      add: ["SYS_TIME"]
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: default-token-pkzgr
    secret:
      defaultMode: 420
      secretName: default-token-pkzgr




--------------------------pod.yaml------------------------->
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
  namespace: default
spec:
  containers:
  - command:
    - sleep
    - "4800"
    image: ubuntu
    name: ubuntu-sleeper
    securityContext:
      capabilities:
        add: ["SYS_TIME", "NET_ADMIN"]


--------------------------------------------------------------------->

root@controlplane:~# vim pod.yaml
root@controlplane:~# 
root@controlplane:~# kubectl apply -f pod.yaml
pod/ubuntu-sleeper created
root@controlplane:~# 


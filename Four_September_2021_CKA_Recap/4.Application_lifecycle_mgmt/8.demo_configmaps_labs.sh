root@controlplane:~# kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
webapp-color   1/1     Running   0          23s
root@controlplane:~# 


root@controlplane:~# kubectl describe pod webapp-color | grep -iC5 "environment"
    Host Port:      <none>
    State:          Running
      Started:      Tue, 21 Sep 2021 00:06:12 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      APP_COLOR:  pink
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-rrblh (ro)
Conditions:
  Type              Status
root@controlplane:~# 




root@controlplane:~# kubectl get pod webapp-color -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2021-09-21T00:05:54Z"
  labels:
    name: webapp-color
spec:
  containers:
  - env:
    - name: APP_COLOR
      value: pink
    image: kodekloud/webapp-color
    imagePullPolicy: Always
    name: webapp-color
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-rrblh
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
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
  - name: default-token-rrblh
    secret:
      defaultMode: 420
      secretName: default-token-rrblh
root@controlplane:~# 


root@controlplane:~# kubectl get cm
NAME               DATA   AGE
db-config          3      7s
kube-root-ca.crt   1      17m
root@controlplane:~# 

root@controlplane:~# kubectl describe cm db-config
Name:         db-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
DB_PORT:
----
3306
DB_HOST:
----
SQL01.example.com
DB_NAME:
----
SQL01
Events:  <none>
root@controlplane:~# 


root@controlplane:~# kubectl create cm webapp-config-map --from-literal=APP_COLOR=darkblue --dry-run=client -o yaml
apiVersion: v1
data:
  APP_COLOR: darkblue
kind: ConfigMap
metadata:
  creationTimestamp: null
  name: webapp-config-map
root@controlplane:~# 


MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl create cm webapp-config-map --from-literal=APP_COLOR=darkblue --dry-run=client -o yaml > webapp-config-map.yaml
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl apply -f webapp-config-map.yaml
configmap/webapp-config-map created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl apply -f use_configmaps_envFrom.yaml 
pod/webapp-color created
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 




root@controlplane:~# kubectl apply -f /tmp/kubectl-edit-roe4a.yaml
pod/webapp-color created
root@controlplane:~# 



root@controlplane:~# cat /tmp/kubectl-edit-roe4a.yaml
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
# pods "webapp-color" was not valid:
# * <nil>: Invalid value: "The edited file failed validation": [yaml: line 18: did not find expected '-' indicator, invalid character 'a' looking for beginning of value]
#
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"creationTimestamp":"2021-09-21T00:12:58Z","labels":{"name":"webapp-color"},"name":"webapp-color","namespace":"default","resourceVersion":"1669","uid":"f5a9535d-c25f-4ecd-91e0-1b46d9aa4fdd"},"spec":{"containers":[{"env":[{"name":"APP_COLOR","value":"green"}],"envFrom":[{"configMapRef":{"name":"webapp-config-map"}}],"image":"kodekloud/webapp-color","imagePullPolicy":"Always","name":"webapp-color","resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File","volumeMounts":[{"mountPath":"/var/run/secrets/kubernetes.io/serviceaccount","name":"default-token-rrblh","readOnly":true}]}],"dnsPolicy":"ClusterFirst","enableServiceLinks":true,"nodeName":"controlplane","preemptionPolicy":"PreemptLowerPriority","priority":0,"restartPolicy":"Always","schedulerName":"default-scheduler","securityContext":{},"serviceAccount":"default","serviceAccountName":"default","terminationGracePeriodSeconds":30,"tolerations":[{"effect":"NoExecute","key":"node.kubernetes.io/not-ready","operator":"Exists","tolerationSeconds":300},{"effect":"NoExecute","key":"node.kubernetes.io/unreachable","operator":"Exists","tolerationSeconds":300}],"volumes":[{"name":"default-token-rrblh","secret":{"defaultMode":420,"secretName":"default-token-rrblh"}}]},"status":{"conditions":[{"lastProbeTime":null,"lastTransitionTime":"2021-09-21T00:12:58Z","status":"True","type":"Initialized"},{"lastProbeTime":null,"lastTransitionTime":"2021-09-21T00:13:01Z","status":"True","type":"Ready"},{"lastProbeTime":null,"lastTransitionTime":"2021-09-21T00:13:01Z","status":"True","type":"ContainersReady"},{"lastProbeTime":null,"lastTransitionTime":"2021-09-21T00:12:58Z","status":"True","type":"PodScheduled"}],"containerStatuses":[{"containerID":"docker://4061cfcda617f577f11ff5ab34a8e941a9a898c5da636899d3ec1be18ef8d378","image":"kodekloud/webapp-color:latest","imageID":"docker-pullable://kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423","lastState":{},"name":"webapp-color","ready":true,"restartCount":0,"started":true,"state":{"running":{"startedAt":"2021-09-21T00:13:01Z"}}}],"hostIP":"10.58.226.9","phase":"Running","podIP":"10.244.0.5","podIPs":[{"ip":"10.244.0.5"}],"qosClass":"BestEffort","startTime":"2021-09-21T00:12:58Z"}}
  creationTimestamp: "2021-09-21T00:22:48Z"
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
  resourceVersion: "2395"
  uid: 7af0cf70-d31f-4e82-bf90-b1edf045d6a8
spec:
  containers:
  - envFrom:
     - configMapRef:
         name: webapp-config-map
    image: kodekloud/webapp-color
    imagePullPolicy: Always
    name: webapp-color
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-rrblh
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
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
  - name: default-token-rrblh
    secret:
      defaultMode: 420
      secretName: default-token-rrblh
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2021-09-21T00:22:48Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2021-09-21T00:22:52Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2021-09-21T00:22:52Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2021-09-21T00:22:48Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://93a644dc8e6283b359c1404c42d56fecc679fb54e4b3a65d2ebd8ab149c83567
    image: kodekloud/webapp-color:latest
    imageID: docker-pullable://kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423
    lastState: {}
    name: webapp-color
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2021-09-21T00:22:51Z"
  hostIP: 10.58.226.9
  phase: Running
  podIP: 10.244.0.6
  podIPs:
  - ip: 10.244.0.6
  qosClass: BestEffort
  startTime: "2021-09-21T00:22:48Z"
root@controlplane:~# 


MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ kubectl explain pods --recursive | grep -iA5 "envFrom"
         envFrom        <[]Object>      
            configMapRef        <Object>
               name     <string>
               optional <boolean>
            prefix      <string>
            secretRef   <Object>
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$

 envFrom        <[]Object>  --> it is a list []
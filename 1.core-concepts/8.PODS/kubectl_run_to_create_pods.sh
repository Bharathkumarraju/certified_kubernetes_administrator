if you do kubectl run it automatically create deployment as below

bharathdasaraju@MacBook-Pro external $ kubectl run nginx --image nginx
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/nginx created
bharathdasaraju@MacBook-Pro external $

bharathdasaraju@MacBook-Pro external $ kubectl get deploy  nginx -o wide
NAME    READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES   SELECTOR
nginx   1/1     1            1           76s   nginx        nginx    run=nginx
bharathdasaraju@MacBook-Pro external $

bharathdasaraju@MacBook-Pro external $ kubectl get pods | grep nginx
nginx-76df748b9-jwlkr   1/1     Running   0          2m33s


bharathdasaraju@MacBook-Pro external $ kubectl get pod nginx-76df748b9-jwlkr -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2020-04-26T08:32:07Z"
  generateName: nginx-76df748b9-
  labels:
    pod-template-hash: 76df748b9
    run: nginx
  managedFields:
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:generateName: {}
        f:labels:
          .: {}
          f:pod-template-hash: {}
          f:run: {}
        f:ownerReferences:
          .: {}
          k:{"uid":"e845c1a5-f5ea-47c2-bd4d-eb3da4a8311d"}:
            .: {}
            f:apiVersion: {}
            f:blockOwnerDeletion: {}
            f:controller: {}
            f:kind: {}
            f:name: {}
            f:uid: {}
      f:spec:
        f:containers:
          k:{"name":"nginx"}:
            .: {}
            f:image: {}
            f:imagePullPolicy: {}
            f:name: {}
            f:resources: {}
            f:terminationMessagePath: {}
            f:terminationMessagePolicy: {}
        f:dnsPolicy: {}
        f:enableServiceLinks: {}
        f:restartPolicy: {}
        f:schedulerName: {}
        f:securityContext: {}
        f:terminationGracePeriodSeconds: {}
    manager: kube-controller-manager
    operation: Update
    time: "2020-04-26T08:32:07Z"
  - apiVersion: v1
    fieldsType: FieldsV1
    fieldsV1:
      f:status:
        f:conditions:
          k:{"type":"ContainersReady"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
          k:{"type":"Initialized"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
          k:{"type":"Ready"}:
            .: {}
            f:lastProbeTime: {}
            f:lastTransitionTime: {}
            f:status: {}
            f:type: {}
        f:containerStatuses: {}
        f:hostIP: {}
        f:phase: {}
        f:podIP: {}
        f:podIPs:
          .: {}
          k:{"ip":"172.17.0.2"}:
            .: {}
            f:ip: {}
        f:startTime: {}
    manager: kubelet
    operation: Update
    time: "2020-04-26T08:32:56Z"
  name: nginx-76df748b9-jwlkr
  namespace: default
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: nginx-76df748b9
    uid: e845c1a5-f5ea-47c2-bd4d-eb3da4a8311d
  resourceVersion: "1223568"
  selfLink: /api/v1/namespaces/default/pods/nginx-76df748b9-jwlkr
  uid: dbb07825-5e36-4068-a864-625e10bace4c
spec:
  containers:
  - image: nginx
    imagePullPolicy: Always
    name: nginx
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-cljgp
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: minikube
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
  - name: default-token-cljgp
    secret:
      defaultMode: 420
      secretName: default-token-cljgp
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2020-04-26T08:32:07Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2020-04-26T08:32:56Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2020-04-26T08:32:56Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2020-04-26T08:32:07Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://1d397a8dadec1e48658a58fca1df9bec8c2037f01abb7f53b5809b50d86a82e6
    image: nginx:latest
    imageID: docker-pullable://nginx@sha256:86ae264c3f4acb99b2dee4d0098c40cb8c46dcf9e1148f05d3a51c4df6758c12
    lastState: {}
    name: nginx
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2020-04-26T08:32:56Z"
  hostIP: 192.168.64.2
  phase: Running
  podIP: 172.17.0.2
  podIPs:
  - ip: 172.17.0.2
  qosClass: BestEffort
  startTime: "2020-04-26T08:32:07Z"
bharathdasaraju@MacBook-Pro external $

echo "Describe the pod"

bharathdasaraju@MacBook-Pro external $ kubectl describe pod nginx-76df748b9-jwlkr
Name:           nginx-76df748b9-jwlkr
Namespace:      default
Priority:       0
Node:           minikube/192.168.64.2
Start Time:     Sun, 26 Apr 2020 16:32:07 +0800
Labels:         pod-template-hash=76df748b9
                run=nginx
Annotations:    <none>
Status:         Running
IP:             172.17.0.2
Controlled By:  ReplicaSet/nginx-76df748b9
Containers:
  nginx:
    Container ID:   docker://1d397a8dadec1e48658a58fca1df9bec8c2037f01abb7f53b5809b50d86a82e6
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:86ae264c3f4acb99b2dee4d0098c40cb8c46dcf9e1148f05d3a51c4df6758c12
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 26 Apr 2020 16:32:56 +0800
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-cljgp (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-cljgp:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-cljgp
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age        From               Message
  ----    ------     ----       ----               -------
  Normal  Scheduled  <unknown>  default-scheduler  Successfully assigned default/nginx-76df748b9-jwlkr to minikube
  Normal  Pulling    4m13s      kubelet, minikube  Pulling image "nginx"
  Normal  Pulled     3m26s      kubelet, minikube  Successfully pulled image "nginx"
  Normal  Created    3m25s      kubelet, minikube  Created container nginx
  Normal  Started    3m25s      kubelet, minikube  Started container nginx
bharathdasaraju@MacBook-Pro external $


echo "Get the yaml of deployment of nginx"


bharathdasaraju@MacBook-Pro external $ kubectl get deploy nginx -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2020-04-26T08:32:07Z"
  generation: 1
  labels:
    run: nginx
  managedFields:
  - apiVersion: apps/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:labels:
          .: {}
          f:run: {}
      f:spec:
        f:progressDeadlineSeconds: {}
        f:replicas: {}
        f:revisionHistoryLimit: {}
        f:selector:
          f:matchLabels:
            .: {}
            f:run: {}
        f:strategy:
          f:rollingUpdate:
            .: {}
            f:maxSurge: {}
            f:maxUnavailable: {}
          f:type: {}
        f:template:
          f:metadata:
            f:labels:
              .: {}
              f:run: {}
          f:spec:
            f:containers:
              k:{"name":"nginx"}:
                .: {}
                f:image: {}
                f:imagePullPolicy: {}
                f:name: {}
                f:resources: {}
                f:terminationMessagePath: {}
                f:terminationMessagePolicy: {}
            f:dnsPolicy: {}
            f:restartPolicy: {}
            f:schedulerName: {}
            f:securityContext: {}
            f:terminationGracePeriodSeconds: {}
    manager: kubectl
    operation: Update
    time: "2020-04-26T08:32:07Z"
  - apiVersion: apps/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .: {}
          f:deployment.kubernetes.io/revision: {}
      f:status:
        f:availableReplicas: {}
        f:conditions:
          .: {}
          k:{"type":"Available"}:
            .: {}
            f:lastTransitionTime: {}
            f:lastUpdateTime: {}
            f:message: {}
            f:reason: {}
            f:status: {}
            f:type: {}
          k:{"type":"Progressing"}:
            .: {}
            f:lastTransitionTime: {}
            f:lastUpdateTime: {}
            f:message: {}
            f:reason: {}
            f:status: {}
            f:type: {}
        f:observedGeneration: {}
        f:readyReplicas: {}
        f:replicas: {}
        f:updatedReplicas: {}
    manager: kube-controller-manager
    operation: Update
    time: "2020-04-26T08:32:56Z"
  name: nginx
  namespace: default
  resourceVersion: "1223572"
  selfLink: /apis/apps/v1/namespaces/default/deployments/nginx
  uid: 223ebb85-5fc0-49e7-91d5-33e6c09a3f85
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      run: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: nginx
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2020-04-26T08:32:56Z"
    lastUpdateTime: "2020-04-26T08:32:56Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2020-04-26T08:32:07Z"
    lastUpdateTime: "2020-04-26T08:32:56Z"
    message: ReplicaSet "nginx-76df748b9" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
bharathdasaraju@MacBook-Pro external $

echo "Describe the deployment"

bharathdasaraju@MacBook-Pro external $ kubectl describe deploy nginx
Name:                   nginx
Namespace:              default
CreationTimestamp:      Sun, 26 Apr 2020 16:32:07 +0800
Labels:                 run=nginx
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               run=nginx
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  run=nginx
  Containers:
   nginx:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-76df748b9 (1/1 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  6m13s  deployment-controller  Scaled up replica set nginx-76df748b9 to 1
bharathdasaraju@MacBook-Pro external $

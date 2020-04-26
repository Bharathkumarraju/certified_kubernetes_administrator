apiVersion: v1
kind: Pod
metadata: #metadata is in the form of dictionary
  name: bharaths-pod
  labels: #labels is another dictionary inside metadata dictionary
    app: bharathapp
    type: front-end
spec: #spec is the form of dictionary as welll
  containers: #containers are Lists/Array so that we can add multiple containers
    - name: nginx-container # '-' indicates that 1st item in the list, and item in the list is a dictionary so key value can be used like name,image
      image: nginx

to apply this

$kubectl create -f pod-definition.yml


bharathdasaraju@MacBook-Pro 9.PODS_with_YAML (master) $ kubectl create -f pod-definition.yml
pod/bharaths-pod created
bharathdasaraju@MacBook-Pro 9.PODS_with_YAML (master) $

bharathdasaraju@MacBook-Pro 9.PODS_with_YAML (master) $ kubectl get pods -o wide
NAME           READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
bharaths-pod   1/1     Running   0          75s   172.17.0.2   minikube   <none>           <none>


bharathdasaraju@MacBook-Pro 9.PODS_with_YAML (master) $ kubectl describe pod bharaths-pod
Name:         bharaths-pod
Namespace:    default
Priority:     0
Node:         minikube/192.168.64.2
Start Time:   Sun, 26 Apr 2020 17:16:05 +0800
Labels:       app=bharathapp
              type=front-end
Annotations:  <none>
Status:       Running
IP:           172.17.0.2
Containers:
  nginx-container:
    Container ID:   docker://0c8d0b68d4f2978b4703c9fb99188ae664d91c114635638206f113677830c5d0
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:86ae264c3f4acb99b2dee4d0098c40cb8c46dcf9e1148f05d3a51c4df6758c12
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 26 Apr 2020 17:16:14 +0800
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
  Type     Reason       Age        From               Message
  ----     ------       ----       ----               -------
  Normal   Scheduled    <unknown>  default-scheduler  Successfully assigned default/bharaths-pod to minikube
  Warning  FailedMount  95s        kubelet, minikube  MountVolume.SetUp failed for volume "default-token-cljgp" : failed to sync secret cache: timed out waiting for the condition
  Normal   Pulling      94s        kubelet, minikube  Pulling image "nginx"
  Normal   Pulled       88s        kubelet, minikube  Successfully pulled image "nginx"
  Normal   Created      87s        kubelet, minikube  Created container nginx-container
  Normal   Started      87s        kubelet, minikube  Started container nginx-container
bharathdasaraju@MacBook-Pro 9.PODS_with_YAML (master) $
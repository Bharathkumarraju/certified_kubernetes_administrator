root@controlplane:~# kubectl describe pod kube-scheduler-controlplane -n kube-system | grep -i image    Image:         k8s.gcr.io/kube-scheduler:v1.20.0
    Image ID:      docker-pullable://k8s.gcr.io/kube-scheduler@sha256:beaa710325047fa9c867eff4ab9af38d9c2acec05ac5b416c708c304f76bdbef
  Normal  Pulled  9m29s  kubelet  Container image "k8s.gcr.io/kube-scheduler:v1.20.0" already present on machine
root@controlplane:~# 



Deploy an additional scheduler to the cluster following the given specification.
Use the manifest file used by kubeadm tool. Use a different port than the one used by the current one.

Namespace: kube-system
Name: my-scheduler
Status: Running
Custom Scheduler Name



root@controlplane:/etc/kubernetes/manifests# ls -rtlh
total 16K
-rw------- 1 root root 3.8K Sep 20 01:13 kube-apiserver.yaml
-rw------- 1 root root 1.4K Sep 20 01:13 kube-scheduler.yaml
-rw------- 1 root root 3.3K Sep 20 01:13 kube-controller-manager.yaml
-rw------- 1 root root 2.2K Sep 20 01:13 etcd.yaml
root@controlplane:/etc/kubernetes/manifests# cp kube-scheduler.yaml kube-scheduler-custom.yaml   
root@controlplane:/etc/kubernetes/manifests#



Copy kube-scheduler.yaml from the directory /etc/kubernetes/manifests/ to any other location and then change the name to my-scheduler.

Add or update the following command arguments in the YAML file:

- --leader-elect=false
- --port=10282
- --scheduler-name=my-scheduler
- --secure-port=0
Here, we are setting leader-elect to false for our new custom scheduler called my-scheduler.

We are also making use of a different port 10282 which is not currently in use in the controlplane.

The default scheduler uses secure-port on port 10259 to serve HTTPS with authentication and authorization. 
This is not needed for our custom scheduler, so we can disable HTTPS by setting the value of secure-port to 0.

Finally, because we have set secure-port to 0, replace HTTPS with HTTP and use the correct ports under liveness and startup probes.

default file as below
----------------------------> 
spec:
  containers:
  - command:
    - kube-scheduler
    - --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
    - --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
    - --bind-address=127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    - --leader-elect=true
    - --port=0


change as below:
---------------------------------->

spec:
  containers:
  - command:
    - kube-scheduler
    - --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
    - --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
    - --bind-address=127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    - --leader-elect=false
    - --port=10282
    - --scheduler-name=my-scheduler
    - --secure-port=0
    image: k8s.gcr.io/kube-scheduler:v1.20.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10282
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-scheduler


Custom-Scheduler static pod specification file:
-------------------------------------------------------->
apiVersion: v1
kind: Pod
metadata:
  labels:
    component: my-scheduler
    tier: control-plane
  name: my-scheduler
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-scheduler
    - --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
    - --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
    - --bind-address=127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    - --leader-elect=false
    - --port=10282
    - --scheduler-name=my-scheduler
    - --secure-port=0
    image: k8s.gcr.io/kube-scheduler:v1.19.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10282
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-scheduler
    resources:
      requests:
        cpu: 100m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10282
        scheme: HTTP
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/kubernetes/scheduler.conf
      name: kubeconfig
      readOnly: true
  hostNetwork: true
  priorityClassName: system-node-critical
  volumes:
  - hostPath:
      path: /etc/kubernetes/scheduler.conf
      type: FileOrCreate
    name: kubeconfig
status: {}




root@controlplane:/etc/kubernetes/manifests# kubectl get pods -n kube-system | grep -i scheduler
kube-scheduler-controlplane            1/1     Running   2          2m26s
my-scheduler-controlplane              1/1     Running   0          2m39s
root@controlplane:/etc/kubernetes/manifests# 



A POD definition file is given. Use it to create a POD with the new custom scheduler.
File is located at /root/nginx-pod.yaml


root@controlplane:~# cat nginx-pod.yaml 
apiVersion: v1 
kind: Pod 
metadata:
  name: nginx 
spec:
  schedulerName: my-scheduler
  containers:
  - image: nginx
    name: nginx
root@controlplane:~# 



root@controlplane:~# kubectl get pods
NAME    READY   STATUS              RESTARTS   AGE
nginx   0/1     ContainerCreating   0          13s
root@controlplane:~# kubectl get pods
NAME    READY   STATUS              RESTARTS   AGE
nginx   0/1     ContainerCreating   0          17s
root@controlplane:~# kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          29s
root@controlplane:~# 



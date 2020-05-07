master $ kubectl get pods --all-namespaces
NAMESPACE     NAME                             READY   STATUS    RESTARTS   AGE
kube-system   coredns-5644d7b6d9-nrrkq         1/1     Running   0          2m14s
kube-system   coredns-5644d7b6d9-r6bqm         1/1     Running   0          2m14s
kube-system   etcd-master                      1/1     Running   0          60s
kube-system   kube-apiserver-master            1/1     Running   0          82s
kube-system   kube-controller-manager-master   1/1     Running   0          65s
kube-system   kube-proxy-f6t2t                 1/1     Running   0          2m14s
kube-system   kube-proxy-x99wp                 1/1     Running   0          115s
kube-system   kube-scheduler-master            1/1     Running   0          67s
kube-system   weave-net-7wr2d                  2/2     Running   0          2m14s
kube-system   weave-net-mf8s5                  2/2     Running   1          115s
master $

Deploy an additional scheduler to the cluster following the given specification.
Use the manifest file used by kubeadm tool. Use a different port than the one used by the current one.

Namespace: kube-system
Name: my-scheduler
Status: Running
Custom Scheduler Name

Answer: Use the file at /etc/kubernetes/manifests/kube-scheduler.yaml to create your own scheduler. View answer file at /var/answers
master $ kubectl apply -f my-scheduler.yaml
pod/my-scheduler created
master $

-------------------------->

Q: A POD definition file is given. Use it to create a POD with the new custom scheduler.
File is located at /root/nginx-pod.yaml
--------------------------------------------->
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    -  image: nginx
       name: nginx
  schedulerName: my-scheduler

master $ kubectl apply -f nginx-pod.yaml
pod/nginx created
master $ kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          19s
master $


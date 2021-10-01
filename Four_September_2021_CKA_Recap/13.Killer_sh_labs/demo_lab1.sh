#killer.sh lab practices

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl  config get-contexts
CURRENT   NAME       CLUSTER    AUTHINFO   NAMESPACE
*         minikube   minikube   minikube   default
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl  config get-contexts -o name
minikube
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl  config  view -o jsonpath='{.contexts[*]}'
{"context":{"cluster":"minikube","extensions":[{"extension":{"last-update":"Thu, 30 Sep 2021 06:05:19 +08","provider":"minikube.sigs.k8s.io","version":"v1.20.0"},"name":"context_info"}],"namespace":"default","user":"minikube"},"name":"minikube"}MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl  config  view -o jsonpath='{.contexts[*].name}'
minikube
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl config current-context
minikube
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ cat ~/.kube/config | grep -i current | sed -e "s/current-context: //"
minikube
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl config use-context minikube
Switched to context "minikube".
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl config current-context
minikube
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl get nodes
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   26d   v1.20.2
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 



MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl get node minikube --show-labels
NAME       STATUS   ROLES                  AGE   VERSION   LABELS
minikube   Ready    control-plane,master   26d   v1.20.2   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,color=blue,kubernetes.io/arch=amd64,kubernetes.io/hostname=minikube,kubernetes.io/os=linux,minikube.k8s.io/commit=c61663e942ec43b20e8e70839dcca52e44cd85ae,minikube.k8s.io/name=minikube,minikube.k8s.io/updated_at=2021_09_04T14_52_27_0700,minikube.k8s.io/version=v1.20.0,node-role.kubernetes.io/control-plane=,node-role.kubernetes.io/master=,size=Large
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ export do="--dry-run=client -o yaml"
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ alias k=kubectl
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k run pod1 --image=httpd:2.4.41-alpine $do > pod1_tolerations_nodeselector.yaml
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$

Important here to add the toleration for running on master nodes, 
but also the nodeSelector to make sure it only runs on master nodes. 
If we only specify a toleration the Pod can be scheduled on master or worker nodes


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f pod1_tolerations_nodeselector.yaml 
pod/pod1 created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get pods -o wide
NAME   READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
pod1   1/1     Running   0          10m   172.17.0.9   minikube   <none>           <none>
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl config use-context minikube
Switched to context "minikube".
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl get pod --show-labels
NAME   READY   STATUS    RESTARTS   AGE   LABELS
pod1   1/1     Running   0          13m   run=pod1
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl delete pod pod1 --grace-period=0 --force
warning: Immediate deletion does not wait for confirmation that the running resource has been terminated. The resource may continue to run on the cluster indefinitely.
pod "pod1" force deleted
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


How to scaledown stateful set:
-------------------------------------->
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl scale sts o3db --replicas 1 -n project-c13 --record
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


Question:
------------------------------------------->
Do the following in Namespace default. Create a single Pod named ready-if-service-ready of image nginx:1.16.1-alpine. 
Configure a LivenessProbe which simply runs true. Also configure a ReadinessProbe which does check if the url http://service-am-i-ready:80 is reachable, 
you can use wget -T2 -O- http://service-am-i-ready:80 for this. Start the Pod and confirm it isnt ready because of the ReadinessProbe.

Create a second Pod named am-i-ready of image nginx:1.16.1-alpine with label id: cross-server-ready. 
The already existing Service service-am-i-ready should now have that second Pod as endpoint.

Now the first Pod should be in ready state, confirm that.

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f pod_with_liveness_readiness.yaml 
pod/ready-if-service-ready created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k run am-i-ready --image=nginx:1.16.1-alpine --labels="id=cross-server-ready"
pod/am-i-ready created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 




MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl config use-context minikube
Switched to context "minikube".
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 



MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl get pods --all-namespaces --sort-by=.metadata.creationTimestamp
NAMESPACE              NAME                                        READY   STATUS    RESTARTS   AGE
kube-system            storage-provisioner                         1/1     Running   151        26d
kube-system            kube-scheduler-minikube                     1/1     Running   11         26d
kube-system            etcd-minikube                               1/1     Running   11         26d
kube-system            kube-apiserver-minikube                     1/1     Running   17         26d
kube-system            kube-controller-manager-minikube            1/1     Running   11         26d
kube-system            coredns-74ff55c5b-plhmt                     1/1     Running   13         26d
kube-system            kube-proxy-w85sf                            1/1     Running   11         26d
kube-system            metrics-server-7894db45f8-7svvw             1/1     Running   20         10d
kubernetes-dashboard   dashboard-metrics-scraper-f6647bd8c-twmmf   1/1     Running   9          10d
kubernetes-dashboard   kubernetes-dashboard-968bcb79-gsnz9         1/1     Running   16         10d
kube-system            weave-net-7p8fq                             2/2     Running   9          3d17h
default                am-i-ready                                  1/1     Running   0          16m
default                ready-if-service-ready                      0/1     Running   0          14m
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl get pods --all-namespaces --sort-by=.metadata.uid
NAMESPACE              NAME                                        READY   STATUS    RESTARTS   AGE
kube-system            weave-net-7p8fq                             2/2     Running   9          3d17h
kube-system            kube-controller-manager-minikube            1/1     Running   11         26d
default                am-i-ready                                  1/1     Running   0          18m
default                ready-if-service-ready                      0/1     Running   0          16m
kube-system            metrics-server-7894db45f8-7svvw             1/1     Running   20         10d
kube-system            coredns-74ff55c5b-plhmt                     1/1     Running   13         26d
kube-system            kube-scheduler-minikube                     1/1     Running   11         26d
kube-system            kube-proxy-w85sf                            1/1     Running   11         26d
kube-system            storage-provisioner                         1/1     Running   151        26d
kubernetes-dashboard   dashboard-metrics-scraper-f6647bd8c-twmmf   1/1     Running   9          10d
kube-system            etcd-minikube                               1/1     Running   11         26d
kubernetes-dashboard   kubernetes-dashboard-968bcb79-gsnz9         1/1     Running   16         10d
kube-system            kube-apiserver-minikube                     1/1     Running   17         26d
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 



Create a new PersistentVolume named safari-pv. 
It should have a capacity of 2Gi, accessMode ReadWriteOnce, hostPath /Volumes/Data and no storageClassName defined.

Next create a new PersistentVolumeClaim in Namespace project-tiger named safari-pvc. 
It should request 2Gi storage, accessMode ReadWriteOnce and should not define a storageClassName. The PVC should bound to the PV correctly.

Finally create a new Deployment safari in Namespace project-tiger which mounts that volume at /tmp/safari-data.
The Pods of that Deployment should be of image httpd:2.4.41-alpine.


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f create_pv.yaml 
persistentvolume/safari-pv created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get pv
NAME        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
safari-pv   2Gi        RWO            Retain           Available                                   8s
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f create_pvc.yaml 
persistentvolumeclaim/safari-pvc created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                      STORAGECLASS   REASON   AGE
pvc-21b9e417-b070-4995-8e76-5cb8bd336fb9   2Gi        RWO            Delete           Bound       project-tiger/safari-pvc   standard                5s
safari-pv                                  2Gi        RWO            Retain           Available                                                      22s
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get pvc
No resources found in default namespace.
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get pvc -n project-tiger
NAME         STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
safari-pvc   Bound    pvc-21b9e417-b070-4995-8e76-5cb8bd336fb9   2Gi        RWO            standard       25s
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k describe pvc safari-pvc -n project-tiger
Name:          safari-pvc
Namespace:     project-tiger
StorageClass:  standard
Status:        Bound
Volume:        pvc-21b9e417-b070-4995-8e76-5cb8bd336fb9
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: k8s.io/minikube-hostpath
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      2Gi
Access Modes:  RWO
VolumeMode:    Filesystem
Mounted By:    <none>
Events:
  Type    Reason                 Age   From                                                                    Message
  ----    ------                 ----  ----                                                                    -------
  Normal  ExternalProvisioning   50s   persistentvolume-controller                                             waiting for a volume to be created, either by external provisioner "k8s.io/minikube-hostpath" or manually created by system administrator
  Normal  Provisioning           50s   k8s.io/minikube-hostpath_minikube_c25e2f0f-9284-4708-bd0f-eee7a5d70258  External provisioner is provisioning volume for claim "project-tiger/safari-pvc"
  Normal  ProvisioningSucceeded  50s   k8s.io/minikube-hostpath_minikube_c25e2f0f-9284-4708-bd0f-eee7a5d70258  Successfully provisioned volume pvc-21b9e417-b070-4995-8e76-5cb8bd336fb9
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get pv
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                      STORAGECLASS   REASON   AGE
pvc-21b9e417-b070-4995-8e76-5cb8bd336fb9   2Gi        RWO            Delete           Bound       project-tiger/safari-pvc   standard                90s
safari-pv                                  2Gi        RWO            Retain           Available                                                      107s
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$



MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get pv,pvc -n project-tiger
NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM                      STORAGECLASS   REASON   AGE
persistentvolume/pvc-85aafe92-1ea5-40ef-a459-f4dc78a2eea5   2Gi        RWO            Delete           Bound       project-tiger/safari-pvc   standard                11s
persistentvolume/safari-pv                                  2Gi        RWO            Retain           Available                                                      4m52s

NAME                               STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/safari-pvc   Bound    pvc-85aafe92-1ea5-40ef-a459-f4dc78a2eea5   2Gi        RWO            standard       11s
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f deployment_with_pv_pvc.yaml 
deployment.apps/safari created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-tiger describe pod 
Name:         safari-5cb6b66856-hzcq5
Namespace:    project-tiger
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Fri, 01 Oct 2021 09:25:35 +0800
Labels:       app=safari
              pod-template-hash=5cb6b66856
Annotations:  <none>
Status:       Running
IP:           172.17.0.8
IPs:
  IP:           172.17.0.8
Controlled By:  ReplicaSet/safari-5cb6b66856
Containers:
  httpd:
    Container ID:   docker://56c49b263cf5156f29bb305c92a22cf5db40a0e9e8fe6dd9479c7d26eb708909
    Image:          httpd:2.4.41-alpine
    Image ID:       docker-pullable://httpd@sha256:06ad90574c3a152ca91ba9417bb7a8f8b5757b44d232be12037d877e9f8f68ed
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Fri, 01 Oct 2021 09:25:37 +0800
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /tmp/safari-data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-jpszx (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  data:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  safari-pvc
    ReadOnly:   false
  default-token-jpszx:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-jpszx
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  55s   default-scheduler  Successfully assigned project-tiger/safari-5cb6b66856-hzcq5 to minikube
  Normal  Pulled     53s   kubelet            Container image "httpd:2.4.41-alpine" already present on machine
  Normal  Created    53s   kubelet            Created container httpd
  Normal  Started    53s   kubelet            Started container httpd
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-tiger describe pod | grep -A2 Mounts:   
    Mounts:
      /tmp/safari-data from data (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-jpszx (ro)
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k top node
NAME       CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
minikube   561m         28%    1035Mi          52%       
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k top pods
NAME                     CPU(cores)   MEMORY(bytes)   
ready-if-service-ready   3m           2Mi             
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl config use-context minikube
Switched to context "minikube".
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 




root@minikube:/# ps aux | grep kubelet
root        1070 13.7  4.2 1960900 87340 ?       Ssl  01:36  23:02 /var/lib/minikube/binaries/v1.20.2/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime=docker --hostname-override=minikube --kubeconfig=/etc/kubernetes/kubelet.conf --node-ip=192.168.49.2
root        2158 20.1 15.8 1167116 321964 ?      Ssl  01:36  33:42 kube-apiserver --advertise-address=192.168.49.2 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/var/lib/minikube/certs/ca.crt --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota --enable-bootstrap-token-auth=true --etcd-cafile=/var/lib/minikube/certs/etcd/ca.crt --etcd-certfile=/var/lib/minikube/certs/apiserver-etcd-client.crt --etcd-keyfile=/var/lib/minikube/certs/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --insecure-port=0 --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/var/lib/minikube/certs/front-proxy-client.crt --proxy-client-key-file=/var/lib/minikube/certs/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=8443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/var/lib/minikube/certs/sa.pub --service-account-signing-key-file=/var/lib/minikube/certs/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/var/lib/minikube/certs/apiserver.crt --tls-private-key-file=/var/lib/minikube/certs/apiserver.key
docker      4618  1.3  2.2 745128 46468 ?        Ssl  01:37   2:15 /metrics-server --cert-dir=/tmp --secure-port=4443 --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --kubelet-use-node-status-port --metric-resolution=15s --kubelet-insecure-tls
root       64274  0.0  0.0   3436   656 pts/1    S+   04:24   0:00 grep --color=auto kubelet
root@minikube:/# find /etc/systemd/system/ | grep kube
/etc/systemd/system/kubelet.service.d
/etc/systemd/system/kubelet.service.d/10-kubeadm.conf
/etc/systemd/system/multi-user.target.wants/minikube-automount.service
root@minikube:/# 



# /opt/course/8/master-components.txt
kubelet: process
kube-apiserver: static-pod
kube-scheduler: static-pod
kube-scheduler-special: static-pod (status CrashLoopBackOff)
kube-controller-manager: static-pod
etcd: static-pod
dns: pod coredns


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k run manual-schedule --image=httpd:2.4-alpine
pod/manual-schedule created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 



kill the scheduler:
---------------------------->
➜ root@cluster2-master1:~# cd /etc/kubernetes/manifests/
➜ root@cluster2-master1:~# mv kube-scheduler.yaml ..


create a pod and update the "nodeName" field to master node.


Start the scheduler again:
------------------------------------->
k run manual-schedule2 --image=httpd:2.4-alpine



 RBAC ServiceAccount Role RoleBinding
 --------------------------------------------------------------------->
Create a new ServiceAccount processor in Namespace project-hamster. Create a Role and RoleBinding, both named processor as well. 
These should allow the new SA to only create Secrets and ConfigMaps in that Namespace.


Role + RoleBinding (available in single Namespace, applied in single Namespace)
ClusterRole + ClusterRoleBinding (available cluster-wide, applied cluster-wide)
ClusterRole + RoleBinding (available cluster-wide, applied in single Namespace)
Role + ClusterRoleBinding (NOT POSSIBLE: available in single Namespace, applied cluster-wide)


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl create namespace project-hamster
namespace/project-hamster created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-hamster create sa processor
serviceaccount/processor created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-hamster create role processor --verb=create --resource=secret --resource=configmap
role.rbac.authorization.k8s.io/processor created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-hamster create rolebinding processor --role processor --serviceaccount project-hamster:processor
rolebinding.rbac.authorization.k8s.io/processor created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-hamster describe rolebinding processor
Name:         processor
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  Role
  Name:  processor
Subjects:
  Kind            Name       Namespace
  ----            ----       ---------
  ServiceAccount  processor  project-hamster
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-hamster auth can-i create configmap --as system:serviceaccount:project-hamster:processor 
yes
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-hamster auth can-i create secret --as system:serviceaccount:project-hamster:processor 
yes
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-hamster get rolebinding processor -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  creationTimestamp: "2021-10-01T09:05:51Z"
  managedFields:
  - apiVersion: rbac.authorization.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:roleRef:
        f:apiGroup: {}
        f:kind: {}
        f:name: {}
      f:subjects: {}
    manager: kubectl-create
    operation: Update
    time: "2021-10-01T09:05:51Z"
  name: processor
  namespace: project-hamster
  resourceVersion: "241989"
  uid: a67fd027-22db-46ac-8a12-09f17399e6db
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: processor
subjects:
- kind: ServiceAccount
  name: processor
  namespace: project-hamster
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-hamster get role processor -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: "2021-10-01T09:03:06Z"
  managedFields:
  - apiVersion: rbac.authorization.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:rules: {}
    manager: kubectl-create
    operation: Update
    time: "2021-10-01T09:03:06Z"
  name: processor
  namespace: project-hamster
  resourceVersion: "241874"
  uid: f54d696e-a60b-4bb0-9ba9-56f9ec3fd91b
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  - configmaps
  verbs:
  - create
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 




 DaemonSet on all Nodes
 -------------------------------------------------------------->
Use Namespace project-tiger for the following. 
Create a DaemonSet named ds-important with image httpd:2.4-alpine and labels id=ds-important and uuid=18426a0b-5f59-4e10-923f-c0e078e82462. 
The Pods it creates should request 10 millicore cpu and 10 megabytes memory. The Pods of that DaemonSet should run on all nodes.

As of now we arent able to create a DaemonSet directly using kubectl, so we create a Deployment and just change it up.

It was requested that the DaemonSet runs on all nodes, so we need to specify the toleration for this.
cause master node has taints set on it. So we need to adhere to tolerations on pod for the master node.








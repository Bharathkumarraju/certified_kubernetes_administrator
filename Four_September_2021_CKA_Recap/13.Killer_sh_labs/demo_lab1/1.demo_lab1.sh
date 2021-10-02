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

k apply -f deployment_to_daemonset.yaml 

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get all -n project-tiger
NAME                          READY   STATUS    RESTARTS   AGE
pod/ds-important-k7tsw        1/1     Running   0          25m
pod/safari-5cb6b66856-hzcq5   1/1     Running   0          10h

NAME                          DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/ds-important   1         1         1       1            1           <none>          25m

NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/safari   1/1     1            1           10h

NAME                                DESIRED   CURRENT   READY   AGE
replicaset.apps/safari-5cb6b66856   1         1         1       10h
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


Question:
----------------------------------------------------------------------------------->

Use Namespace "project-tiger" for the following.

Create a Deployment named "deploy-important" with label "id=very-important" (the pods should also have this label) and 3 replicas. 
It should contain two containers, the first named container1 with image "nginx:1.17.6-alpine" and the second one named container2 with image "kubernetes/pause".

There should be only ever one Pod of that Deployment running on one worker node.
We have two worker nodes: "cluster1-worker1" and "cluster1-worker2". Because the Deployment has three replicas the result should be that on both nodes one Pod is running. 
The third Pod wont be scheduled, unless a new worker node will be added.

In a way we kind of simulate the behaviour of a DaemonSet here, but using a Deployment and a fixed number of replicas.

"Inter-pod anti-affinity"
----------------------------------------------------------------------------------------------------->

The idea here is that we create a "Inter-pod anti-affinity" which allows us to say 
a Pod should only be scheduled on a node where another Pod of a specific label (here the same label - "id=very-important") is not already running.


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-tiger create deployment \
  --image=nginx:1.17.6-alpine deploy-important $do > deploy_inter-pod-anti-affinity.yaml
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

Specify a topologyKey, which is a pre-populated Kubernetes label, you can find this by describing a node.

apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    id: very-important
  name: deploy-important
  namespace: project-tiger
spec:
  replicas: 3
  selector:
    matchLabels:
      id: very-important
  strategy: {}
  template:
    metadata:
      labels:
        id: very-important
    spec:
      containers:
      - image: nginx:1.17.6-alpine
        name: nginx
      - image: kubernetes/pause
        name: container2
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: id
                operator: In
                values:
                - very-important
            topologyKey: topology.kubernetes.io/hostname



MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f deploy_inter-pod-anti-affinity.yaml -n project-tiger
deployment.apps/deploy-important created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl get all -n project-tiger
NAME                                    READY   STATUS    RESTARTS   AGE
pod/deploy-important-66f7547f95-8wjqd   2/2     Running   0          5m49s
pod/deploy-important-66f7547f95-9dbdx   2/2     Running   0          5m49s
pod/deploy-important-66f7547f95-wvjq6   2/2     Running   0          5m49s
pod/ds-important-k7tsw                  1/1     Running   0          179m
pod/safari-5cb6b66856-hzcq5             1/1     Running   0          13h

NAME                          DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
daemonset.apps/ds-important   1         1         1       1            1           <none>          179m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/deploy-important   3/3     3            3           5m49s
deployment.apps/safari             1/1     1            1           13h

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/deploy-important-66f7547f95   3         3         3       5m49s
replicaset.apps/safari-5cb6b66856             1         1         1       13h
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 



Question:
------------------------------------------------------------------------------------------------------>
Create a Pod named multi-container-playground in Namespace default with three containers, 
named c1, c2 and c3. There should be a volume attached to that Pod and mounted into every container, but the volume shouldnt be persisted or shared with other Pods.

Container c1 should be of image nginx:1.17.6-alpine and have the name of the node where its Pod is running on value available as environment variable MY_NODE_NAME.

Container c2 should be of image busybox:1.31.1 and write the output of the date command every second in the shared volume into file date.log. 
You can use while true; do date >> /your/vol/path/date.log; sleep 1; done for this.

Container c3 should be of image busybox:1.31.1 and constantly write the content of file date.log from the shared volume to stdout. You can use tail -f /your/vol/path/date.log for this.

Check the logs of container c3 to confirm correct setup.




MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f multi_cotainer_pod.yaml
pod/multi-container-playground created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get all
NAME                             READY   STATUS              RESTARTS   AGE
pod/am-i-ready                   1/1     Running             0          15h
pod/manual-schedule              1/1     Running             0          10h
pod/multi-container-playground   0/3     ContainerCreating   0          6s
pod/ready-if-service-ready       0/1     Running             0          15h

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   27d
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get all
NAME                             READY   STATUS             RESTARTS   AGE
pod/am-i-ready                   1/1     Running            0          15h
pod/manual-schedule              1/1     Running            0          10h
pod/multi-container-playground   2/3     CrashLoopBackOff   5          5m2s
pod/ready-if-service-ready       0/1     Running            0          15h

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   27d
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k describe node | less -p PodCIDR
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

root@minikube:/# ps -eaf | grep "kube-apiserver "
root        2158    2076 19 08:31 ?        01:22:11 kube-apiserver --advertise-address=192.168.49.2 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/var/lib/minikube/certs/ca.crt --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota --enable-bootstrap-token-auth=true --etcd-cafile=/var/lib/minikube/certs/etcd/ca.crt --etcd-certfile=/var/lib/minikube/certs/apiserver-etcd-client.crt --etcd-keyfile=/var/lib/minikube/certs/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --insecure-port=0 --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/var/lib/minikube/certs/front-proxy-client.crt --proxy-client-key-file=/var/lib/minikube/certs/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=8443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/var/lib/minikube/certs/sa.pub --service-account-signing-key-file=/var/lib/minikube/certs/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/var/lib/minikube/certs/apiserver.crt --tls-private-key-file=/var/lib/minikube/certs/apiserver.key
root      178374  178284  0 15:42 pts/1    00:00:00 grep --color=auto kube-apiserver 
root@minikube:/# cd /etc/cni/net.d/
root@minikube:/etc/cni/net.d# ls -rlth
total 16K
-rw-r--r-- 1 root root  54 Mar 15  2021 200-loopback.conf
-rw-r--r-- 1 root root 438 Mar 15  2021 100-crio-bridge.conf
-rw-r--r-- 1 root root 639 Apr 22 20:08 87-podman-bridge.conflist
-rw-r--r-- 1 root root 318 Sep 27 07:00 10-weave.conflist
root@minikube:/etc/cni/net.d# cat 10-weave.conflist 
{
    "cniVersion": "0.3.0",
    "name": "weave",
    "plugins": [
        {
            "name": "weave",
            "type": "weave-net",
            "hairpinMode": true
        },
        {
            "type": "portmap",
            "capabilities": {"portMappings": true},
            "snat": true
        }
    ]
}
root@minikube:/etc/cni/net.d# 



kubect get events:
---------------------------------------------------------->
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ kubectl get events -A --sort-by=.metadata.creationTimestamp
NAMESPACE   LAST SEEN   TYPE      REASON      OBJECT                           MESSAGE
default     56s         Warning   Unhealthy   pod/ready-if-service-ready       Readiness probe failed: wget: bad address 'service-am-i-ready:80'
default     21m         Normal    Scheduled   pod/multi-container-playground   Successfully assigned default/multi-container-playground to minikube
default     21m         Normal    Created     pod/multi-container-playground   Created container c1
default     21m         Normal    Started     pod/multi-container-playground   Started container c1
default     21m         Normal    Pulling     pod/multi-container-playground   Pulling image "busybox:1.31.1"
default     21m         Normal    Pulled      pod/multi-container-playground   Container image "nginx:1.17.6-alpine" already present on machine
default     21m         Normal    Pulled      pod/multi-container-playground   Successfully pulled image "busybox:1.31.1" in 9.7730653s
default     21m         Normal    Started     pod/multi-container-playground   Started container c2
default     20m         Normal    Pulled      pod/multi-container-playground   Container image "busybox:1.31.1" already present on machine
default     21m         Normal    Created     pod/multi-container-playground   Created container c2
default     20m         Normal    Created     pod/multi-container-playground   Created container c3
default     20m         Normal    Started     pod/multi-container-playground   Started container c3
default     16m         Warning   BackOff     pod/multi-container-playground   Back-off restarting failed container
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n kube-system get pod -o wide | grep proxy
kube-proxy-w85sf                   1/1     Running   11         27d    192.168.49.2   minikube   <none>           <none>
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


Write a command into /opt/course/15/cluster_events.sh which shows the latest events in the whole cluster, ordered by time. Use kubectl for it.

Now kill the kube-proxy Pod running on node cluster2-worker1 and write the events this caused into /opt/course/15/pod_kill.log.

Finally kill the main docker container of the kube-proxy Pod on node cluster2-worker1 and write the events into /opt/course/15/container_kill.log.

Do you notice differences in the events both actions caused?




MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-tiger get role --no-headers | wc -l
No resources found in project-tiger namespace.
       0
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 



MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n project-tiger run tigers-reunite \
  --image=httpd:2.4.41-alpine \
  --labels "pod=container,container=pod"
pod/tigers-reunite created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

ssh cluster1-worker2 "docker logs 3dffb59b81ac" &> /opt/course/17/pod-container.log
The "&>" in above command redirects both the standard output and standard error.

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f secret1.yaml 
secret/secret1 created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n secret create secret generic secret2 --from-literal=user=user1 --from-literal=pass=1234
secret/secret2 created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n secret run secret-pod --image=busybox:1.31.1 $do -- sh -c "sleep 5d" > pod_with_secret.yaml
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k apply -f pod_with_secret.yaml
pod/secret-pod created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k get all -n secret
NAME             READY   STATUS    RESTARTS   AGE
pod/secret-pod   1/1     Running   0          24s
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n secret exec secret-pod -- env | grep APP
APP_USER=user1
APP_PASS=1234
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n secret exec secret-pod -- find /tmp/secret1
/tmp/secret1
/tmp/secret1/..data
/tmp/secret1/halt
/tmp/secret1/..2021_10_01_21_53_44.630910713
/tmp/secret1/..2021_10_01_21_53_44.630910713/halt
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k -n secret exec secret-pod -- cat /tmp/secret1/halt
password123
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


cluster3-worker2 is running an older Kubernetes version and is not even part of the cluster.
Update kubectl and kubeadm to the exact version thats running on cluster3-master1.
Then add this node to the cluster, you can use kubeadm for this.



➜ k get node
NAME               STATUS   ROLES    AGE   VERSION
cluster3-master1   Ready    master   27h   v1.21.0
cluster3-worker1   Ready    <none>   27h   v1.21.0


ssh cluster3-worker2
​
➜ root@cluster3-worker2:~# kubeadm version
kubeadm version: &version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.0", GitCommit:"c4d752765b3bbac2237b-if-you-read-this-then-you-are-awesome-f87cf0b1c2e307844666", GitTreeState:"clean", BuildDate:"2020-12-18T12:07:13Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}
​
➜ root@cluster3-worker2:~# kubectl version
Client Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.5", GitCommit:"1dd5338295409edcfff11505e7bb246f0d325d15", GitTreeState:"clean", BuildDate:"2021-01-13T13:23:52Z", GoVersion:"go1.15.5", Compiler:"gc", Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?
​
➜ root@cluster3-worker2:~# kubelet --version
Kubernetes v1.20.5

➜ root@cluster3-worker2:~# kubeadm upgrade node
couldnt create a Kubernetes client from file "/etc/kubernetes/kubelet.conf": failed to load admin kubeconfig: open /etc/kubernetes/kubelet.conf: no such file or directory
To see the stack trace of this error execute with --v=5 or higher



This is usually the proper command to upgrade a node. But this error means that this node was never even initialised, so nothing to update here.
This will be done later using kubeadm join. For now we can continue with kubelet and kubectl:


➜ root@cluster3-worker2:~# apt-cache show kubectl | grep 1.21
​
➜ root@cluster3-worker2:~# apt-get install kubectl=1.21.0-00 kubelet=1.21.0-00
Now we are up to date with kubeadm, kubectl and kubelet. Restart the kubelet:


➜ root@cluster3-worker2:~# systemctl restart kubelet
​
➜ root@cluster3-worker2:~# service kubelet status
...$KUBELET_KUBEADM_ARGS $KUBELET_EXTRA_ARGS (code=exited, status=255)
 Main PID: 21457 (code=exited, status=255)
...
Apr 30 22:15:08 cluster3-worker2 systemd[1]: kubelet.service: Main process exited, code=exited, status=255/n/a
Apr 30 22:15:08 cluster3-worker2 systemd[1]: kubelet.service: Failed with result 'exit-code'.


Add cluster3-worker2 to cluster:
------------------------------------->
➜ ssh cluster3-master1

First we log into the master1 and generate a new TLS bootstrap token, also printing out the join command:
➜ root@cluster3-master1:~# kubeadm token create --print-join-command
kubeadm join 192.168.100.31:6443 --token mnkpfu.d2lpu8zypbyumr3i     --discovery-token-ca-cert-hash sha256:c82a5024d2b5c4778c2552fedf696cf1977741934cf4b5588d7524d66c35d869

➜ root@cluster3-master1:~# kubeadm token list
TOKEN                     TTL         EXPIRES                ...
mnkpfu.d2lpu8zypbyumr3i   23h         2020-05-01T22:43:45Z   ...
poa13f.hnrs6i6ifetwii75   <forever>   <never>                ...

Next we connect again to worker2 and simply execute the join command:

➜ ssh cluster3-worker2
​
➜ root@cluster3-worker2:~# kubeadm join 192.168.100.31:6443 --token o9d16r.8akubogug2dva290 --discovery-token-ca-cert-hash sha256:24df0bf17c4cb32d64ee045846939793922d0b6bf850f7b7b95fe4e1811ee99d
[preflight] Running pre-flight checks
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -o yaml'
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Starting the kubelet
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
​
This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.
​
Run 'kubectl get nodes' on the control-plane to see this node join the cluster.
​
​
➜ root@cluster3-worker2:~# service kubelet status
● kubelet.service - kubelet: The Kubernetes Node Agent
   Loaded: loaded (/lib/systemd/system/kubelet.service; enabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/kubelet.service.d
           └─10-kubeadm.conf
   Active: active (running) since Fri 2020-09-04 16:36:51 UTC; 22s ago
     Docs: https://kubernetes.io/docs/home/



➜ ssh cluster3-master1
​
➜ root@cluster1-master1:~# cd /etc/kubernetes/manifests/

MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k run my-static-pod --image=nginx:1.16-alpine --requests "cpu=10m,memory=20Mi" $do > my-static-pod.yaml
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


➜ k get svc,ep -l run=my-static-pod
NAME                         TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/static-pod-service   NodePort   10.99.168.252   <none>        80:30352/TCP   30s
​
NAME                           ENDPOINTS      AGE
endpoints/static-pod-service   10.32.0.4:80   30s


Question:
------------------------------------------------------------------------------------->
Use context: kubectl config use-context k8s-c2-AC

 

Check how long the kube-apiserver server certificate is valid on cluster2-master1. Do this with openssl or cfssl. Write the exipiration date into /opt/course/22/expiration.
Also run the correct kubeadm command to list the expiration dates and confirm both methods show the same date.
Write the correct kubeadm command that would renew the apiserver server certificate into /opt/course/22/kubeadm-renew-certs.sh.

➜ ssh cluster2-master1
​
➜ root@cluster2-master1:~# find /etc/kubernetes/pki | grep apiserver
/etc/kubernetes/pki/apiserver.crt
/etc/kubernetes/pki/apiserver-etcd-client.crt
/etc/kubernetes/pki/apiserver-etcd-client.key
/etc/kubernetes/pki/apiserver-kubelet-client.crt
/etc/kubernetes/pki/apiserver.key
/etc/kubernetes/pki/apiserver-kubelet-client.key

root@minikube:/etc/kubernetes# cd /var/lib/minikube/certs
root@minikube:/var/lib/minikube/certs# ls -rtlh
total 76K
-rw-r--r-- 1 root root 1.1K Mar 29  2020 ca.crt
-rw------- 1 root root 1.7K Mar 29  2020 ca.key
-rw-r--r-- 1 root root 1.1K Mar 29  2020 proxy-client-ca.crt
-rw------- 1 root root 1.7K Mar 29  2020 proxy-client-ca.key
-rw-r--r-- 1 root root 1.4K Sep  4 06:51 apiserver.crt
-rw------- 1 root root 1.7K Sep  4 06:51 apiserver.key
-rw-r--r-- 1 root root 1.1K Sep  4 06:51 proxy-client.crt
-rw------- 1 root root 1.7K Sep  4 06:51 proxy-client.key
-rw------- 1 root root 1.7K Sep  4 06:51 apiserver-kubelet-client.key
-rw-r--r-- 1 root root 1.1K Sep  4 06:51 apiserver-kubelet-client.crt
-rw------- 1 root root 1.7K Sep  4 06:51 front-proxy-ca.key
-rw-r--r-- 1 root root 1.1K Sep  4 06:51 front-proxy-ca.crt
-rw------- 1 root root 1.7K Sep  4 06:51 front-proxy-client.key
-rw-r--r-- 1 root root 1.1K Sep  4 06:51 front-proxy-client.crt
drwxr-xr-x 2 root root 4.0K Sep  4 06:51 etcd
-rw------- 1 root root 1.7K Sep  4 06:51 apiserver-etcd-client.key
-rw-r--r-- 1 root root 1.2K Sep  4 06:51 apiserver-etcd-client.crt
-rw------- 1 root root  451 Sep  4 06:51 sa.pub
-rw------- 1 root root 1.7K Sep  4 06:51 sa.key
root@minikube:/var/lib/minikube/certs#

root@minikube:/var/lib/minikube/certs# openssl x509 -in apiserver.crt -noout -text
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 2 (0x2)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = minikubeCA
        Validity
            Not Before: Sep  3 06:51:46 2021 GMT
            Not After : Sep  4 06:51:46 2022 GMT
        Subject: O = system:masters, CN = minikube
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:b5:ce:dd:a7:4d:64:93:1e:51:42:b5:bf:f0:f4:
                    cf:ad:b7:71:a9:da:d6:ee:3b:f0:ec:fa:d0:bc:c3:
                    00:a2:8a:df:e1:d2:c4:e8:5b:a6:13:b9:d1:9f:78:
                    47:ad:79:0c:8d:9e:5e:38:f7:9a:f2:f8:8c:74:80:
                    c7:a6:a6:17:cf:c4:b6:ed:11:91:0a:bf:5e:3a:b1:
                    a1:05:8a:d6:e5:cf:d3:0b:9d:5d:af:40:59:87:90:
                    38:bb:ba:8d:8d:46:ec:4c:fc:a9:76:d1:b7:f4:45:
                    85:d9:e4:d1:03:32:7f:37:fb:24:31:06:d3:7e:5c:
                    76:9a:d2:12:77:11:54:c5:43:de:a6:e8:ef:8d:d9:
                    d5:45:6e:06:01:4e:e5:e9:ea:ee:9b:4e:02:98:2c:
                    e0:4d:a0:40:3c:fd:2b:cb:51:38:dd:d9:63:01:c3:
                    a2:07:50:47:25:2b:2c:33:0b:c6:6c:cd:ab:59:7a:
                    d3:1b:50:f8:d3:b2:0d:fe:62:d6:ff:65:35:1f:c1:
                    28:a5:bc:91:44:4e:a1:4a:d2:04:45:04:b3:61:e2:
                    cd:2c:e2:1e:c5:dd:b7:1b:f8:fd:c9:e5:bf:69:a5:
                    db:59:71:b7:eb:31:92:a7:3b:2f:65:df:f5:68:3c:
                    19:4a:a6:3f:0a:38:a3:b9:ad:f4:cc:a3:a5:43:d7:
                    c0:67
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Subject Alternative Name: 
                DNS:minikubeCA, DNS:control-plane.minikube.internal, DNS:kubernetes.default.svc.cluster.local, DNS:kubernetes.default.svc, DNS:kubernetes.default, DNS:kubernetes, DNS:localhost, IP Address:192.168.49.2, IP Address:10.96.0.1, IP Address:127.0.0.1, IP Address:10.0.0.1
    Signature Algorithm: sha256WithRSAEncryption
         84:ae:bc:6e:65:6b:ff:0e:09:09:6d:ef:f8:08:96:a0:9e:76:
         c7:ac:53:f8:92:a5:8d:bf:ca:ec:f4:1d:06:f2:2f:28:8a:2f:
         86:b6:a7:bc:54:7f:b4:d4:43:af:15:87:5b:86:6a:11:bf:c0:
         c8:4d:05:f8:45:fc:1e:5f:49:12:5d:10:74:d4:ec:16:d9:9a:
         46:b3:6b:92:90:63:cf:92:8c:48:dc:d4:85:59:e6:5e:23:b7:
         0b:bf:3f:c6:fc:59:a0:c2:ba:0a:e6:3c:25:80:2c:f4:8f:29:
         e7:e9:7b:62:e1:75:a5:5b:81:98:5f:38:0a:cc:1c:32:c1:9a:
         f7:73:5f:c9:c5:ff:71:27:b3:fd:18:35:ba:e3:c6:74:b2:01:
         01:c4:5d:5c:5e:4b:cb:30:05:0e:92:e1:f3:89:73:bd:42:14:
         d9:59:b5:4a:9c:84:55:e6:f2:42:93:32:6e:f9:d1:4f:f5:3e:
         00:73:8c:2f:f0:6d:31:a8:e8:91:8f:f4:d4:da:04:c0:71:fd:
         83:6f:90:fc:9c:68:54:05:80:1b:2b:4d:b6:fc:30:2a:75:c2:
         76:33:bc:d0:58:74:11:99:c7:d4:4b:96:d2:58:6f:f6:3c:af:
         af:e5:d9:e6:4e:7d:80:35:f0:11:79:9a:54:c1:58:ff:95:e7:
         5f:3d:08:7c
root@minikube:/var/lib/minikube/certs#


root@minikube:/var/lib/minikube/certs# openssl x509 -in apiserver.crt -noout -text | grep -A2 Validity
        Validity
            Not Before: Sep  3 06:51:46 2021 GMT
            Not After : Sep  4 06:51:46 2022 GMT
root@minikube:/var/lib/minikube/certs# kubeadm
bash: kubeadm: command not found
root@minikube:/var/lib/minikube/certs#       


➜ root@cluster2-master1:~# kubeadm certs check-expiration | grep apiserver
apiserver                Jan 14, 2022 18:49 UTC   363d        ca               no      
apiserver-etcd-client    Jan 14, 2022 18:49 UTC   363d        etcd-ca          no      
apiserver-kubelet-client Jan 14, 2022 18:49 UTC   363d        ca               no 


kubeadm certs renew apiserver


Kubelet client/server info:
---------------------------------->

Node cluster2-worker1 has been added to the cluster using kubeadm and TLS bootstrapping.

Find the "Issuer" and "Extended Key Usage" values of the cluster2-worker1:

kubelet client certificate, the one used for outgoing connections to the kube-apiserver.
kubelet server certificate, the one used for incoming connections from the kube-apiserver.
Write the information into file /opt/course/23/certificate-info.txt.

Compare the "Issuer" and "Extended Key Usage" fields of both certificates and make sense of these.



To find the correct kubelet certificate directory, we can look for the default value of the --cert-dir parameter for the kubelet.



/etc/systemd/system/kubelet.service.d/10-kubeadm.conf


➜ ssh cluster2-worker1
​
➜ root@cluster2-worker1:~# openssl x509  -noout -text -in /var/lib/kubelet/pki/kubelet-client-current.pem | grep Issuer
        Issuer: CN = kubernetes
        
➜ root@cluster2-worker1:~# openssl x509  -noout -text -in /var/lib/kubelet/pki/kubelet-client-current.pem | grep "Extended Key Usage" -A1
            X509v3 Extended Key Usage: 
                TLS Web Client Authentication

➜ root@cluster2-worker1:~# openssl x509  -noout -text -in /var/lib/kubelet/pki/kubelet.crt | grep Issuer
          Issuer: CN = cluster2-worker1-ca@1588186506
​
➜ root@cluster2-worker1:~# openssl x509  -noout -text -in /var/lib/kubelet/pki/kubelet.crt | grep "Extended Key Usage" -A1
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication


NetworkPolicy:
------------------------------------------------------------------------------------------------------------------------------>

There was a security incident where an intruder was able to access the whole cluster from a single hacked backend Pod.

To prevent this create a NetworkPolicy called np-backend in Namespace project-snake. It should allow the backend-* Pods only to:

connect to db1-* Pods on port 1111
connect to db2-* Pods on port 2222
Use the app label of Pods in your policy.

After implementation, connections from backend-* Pods to vault-* Pods on port 3333 should for example no longer work.


MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k create namespace project-snake
namespace/project-snake created
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ 


➜ k -n project-snake get pod
NAME        READY   STATUS    RESTARTS   AGE
backend-0   1/1     Running   0          8s
db1-0       1/1     Running   0          8s
db2-0       1/1     Running   0          10s
vault-0     1/1     Running   0          10s


 ➜ k -n project-snake get pod -L app
NAME        READY   STATUS    RESTARTS   AGE     APP
backend-0   1/1     Running   0          3m15s   backend
db1-0       1/1     Running   0          3m15s   db1
db2-0       1/1     Running   0          3m17s   db2
vault-0     1/1     Running   0          3m17s   vault

We test the current connection situation and see nothing is restricted:

➜ k -n project-snake get pod -o wide
NAME        READY   STATUS    RESTARTS   AGE     IP          ...
backend-0   1/1     Running   0          4m14s   10.44.0.24  ...
db1-0       1/1     Running   0          4m14s   10.44.0.25  ...
db2-0       1/1     Running   0          4m16s   10.44.0.23  ...
vault-0     1/1     Running   0          4m16s   10.44.0.22  ...
​

➜ k -n project-snake exec backend-0 -- curl -s 10.44.0.25:1111
database one
​
➜ k -n project-snake exec backend-0 -- curl -s 10.44.0.23:2222
database two
​
➜ k -n project-snake exec backend-0 -- curl -s 10.44.0.22:3333
vault secret storage


-------------->

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: np-backend
  namespace: project-snake
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
    - Egress                    # policy is only about Egress
  egress:
    -                           # first rule
      to:                           # first condition "to"
      - podSelector:
          matchLabels:
            app: db1
      ports:                        # second condition "port"
      - protocol: TCP
        port: 1111
    -                           # second rule
      to:                           # first condition "to"
      - podSelector:
          matchLabels:
            app: db2
      ports:                        # second condition "port"
      - protocol: TCP
        port: 2222


------------------------etcd---------------------------->
➜ root@cluster3-master1:~# ETCDCTL_API=3 etcdctl snapshot save /tmp/etcd-backup.db \
--cacert /etc/kubernetes/pki/etcd/ca.crt \
--cert /etc/kubernetes/pki/etcd/server.crt \
--key /etc/kubernetes/pki/etcd/server.key
​
Snapshot saved at /tmp/etcd-backup.db
➜ root@cluster3-master1:~#



➜ root@cluster3-master1:~# kubectl run test --image=nginx
pod/test created
​
➜ root@cluster3-master1:~# kubectl get pod -l run=test -w
NAME   READY   STATUS    RESTARTS   AGE
test   1/1     Running   0          60s

Now we restore the snapshot, which will be restored into a specific directory:
➜ root@cluster3-master1:~# ETCDCTL_API=3 etcdctl snapshot restore /tmp/etcd-backup.db  --data-dir /var/lib/etcd-backup


Change static pod_location_etcd:
------------------------------------->
➜ root@cluster3-master1:~# vim /etc/kubernetes/manifests/etcd.yaml

# /etc/kubernetes/manifests/etcd.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
...
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  hostNetwork: true
  priorityClassName: system-cluster-critical
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd-backup                # change
      type: DirectoryOrCreate
    name: etcd-data
status: {}


Find Pods first to be terminated
--------------------------------------->

Check all available Pods in the Namespace project-c13 and 
find the names of those that would probably be terminated first 
if the nodes run out of resources (cpu or memory) to schedule all Pods.
 Write the Pod names into /opt/course/e1/pods-not-stable.txt


 When available cpu or memory resources on the nodes reach their limit, 
 Kubernetes will look for Pods that are using more resources than they requested.
 These will be the first candidates for termination.

If some Pods containers have no resource requests/limits set, then by default those are considered to use more than requested.

k -n project-c13 describe pod | less -p Requests 



MacBook-Pro:13.Killer_sh_labs bharathdasaraju$ k describe pod | egrep "^(Name:|    Requests:)" -A1
Name:         am-i-ready
Namespace:    default
--
Name:         manual-schedule
Namespace:    default
--
Name:         my-static-pod
Namespace:    default
--
    Requests:
      cpu:        10m
--
Name:         ready-if-service-ready
Namespace:    default
MacBook-Pro:13.Killer_sh_labs bharathdasaraju$


 Create own Scheduler and use it
 ----------------------------------------->

➜ ssh cluster2-master1
​
➜ root@cluster2-master1:~# cd /etc/kubernetes/manifests/
​
➜ root@cluster2-master1:~# cp kube-scheduler.yaml my-shiny-scheduler.yaml
​
➜ root@cluster2-master1:~# vim my-shiny-scheduler.yaml
 
 need to change two values like below:
 ---------------------------------------------------------------------------->
    - --leader-elect=false                              # change
    - --scheduler-name=my-shiny-scheduler               # add
    - --port=12345                                      # change
    - --secure-port=12346                               # add

    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 12346                                     # change
        scheme: HTTPS
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
        port: 12346                                     # change
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15


Curl Manually Contact API
--------------------------------------->

There is an existing ServiceAccount secret-reader in Namespace project-hamster.

Create a Pod of image curlimages/curl:7.65.3 named tmp-api-contact which uses this ServiceAccount. 
Make sure the container keeps running. 
Exec into the Pod and use curl to access the Kubernetes Api of that cluster manually, 
listing all available secrets. 
You can ignore insecure https connection. Write the command(s) for this into file /opt/course/e4/list-secrets.sh.



k -f pod_with_serviceaccount.yaml create
​
k -n project-hamster exec tmp-api-contact -it -- sh

curl -k https://kubernetes.default # ignore insecure as allowed in ticket description
curl -k https://kubernetes.default/api/v1/secrets # should show Forbidden 403

inside pod we can get the token here:

We find the the token in the mounted folder at "/var/run/secrets/kubernetes.io/serviceaccount", so we do:

TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
curl -k https://kubernetes.default/api/v1/secrets -H "Authorization: Bearer ${TOKEN}"


CACERT=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
curl --cacert ${CACERT} https://kubernetes.default/api/v1/secrets -H "Authorization: Bearer ${TOKEN}"


# /opt/course/e4/list-secrets.sh
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
curl -k https://kubernetes.default/api/v1/secrets -H "Authorization: Bearer ${TOKEN}"


Change kube-apiserver parameters:
--------------------------------------->
Now we change the Service CIDR on the kube-apiserver:
➜ root@cluster2-master1:~# vim /etc/kubernetes/manifests/kube-apiserver.yaml
- --service-cluster-ip-range=11.96.0.0/12             # change

Now we do the same for the controller manager:
root@cluster2-master1:~# vim /etc/kubernetes/manifests/kube-controller-manager.yaml
- --service-cluster-ip-range=11.96.0.0/12         # change

k expose pod check-ip --name check-ip-service2 --port 80




The cluster admin asked you to find out the following information about etcd running on cluster2-master1:

Server private key location
Server certificate expiration date
Is client certificate authentication enabled
Write these information into /opt/course/p1/etcd-info.txt

Finally you are asked to save an etcd snapshot at /etc/etcd-snapshot.db on cluster2-master1 and display its status.


# /etc/kubernetes/manifests/etcd.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: etcd
    tier: control-plane
  name: etcd
  namespace: kube-system
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://192.168.102.11:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt              # server certificate
    - --client-cert-auth=true                                      # enabled
    - --data-dir=/var/lib/etcd
    - --initial-advertise-peer-urls=https://192.168.102.11:2380
    - --initial-cluster=cluster2-master1=https://192.168.102.11:2380
    - --key-file=/etc/kubernetes/pki/etcd/server.key               # server private key

➜ root@cluster2-master1:~# openssl x509  -noout -text -in /etc/kubernetes/pki/etcd/server.crt | grep Validity -A2
        Validity
            Not Before: Sep  4 15:28:39 2020 GMT
            Not After : Sep  4 15:28:39 2021 GMT
ETCDCTL_API=3 etcdctl snapshot save /etc/etcd-snapshot.db \
--cacert /etc/kubernetes/pki/etcd/ca.crt \
--cert /etc/kubernetes/pki/etcd/server.crt \
--key /etc/kubernetes/pki/etcd/server.key


apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: p2-pod
  name: p2-pod
  namespace: project-hamster             # add
spec:
  containers:
  - image: nginx:1.17-alpine
    name: p2-pod
  - image: busybox:1.31                  # add
    name: c2                             # add
    command: ["sh", "-c", "sleep 1d"]    # add
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

k -n project-hamster expose pod p2-pod --name p2-service --port 3000 --target-port 80


root@minikube:/# iptables-save  | grep service
-A INPUT -m conntrack --ctstate NEW -m comment --comment "kubernetes externally-visible service portals" -j KUBE-EXTERNAL-SERVICES
-A FORWARD -m conntrack --ctstate NEW -m comment --comment "kubernetes service portals" -j KUBE-SERVICES
-A FORWARD -m conntrack --ctstate NEW -m comment --comment "kubernetes externally-visible service portals" -j KUBE-EXTERNAL-SERVICES
-A OUTPUT -m conntrack --ctstate NEW -m comment --comment "kubernetes service portals" -j KUBE-SERVICES
-A PREROUTING -m comment --comment "kubernetes service portals" -j KUBE-SERVICES
-A OUTPUT -m comment --comment "kubernetes service portals" -j KUBE-SERVICES
-A KUBE-POSTROUTING -m comment --comment "kubernetes service traffic requiring SNAT" -j MASQUERADE --random-fully
-A KUBE-SERVICES -m comment --comment "kubernetes service nodeports; NOTE: this must be the last rule in this chain" -m addrtype --dst-type LOCAL -j KUBE-NODEPORTS
root@minikube:/# 


➜ ssh cluster1-master1 iptables-save | grep p2-service
-A KUBE-SEP-6U447UXLLQIKP7BB -s 10.44.0.20/32 -m comment --comment "project-hamster/p2-service:" -j KUBE-MARK-MASQ
-A KUBE-SEP-6U447UXLLQIKP7BB -p tcp -m comment --comment "project-hamster/p2-service:" -m tcp -j DNAT --to-destination 10.44.0.20:80
-A KUBE-SERVICES ! -s 10.244.0.0/16 -d 10.97.45.18/32 -p tcp -m comment --comment "project-hamster/p2-service: cluster IP" -m tcp --dport 3000 -j KUBE-MARK-MASQ
-A KUBE-SERVICES -d 10.97.45.18/32 -p tcp -m comment --comment "project-hamster/p2-service: cluster IP" -m tcp --dport 3000 -j KUBE-SVC-2A6FNMCK6FDH7PJH
-A KUBE-SVC-2A6FNMCK6FDH7PJH -m comment --comment "project-hamster/p2-service:" -j KUBE-SEP-6U447UXLLQIKP7BB



➜ ssh cluster1-worker1 iptables-save | grep p2-service
-A KUBE-SEP-6U447UXLLQIKP7BB -s 10.44.0.20/32 -m comment --comment "project-hamster/p2-service:" -j KUBE-MARK-MASQ
-A KUBE-SEP-6U447UXLLQIKP7BB -p tcp -m comment --comment "project-hamster/p2-service:" -m tcp -j DNAT --to-destination 10.44.0.20:80
-A KUBE-SERVICES ! -s 10.244.0.0/16 -d 10.97.45.18/32 -p tcp -m comment --comment "project-hamster/p2-service: cluster IP" -m tcp --dport 3000 -j KUBE-MARK-MASQ
-A KUBE-SERVICES -d 10.97.45.18/32 -p tcp -m comment --comment "project-hamster/p2-service: cluster IP" -m tcp --dport 3000 -j KUBE-SVC-2A6FNMCK6FDH7PJH
-A KUBE-SVC-2A6FNMCK6FDH7PJH -m comment --comment "project-hamster/p2-service:" -j KUBE-SEP-6U447UXLLQIKP7BB


➜ ssh cluster1-worker2 iptables-save | grep p2-service
-A KUBE-SEP-6U447UXLLQIKP7BB -s 10.44.0.20/32 -m comment --comment "project-hamster/p2-service:" -j KUBE-MARK-MASQ
-A KUBE-SEP-6U447UXLLQIKP7BB -p tcp -m comment --comment "project-hamster/p2-service:" -m tcp -j DNAT --to-destination 10.44.0.20:80
-A KUBE-SERVICES ! -s 10.244.0.0/16 -d 10.97.45.18/32 -p tcp -m comment --comment "project-hamster/p2-service: cluster IP" -m tcp --dport 3000 -j KUBE-MARK-MASQ
-A KUBE-SERVICES -d 10.97.45.18/32 -p tcp -m comment --comment "project-hamster/p2-service: cluster IP" -m tcp --dport 3000 -j KUBE-SVC-2A6FNMCK6FDH7PJH
-A KUBE-SVC-2A6FNMCK6FDH7PJH -m comment --comment "project-hamster/p2-service:" -j KUBE-SEP-6U447UXLLQIKP7BB


➜ ssh cluster1-master1 iptables-save | grep p2-service >> /opt/course/p2/iptables.txt
➜ ssh cluster1-worker1 iptables-save | grep p2-service >> /opt/course/p2/iptables.txt
➜ ssh cluster1-worker2 iptables-save | grep p2-service >> /opt/course/p2/iptables.txt



k -n kube-system get pod --show-labels # find labels
k -n kube-system get pod -l component=kube-scheduler > /opt/course/p3/schedulers.txt

NAME      READY   STATUS    ...     NODE     NOMINATED NODE   READINESS GATES
special   0/1     Pending   ...     <none>   <none>           <none>
​
➜ k get pod special -o jsonpath="{.spec.schedulerName}{'\n'}"
kube-scheduler-special


➜ k -n kube-system logs kube-scheduler-special-cluster1-master1 | grep -i error
Error: unknown flag: --this-is-no-parameter
      --alsologtostderr                  log to standard error as well as files
      --logtostderr                      log to standard error instead of files (default true)

  ➜ ssh cluster1-master1
​
➜ root@cluster1-master1:~# vim /etc/kubernetes/manifests/kube-scheduler-special.yaml


apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: kube-scheduler-special
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-scheduler
    - --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
    - --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
    - --bind-address=127.0.0.1
    - --port=7776
    - --secure-port=7777
    #- --kubeconfig=/etc/kubernetes/kube-scheduler.conf          # wrong path
    - --kubeconfig=/etc/kubernetes/scheduler.conf                # correct path
    - --leader-elect=false
    - --scheduler-name=kube-scheduler-special         
    #- --this-is-no-parameter=what-the-hell
    image: k8s.gcr.io/kube-scheduler:v1.21.1
    


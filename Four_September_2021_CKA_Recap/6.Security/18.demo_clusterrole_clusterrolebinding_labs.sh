root@controlplane:~# kubectl  get clusterrole 
NAME                                                                   CREATED AT
admin                                                                  2021-09-23T10:29:16Z
cluster-admin                                                          2021-09-23T10:29:15Z
edit                                                                   2021-09-23T10:29:16Z
flannel                                                                2021-09-23T10:29:28Z
kubeadm:get-nodes                                                      2021-09-23T10:29:19Z
system:aggregate-to-admin                                              2021-09-23T10:29:16Z
system:aggregate-to-edit                                               2021-09-23T10:29:16Z
system:aggregate-to-view                                               2021-09-23T10:29:16Z
system:auth-delegator                                                  2021-09-23T10:29:16Z
system:basic-user                                                      2021-09-23T10:29:15Z
system:certificates.k8s.io:certificatesigningrequests:nodeclient       2021-09-23T10:29:16Z
system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   2021-09-23T10:29:16Z
system:certificates.k8s.io:kube-apiserver-client-approver              2021-09-23T10:29:16Z
system:certificates.k8s.io:kube-apiserver-client-kubelet-approver      2021-09-23T10:29:16Z
system:certificates.k8s.io:kubelet-serving-approver                    2021-09-23T10:29:16Z
system:certificates.k8s.io:legacy-unknown-approver                     2021-09-23T10:29:16Z
system:controller:attachdetach-controller                              2021-09-23T10:29:16Z
system:controller:certificate-controller                               2021-09-23T10:29:17Z
system:controller:clusterrole-aggregation-controller                   2021-09-23T10:29:16Z
system:controller:cronjob-controller                                   2021-09-23T10:29:16Z
system:controller:daemon-set-controller                                2021-09-23T10:29:16Z
system:controller:deployment-controller                                2021-09-23T10:29:16Z
system:controller:disruption-controller                                2021-09-23T10:29:16Z
system:controller:endpoint-controller                                  2021-09-23T10:29:16Z
system:controller:endpointslice-controller                             2021-09-23T10:29:16Z
system:controller:endpointslicemirroring-controller                    2021-09-23T10:29:16Z
system:controller:expand-controller                                    2021-09-23T10:29:16Z
system:controller:generic-garbage-collector                            2021-09-23T10:29:16Z
system:controller:horizontal-pod-autoscaler                            2021-09-23T10:29:16Z
system:controller:job-controller                                       2021-09-23T10:29:16Z
system:controller:namespace-controller                                 2021-09-23T10:29:16Z
system:controller:node-controller                                      2021-09-23T10:29:17Z
system:controller:persistent-volume-binder                             2021-09-23T10:29:17Z
system:controller:pod-garbage-collector                                2021-09-23T10:29:17Z
system:controller:pv-protection-controller                             2021-09-23T10:29:17Z
system:controller:pvc-protection-controller                            2021-09-23T10:29:17Z
system:controller:replicaset-controller                                2021-09-23T10:29:17Z
system:controller:replication-controller                               2021-09-23T10:29:17Z
system:controller:resourcequota-controller                             2021-09-23T10:29:17Z
system:controller:root-ca-cert-publisher                               2021-09-23T10:29:17Z
system:controller:route-controller                                     2021-09-23T10:29:17Z
system:controller:service-account-controller                           2021-09-23T10:29:17Z
system:controller:service-controller                                   2021-09-23T10:29:17Z
system:controller:statefulset-controller                               2021-09-23T10:29:17Z
system:controller:ttl-controller                                       2021-09-23T10:29:17Z
system:coredns                                                         2021-09-23T10:29:20Z
system:discovery                                                       2021-09-23T10:29:15Z
system:heapster                                                        2021-09-23T10:29:16Z
system:kube-aggregator                                                 2021-09-23T10:29:16Z
system:kube-controller-manager                                         2021-09-23T10:29:16Z
system:kube-dns                                                        2021-09-23T10:29:16Z
system:kube-scheduler                                                  2021-09-23T10:29:16Z
system:kubelet-api-admin                                               2021-09-23T10:29:16Z
system:monitoring                                                      2021-09-23T10:29:15Z
system:node                                                            2021-09-23T10:29:16Z
system:node-bootstrapper                                               2021-09-23T10:29:16Z
system:node-problem-detector                                           2021-09-23T10:29:16Z
system:node-proxier                                                    2021-09-23T10:29:16Z
system:persistent-volume-provisioner                                   2021-09-23T10:29:16Z
system:public-info-viewer                                              2021-09-23T10:29:15Z
system:service-account-issuer-discovery                                2021-09-23T10:29:16Z
system:volume-scheduler                                                2021-09-23T10:29:16Z
view                                                                   2021-09-23T10:29:16Z
root@controlplane:~# kubectl  get clusterrole  | wc -l
64
root@controlplane:~#



root@controlplane:~# kubectl get clusterrolebindings                           
NAME                                                   ROLE                                                                               AGE
cluster-admin                                          ClusterRole/cluster-admin                                                          4m9s
flannel                                                ClusterRole/flannel                                                                3m58s
kubeadm:get-nodes                                      ClusterRole/kubeadm:get-nodes                                                      4m7s
kubeadm:kubelet-bootstrap                              ClusterRole/system:node-bootstrapper                                               4m7s
kubeadm:node-autoapprove-bootstrap                     ClusterRole/system:certificates.k8s.io:certificatesigningrequests:nodeclient       4m7s
kubeadm:node-autoapprove-certificate-rotation          ClusterRole/system:certificates.k8s.io:certificatesigningrequests:selfnodeclient   4m7s
kubeadm:node-proxier                                   ClusterRole/system:node-proxier                                                    4m5s
system:basic-user                                      ClusterRole/system:basic-user                                                      4m9s
system:controller:attachdetach-controller              ClusterRole/system:controller:attachdetach-controller                              4m9s
system:controller:certificate-controller               ClusterRole/system:controller:certificate-controller                               4m8s
system:controller:clusterrole-aggregation-controller   ClusterRole/system:controller:clusterrole-aggregation-controller                   4m9s
system:controller:cronjob-controller                   ClusterRole/system:controller:cronjob-controller                                   4m9s
system:controller:daemon-set-controller                ClusterRole/system:controller:daemon-set-controller                                4m9s
system:controller:deployment-controller                ClusterRole/system:controller:deployment-controller                                4m9s
system:controller:disruption-controller                ClusterRole/system:controller:disruption-controller                                4m9s
system:controller:endpoint-controller                  ClusterRole/system:controller:endpoint-controller                                  4m9s
system:controller:endpointslice-controller             ClusterRole/system:controller:endpointslice-controller                             4m9s
system:controller:endpointslicemirroring-controller    ClusterRole/system:controller:endpointslicemirroring-controller                    4m9s
system:controller:expand-controller                    ClusterRole/system:controller:expand-controller                                    4m9s
system:controller:generic-garbage-collector            ClusterRole/system:controller:generic-garbage-collector                            4m9s
system:controller:horizontal-pod-autoscaler            ClusterRole/system:controller:horizontal-pod-autoscaler                            4m9s
system:controller:job-controller                       ClusterRole/system:controller:job-controller                                       4m9s
system:controller:namespace-controller                 ClusterRole/system:controller:namespace-controller                                 4m9s
system:controller:node-controller                      ClusterRole/system:controller:node-controller                                      4m9s
system:controller:persistent-volume-binder             ClusterRole/system:controller:persistent-volume-binder                             4m9s
system:controller:pod-garbage-collector                ClusterRole/system:controller:pod-garbage-collector                                4m8s
system:controller:pv-protection-controller             ClusterRole/system:controller:pv-protection-controller                             4m8s
system:controller:pvc-protection-controller            ClusterRole/system:controller:pvc-protection-controller                            4m8s
system:controller:replicaset-controller                ClusterRole/system:controller:replicaset-controller                                4m8s
system:controller:replication-controller               ClusterRole/system:controller:replication-controller                               4m8s
system:controller:resourcequota-controller             ClusterRole/system:controller:resourcequota-controller                             4m8s
system:controller:root-ca-cert-publisher               ClusterRole/system:controller:root-ca-cert-publisher                               4m8s
system:controller:route-controller                     ClusterRole/system:controller:route-controller                                     4m8s
system:controller:service-account-controller           ClusterRole/system:controller:service-account-controller                           4m8s
system:controller:service-controller                   ClusterRole/system:controller:service-controller                                   4m8s
system:controller:statefulset-controller               ClusterRole/system:controller:statefulset-controller                               4m8s
system:controller:ttl-controller                       ClusterRole/system:controller:ttl-controller                                       4m8s
system:coredns                                         ClusterRole/system:coredns                                                         4m6s
system:discovery                                       ClusterRole/system:discovery                                                       4m9s
system:kube-controller-manager                         ClusterRole/system:kube-controller-manager                                         4m9s
system:kube-dns                                        ClusterRole/system:kube-dns                                                        4m9s
system:kube-scheduler                                  ClusterRole/system:kube-scheduler                                                  4m9s
system:monitoring                                      ClusterRole/system:monitoring                                                      4m9s
system:node                                            ClusterRole/system:node                                                            4m9s
system:node-proxier                                    ClusterRole/system:node-proxier                                                    4m9s
system:public-info-viewer                              ClusterRole/system:public-info-viewer                                              4m9s
system:service-account-issuer-discovery                ClusterRole/system:service-account-issuer-discovery                                4m9s
system:volume-scheduler                                ClusterRole/system:volume-scheduler                                                4m9s
root@controlplane:~# kubectl get clusterrolebindings | wc -l
49
root@controlplane:~# 

root@controlplane:~# kubectl create clusterrole michelle-cluster-role --verb=create,list,delete --resource=nodes --dry-run=client -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: michelle-cluster-role
rules:
- apiGroups:
  - ""
  resources:
  - nodes
  verbs:
  - create
  - list
  - delete
root@controlplane:~# 

root@controlplane:~# kubectl create clusterrolebinding michelle-clusterbinding --clusterrole=michelle-cluster-admin --user=michelle --dry-run=client -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  creationTimestamp: null
  name: michelle-clusterbinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: michelle-cluster-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: michelle
root@controlplane:~# ls -rtlh
total 4.0K
-rw-rw-rw- 1 root root   0 Sep 14 01:32 sample.yaml
-rw-r--r-- 1 root root 201 Sep 23 10:40 michelle-cluster-roles.yaml
root@controlplane:~# vim michelle-cluster-roles.yaml 
root@controlplane:~# kubectl apply -f michelle-cluster-roles.yaml
clusterrole.rbac.authorization.k8s.io/michelle-cluster-role created
clusterrolebinding.rbac.authorization.k8s.io/michelle-clusterbinding created
root@controlplane:~# 


michelles responsibilities are growing and now she will be responsible for storage as well. 
Create the required ClusterRoles and ClusterRoleBindings to allow her access to Storage.

Get the API groups and resource names from command kubectl api-resources.

ClusterRole: storage-admin
Resource: persistentvolumes
Resource: storageclasses
ClusterRoleBinding: michelle-storage-admin
ClusterRoleBinding Subject: michelle
ClusterRoleBinding Role: storage-admin

Get the API groups and resource names from command kubectl api-resources. Use the given spec:

root@controlplane:~# kubectl api-resources --namespaced=false | grep -i storage
csidrivers                                     storage.k8s.io/v1                      false        CSIDriver
csinodes                                       storage.k8s.io/v1                      false        CSINode
storageclasses                    sc           storage.k8s.io/v1                      false        StorageClass
volumeattachments                              storage.k8s.io/v1                      false        VolumeAttachment
root@controlplane:~# kubectl api-resources --namespaced=false | grep -i volumes
persistentvolumes                 pv           v1                                     false        PersistentVolume
root@controlplane:~# 

root@controlplane:~# cat michelle-cluster.yaml 
---
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: storage-admin
rules:
- apiGroups: [""]
  resources: ["persistentvolumes"]
  verbs: ["get", "watch", "list", "create", "delete"]
- apiGroups: ["storage.k8s.io"]
  resources: ["storageclasses"]
  verbs: ["get", "watch", "list", "create", "delete"]

---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: michelle-storage-admin
subjects:
- kind: User
  name: michelle
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: storage-admin
  apiGroup: rbac.authorization.k8s.io
root@controlplane:~#


root@controlplane:~# vim michelle-cluster.yaml
root@controlplane:~# kubectl apply -f michelle-cluster.yaml
clusterrole.rbac.authorization.k8s.io/storage-admin created
clusterrolebinding.rbac.authorization.k8s.io/michelle-storage-admin created
root@controlplane:~# 


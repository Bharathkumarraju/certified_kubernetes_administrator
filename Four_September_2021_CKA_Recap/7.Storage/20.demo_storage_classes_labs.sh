root@controlplane:~# kubectl get sc  --all-namespaces
No resources found
root@controlplane:~#


root@controlplane:~# kubectl get sc  --all-namespaces
NAME                        PROVISIONER                     RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-storage               kubernetes.io/no-provisioner    Delete          WaitForFirstConsumer   false                  26s
portworx-io-priority-high   kubernetes.io/portworx-volume   Delete          Immediate              false                  26s
root@controlplane:~# kubectl describe sc local-storage
Name:            local-storage
IsDefaultClass:  No
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{},"name":"local-storage"},"provisioner":"kubernetes.io/no-provisioner","volumeBindingMode":"WaitForFirstConsumer"}

Provisioner:           kubernetes.io/no-provisioner
Parameters:            <none>
AllowVolumeExpansion:  <unset>
MountOptions:          <none>
ReclaimPolicy:         Delete
VolumeBindingMode:     WaitForFirstConsumer
Events:                <none>
root@controlplane:~# kubectl describe sc portworx-io-priority-high 
Name:            portworx-io-priority-high
IsDefaultClass:  No
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{},"name":"portworx-io-priority-high"},"parameters":{"priority_io":"high","repl":"1","snap_interval":"70"},"provisioner":"kubernetes.io/portworx-volume"}

Provisioner:           kubernetes.io/portworx-volume
Parameters:            priority_io=high,repl=1,snap_interval=70
AllowVolumeExpansion:  <unset>
MountOptions:          <none>
ReclaimPolicy:         Delete
VolumeBindingMode:     Immediate
Events:                <none>
root@controlplane:~# 


root@controlplane:~# kubectl get pv --all-namespaces
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    REASON   AGE
local-pv   500Mi      RWO            Retain           Available           local-storage            11m
root@controlplane:~#

root@controlplane:~# kubectl describe pv local-pv
Name:              local-pv
Labels:            <none>
Annotations:       <none>
Finalizers:        [kubernetes.io/pv-protection]
StorageClass:      local-storage
Status:            Available
Claim:             
Reclaim Policy:    Retain
Access Modes:      RWO
VolumeMode:        Filesystem
Capacity:          500Mi
Node Affinity:     
  Required Terms:  
    Term 0:        kubernetes.io/hostname in [controlplane]
Message:           
Source:
    Type:  LocalVolume (a persistent volume backed by local storage on a node)
    Path:  /opt/vol1
Events:    <none>
root@controlplane:~# 




Create a new PersistentVolumeClaim by the name of local-pvc that should bind to the volume local-pv.
Inspect the pv local-pv for the specs.

PVC: local-pvc
Correct Access Mode?
Correct StorageClass Used?
PVC requests volume size = 500Mi?

------------------------------------------------->

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-pvc
spec:
  storageClassName: local-storage
  volumeName: local-pv
  resources:
    requests:
      storage: 8Gi


------------------------------------------------->

root@controlplane:~# kubectl describe pvc local-pvc
Name:          local-pvc
Namespace:     default
StorageClass:  local-storage
Status:        Bound
Volume:        local-pv
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      500Mi
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       <none>
Events:        <none>
root@controlplane:~# 



MacBook-Pro:7.Storage bharathdasaraju$ kubectl run nginx --image=nginx --dry-run=client -o yaml > 22.pod_uses_local_storagePVC.yaml
MacBook-Pro:7.Storage bharathdasaraju$ 

root@controlplane:~# vim 22.pod_uses_local_storagePVC.yaml
root@controlplane:~# kubectl apply -f 22.pod_uses_local_storagePVC.yaml
pod/nginx created
root@controlplane:~# 


root@controlplane:~# kubectl get pvc
NAME        STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS    AGE
local-pvc   Bound    local-pv   500Mi      RWO            local-storage   11m
root@controlplane:~# 




Create a new Storage Class called delayed-volume-sc that makes use of the below specs:

provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer

apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: delayed-volume-sc
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
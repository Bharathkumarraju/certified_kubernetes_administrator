pv-definition.yaml:
-------------------------->
apiVersion:v1
kind: persistentVolume
metadata:
  name: pv-vol1
spec:
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 500Mi
  gcePersistentDisk:
    pdName: pd-disk 
    fsType: ext4 

the problem with above PV definition is that first we need to create a persistent Disk in GCP like below.
gcloud beta compute disks create --size 1GB --region asia-southeast1


We can automatically create volume in GCP dynamically using storage classes

dynamically provision disks in GCP using storage classes:
--------------------------------------------------------------->
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: google-storage
provisioner: kubernetes.io/gce-pd
parameters:
  type: pd-standard
  replication-type: none


With StorageClass is define we no-longer needed the PersitentVolumes.

In the PersistentVolumeClaim definition specify the StorageClass as below:
------------------------------------------------------------------------------->

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: myclaim
spec:
  accessModes:
    - ReadWriteMany
  storageClassName: google-storage
  resources:
    requests:
      storage: 500Mi


use PVC inside pod definition file:
------------------------------------------>
apiVersion: v1
kind: Pod
metadata:
  name: random-number-generator
spec:
  containers:
  - image: alpine
    name: alpine
    command: ["/bin/sh", "-c"]
    args: ["shuf -i 0-100 -n 1 >> /tmp/number.out"]
    volumeMounts:
    - mountPath: /opt
      name: data-volume
  volumes:
  - name: data-volume
    PersistentVolumeClaim:
      claimName: myclaim

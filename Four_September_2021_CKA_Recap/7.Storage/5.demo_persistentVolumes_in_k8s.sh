  volumes:
  - name: data-volume
    awsElasticBlockStore:
      volumeID: <volume_id>
      fsType: ext4

--------------------------------------------------------------------------------------------------->

A "PersistentVolumes(PVs)" is a cluster wide pool of storage volumes configured by an administrator, to be used in application deployed by users on the cluster.

users can now select storage from this PersistentVolumes using an object called "PersistentVolumeClaims(PVCs)"

"accessModes:"
--------------------->
ReadOnlyMany
ReadWriteOnce
ReadWriteMany




spec:
  capacity:
    storage: 2Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /tmp/data
  awsElasticBlockStore: <volume_id>
    fsType: ext4


"other options:"
------------------------->

  storageClassName: slow
  mountOptions:
    - hard
    - nfsvers=4.1
  nfs:
    path: /tmp
    server: 172.17.0.2



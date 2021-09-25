volumes in kubernetes

to persist data processed by the containers we attach volumes to containers when they are created.

attach volumes to pods in k8s:
--------------------------------------->

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
    hostPath:
      path: /Data
      type: Directory


Volume storage options....we can use hostPath  what if we have multi node cluster...in which host the Data directory creates.
for that we can NFS storage, EFS, EBS, google persistent disk, GlusterFS etc


if we want to use volume storage type as AWS EBS can as well.

  volumes:
  - name: data-volume
    awsElasticBlockStore:
      volumeID: <volume_id>
      fsType: ext4


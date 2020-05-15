So ETCD cluster stores information about the state of the cluster.

So information about the cluster itself.
i.e. the nodes and every other resource as created within the cluster are stored here.
so instead of backing up resources as before, we can backup the ETCD Server itself.

So As we have seen ETCD Cluster is hosted on the master nodes.
While configuring ETCD we specified a location(/var/lib/etcd) were all the data  would be stored.
The data directory. That is the directory that can be configured to be backup by our backup tool.

etcd.service:
------------->
ExecStart=/use/local/bin/etcd \\
    --name ${ETCD_NAME} \\
    ...
    ...
    --data-dir=/var/lib/etcd

ETCD also comes with a built in snapshot solution.
So you can take a snapshot of the ETCD database by using the etcdctl utility snapshot save command.

$ ETCDCTL_API=3 etcdctl snapshot save snapshot.db

A sanpshot file is created in the name of "snapshot.db" is created in the current directory.

$ ETCDCTL_API=3 etcdctl snapshot save $HOME/snapshot.db

status:
-------->
$ ETCDCTL_API=3 etcdctl snapshot status $HOME/snapshot.db

HOW TO RESTORE ETCD CLUSTER FROM ETCD SNAPSHOT:
--------------------------------------------------------->
Step1: First stop the kube-apisever service as the restore process will require you to restart the ETCD
$ service kube-apiserver stop

Stpe2: Then run the etcdctl snapshot restore command. When ETCD restores from a backup
it initializes a new cluster configuration and configures the members of ETCD as a new memebers to a new cluster.
This is to prevent a new member from accidentally joining an existing cluster.

Say for example, we use this backup snapshot to provision a new etcd-cluster for testing purposes,
and you dont want the memebers in the new test cluster to accidentally join the production cluster.

So during a restore we must specify a new cluster token and same initial cluster configuration.
on running the below command a new data directory is created i.e. "/var/lib/etcd-from-backup"
We then configure the etcd.service to use new cluster token and data directory and reload the service daemon.

$ ETCDCTL_API=3 etcdctl snapshot restore snapshot.db \
    --data-dir /var/lib/etcd-from-backup \
    --initial-cluster master-1=https://192.168.5.11:2380,master-2=https://192.168.5.12:2380 \
    --initial-cluster-token etcd-cluster-1 \
    --initial-advertise-peer-urls https://${INTERNAL_IP}:2380

etcd.service:
-------------->
ExecStart=/usr/local/bin/etcd \\
   --name ${ETCD_NAME} \\
   ...
   ...
   --initial-cluster-token etcd-cluster-1
   --data-dir=/var/lib/etcd-from-backup

systemctl daemon-reload
service etcd restart (or) systemctl restart etcd.service

And now start the kube-apiserver as well
service kube-apiserver start

For all the etcdctl command remember to specify the certificate files for authentication
1. specify the endpoint to the ETCD cluster
2. Specify the ca certificate
3. specify the etcd-server certificate
4. specify the key

$ ETCDCTL_API=3 etcdctl \
   sanpshot save sanpshot.db \
   --endpoints=https://127.0.0.1:2379 \
   --cacert=/etc/etcd/ca.cert \
   --cert=/etc/etcd/etcs-server.cert \
   --key=/etc/etcd/etcd.server.key



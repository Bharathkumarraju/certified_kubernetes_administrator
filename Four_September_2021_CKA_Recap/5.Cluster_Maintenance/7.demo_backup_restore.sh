what to backup in k8s cluster

1. Resource configuration.
2. Etcd cluster.
3. Persistent storage of the application.


Get all resource configuration:
----------------------------------->
kubectl get all --all-namespaces -o yaml > all-deploy-services.yaml
there are tools for this like velero to backup



Backup etcd cluster:
------------------------->
etcd.service:  --data-dir=/var/lib/etcd  we can backup this directory

etcd by default comes with "snapshot" option.
1. ETCDCTL_API=3 etcdctl snapshot save snapshot.db


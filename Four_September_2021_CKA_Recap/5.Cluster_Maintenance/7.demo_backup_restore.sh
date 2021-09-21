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


MacBook-Pro:Four_September_2021_CKA_Recap bharathdasaraju$ kubectl exec etcd-minikube -n kube-system -- etcdctl --endpoints https://192.168.49.2:2379 --cacert /var/lib/minikube/certs/etcd/ca.crt --cert /var/lib/minikube/certs/etcd/server.crt --key /var/lib/minikube/certs/etcd/server.key snapshot save snapshot.db
{"level":"info","ts":1632264347.5080614,"caller":"snapshot/v3_snapshot.go:119","msg":"created temporary db file","path":"snapshot.db.part"}
{"level":"info","ts":"2021-09-21T22:45:47.532Z","caller":"clientv3/maintenance.go:200","msg":"opened snapshot stream; downloading"}
{"level":"info","ts":1632264347.5378127,"caller":"snapshot/v3_snapshot.go:127","msg":"fetching snapshot","endpoint":"https://192.168.49.2:2379"}
{"level":"info","ts":"2021-09-21T22:45:47.669Z","caller":"clientv3/maintenance.go:208","msg":"completed snapshot read; closing"}
{"level":"info","ts":1632264347.6795833,"caller":"snapshot/v3_snapshot.go:142","msg":"fetched snapshot","endpoint":"https://192.168.49.2:2379","size":"3.0 MB","took":0.1696802}
{"level":"info","ts":1632264347.6797824,"caller":"snapshot/v3_snapshot.go:152","msg":"saved","path":"snapshot.db"}
Snapshot saved at snapshot.db
MacBook-Pro:Four_September_2021_CKA_Recap bharathdasaraju$

MacBook-Pro:Four_September_2021_CKA_Recap bharathdasaraju$ kubectl exec etcd-minikube -n kube-system -- etcdctl --endpoints https://192.168.49.2:2379 --cacert /var/lib/minikube/certs/etcd/ca.crt --cert /var/lib/minikube/certs/etcd/server.crt --key /var/lib/minikube/certs/etcd/server.key snapshot status snapshot.db
52a22ad4, 119706, 821, 3.0 MB
MacBook-Pro:Four_September_2021_CKA_Recap bharathdasaraju$ 


How to restore etcd from backup:
------------------------------------------------------>
1. stop kube-apiserver --> service kube-apiserver stop
2. Restore from backup --> ETCDCTL_API=3 etcdctl snapshot restore snapshot.db --data-dir /var/lib/etcd-from-backup
3. and configure this new data directory in etcd.service as --data-dir=/var/lib/etcd-from-backup
4. systemctl daemon-reload
5. service etcd restart 
6. service kube-apiserver start 


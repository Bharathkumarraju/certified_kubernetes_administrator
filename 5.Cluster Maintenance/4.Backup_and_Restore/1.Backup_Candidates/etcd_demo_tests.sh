Question:
--------->

The master nodes in our cluster are planned for a regular maintenance reboot tonight.
 While we do not anticipate anything to go wrong, we are required to take the necessary backups.
 Take a snapshot of the ETCD database using the built-in snapshot functionality.

Store the backup file at location /tmp/snapshot-pre-boot.db

master $ ETCDCTL_API=3 etcdctl snapshot save /tmp/snapshot-pre-boot.db --endpoints=https://[127.0.0.1]:2379 --cacert="/etc/kubernetes/pki/etcd/ca.crt" --cert="/etc/kubernetes/pki/etcd/server.crt" --key="/etc/kubernetes/pki/etcd/server.key"
Snapshot saved at /tmp/snapshot-pre-boot.db
master $

Restore:
--------->

$ ETCDCTL_API=3 etcdctl \
       --data-dir /var/lib/etcd-from-backup \
       --initial-advertise-peer-urls=https://127.0.0.1:2380 \
       --initial-cluster=master=https://127.0.0.1:2380 \
       --initial-cluster-token=etcd-cluster-1 \
       --name=master \
       --endpoints=https://[127.0.0.1]:2379 \
       --cacert=/etc/kubernetes/pki/etcd/ca.crt \
       --cert=/etc/kubernetes/pki/etcd/server.crt \
       --key=/etc/kubernetes/pki/etcd/server.key \
       snapshot restore /tmp/snapshot-pre-boot.db

master $ ETCDCTL_API=3 etcdctl \
>        --data-dir /var/lib/etcd-from-backup \
>        --initial-advertise-peer-urls=https://127.0.0.1:2380 \
>        --initial-cluster=master=https://127.0.0.1:2380 \
>        --initial-cluster-token=etcd-cluster-1 \
>        --name=master \
>        --endpoints=https://[127.0.0.1]:2379 \
>        --cacert=/etc/kubernetes/pki/etcd/ca.crt \
>        --cert=/etc/kubernetes/pki/etcd/server.crt \
>        --key=/etc/kubernetes/pki/etcd/server.key \
>        snapshot restore /tmp/snapshot-pre-boot.db
2020-05-15 03:23:52.161993 I | mvcc: restore compact to 4156
2020-05-15 03:23:52.170825 I | etcdserver/membership: added member e92d66acd89ecf29 [https://127.0.0.1:2380] to cluster 7581d6eb2d25405b
master $

After restore go to path  /etc/kubernetes/manifests and update etcd.yaml to use new backup dir and initial-cluster-token and MountPath.
check file: updated_etcd.yaml file :)
master $ pwd
/etc/kubernetes/manifests
master $


aster $ docker ps | grep -i etcd
6fec39b08bf4        b2756210eeab           "etcd --advertise-cl…"   8 seconds ago       Up 7 seconds                            k8s_etcd_etcd-master_kube-system_e2252efe4cc1e78db86bd19c41610fb0_0
bbe0b512944c        k8s.gcr.io/pause:3.1   "/pause"                 27 seconds ago      Up 26 seconds                           k8s_POD_etcd-master_kube-system_e2252efe4cc1e78db86bd19c41610fb0_0

master $ docker ps | grep -i etcd
6fec39b08bf4        b2756210eeab           "etcd --advertise-cl…"   18 seconds ago      Up 17 seconds                           k8s_etcd_etcd-master_kube-system_e2252efe4cc1e78db86bd19c41610fb0_0
bbe0b512944c        k8s.gcr.io/pause:3.1   "/pause"                 37 seconds ago      Up 37 seconds                           k8s_POD_etcd-master_kube-system_e2252efe4cc1e78db86bd19c41610fb0_0

master $ kubectl get all
NAME                        READY   STATUS    RESTARTS   AGEpod/blue-68df9fb9d9-92blt   1/1     Running   0          36m
pod/blue-68df9fb9d9-lg756   1/1     Running   0          36mpod/blue-68df9fb9d9-zx26j   1/1     Running   0          36m
pod/red-5dc59c9654-px9q8    1/1     Running   0          36mpod/red-5dc59c9654-thjv7    1/1     Running   0          36m
NAME                   TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/blue-service   NodePort    10.102.152.121   <none>        80:30082/TCP   36m
service/kubernetes     ClusterIP   10.96.0.1        <none>        443/TCP        65mservice/red-service    NodePort    10.101.96.58     <none>        80:30080/TCP   36m

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/blue   3/3     3            3           36m
deployment.apps/red    2/2     2            2           36m

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/blue-68df9fb9d9   3         3         3       36m
replicaset.apps/red-5dc59c9654    2         2         2       36m
master $



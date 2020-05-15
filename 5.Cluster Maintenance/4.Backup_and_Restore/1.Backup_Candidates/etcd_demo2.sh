At what address do you reach the ETCD cluster from your master node?

Check the ETCD Service configuration in the ETCD POD
kubectl describe pod etcd-master -n kube-system and look for --listen-client-urls

master $ kubectl describe pod  etcd-master -n kube-system | grep "client-urls"
      --advertise-client-urls=https://172.17.0.36:2379
      --listen-client-urls=https://127.0.0.1:2379,https://172.17.0.36:2379
master $

---------------------------------------------------------------------------------->

Command:
      etcd
      --advertise-client-urls=https://172.17.0.36:2379
      --cert-file=/etc/kubernetes/pki/etcd/server.crt
      --client-cert-auth=true
      --data-dir=/var/lib/etcd
      --initial-advertise-peer-urls=https://172.17.0.36:2380
      --initial-cluster=master=https://172.17.0.36:2380
      --key-file=/etc/kubernetes/pki/etcd/server.key
      --listen-client-urls=https://127.0.0.1:2379,https://172.17.0.36:2379
      --listen-metrics-urls=http://127.0.0.1:2381
      --listen-peer-urls=https://172.17.0.36:2380
      --name=master
      --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
      --peer-client-cert-auth=true
      --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
      --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
      --snapshot-count=10000
      --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt

Question:
----------->
The master nodes in our cluster are planned for a regular maintenance reboot tonight.
While we do not anticipate anything to go wrong, we are required to take the necessary backups.
Take a snapshot of the ETCD database using the built-in snapshot functionality.

Store the backup file at location /tmp/snapshot-pre-boot.db
Backup ETCD to /tmp/snapshot-pre-boot.db
Name: ingress-space


$ ETCDCTL_API=3 etcdctl \
    --endpoints=https://[127.0.0.1]:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
     snapshot save /tmp/snapshot-pre-boot.db

master $ ETCDCTL_API=3 etcdctl \
     --endpoints=https://[127.0.0.1]:2379 \
     --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt \
     --key=/etc/kubernetes/pki/etcd/server.key \
      snapshot save /tmp/snapshot-pre-boot.db
Snapshot saved at /tmp/snapshot-pre-boot.db
master $

master $ ETCDCTL_API=3 etcdctl \
     --endpoints=https://[127.0.0.1]:2379  \
     --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt \
     --key=/etc/kubernetes/pki/etcd/server.key \
     snapshot status /tmp/snapshot-pre-boot.db
41a95567, 4434, 1077, 1.9 MB
master $

------------------------------------------------------------------>
Luckily we took a backup. Restore the original state of the cluster using the backup file.

ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --name=master \
     --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
     --data-dir /var/lib/etcd-from-backup \
     --initial-cluster=master=https://127.0.0.1:2380 \
     --initial-cluster-token etcd-cluster-1 \
     --initial-advertise-peer-urls=https://127.0.0.1:2380 \
     snapshot restore /tmp/snapshot-pre-boot.db

master $ ETCDCTL_API=3 etcdctl --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt \
>      --name=master \
>      --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key \
>      --data-dir /var/lib/etcd-from-backup \
>      --initial-cluster=master=https://127.0.0.1:2380 \
>      --initial-cluster-token etcd-cluster-1 \
>      --initial-advertise-peer-urls=https://127.0.0.1:2380 \
>      snapshot restore /tmp/snapshot-pre-boot.db
2020-05-15 02:10:30.896194 I | mvcc: restore compact to 3756
2020-05-15 02:10:30.905375 I | etcdserver/membership: added member e92d66acd89ecf29 [https://127.0.0.1:2380] to cluster 7581d6eb2d25405b
master $



master $ ETCDCTL_API=3 etcdctl member list --endpoints=https://[127.0.0.1]:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt  --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key
8aba5a637b74ac43, started, master, https://172.17.0.36:2380, https://172.17.0.36:2379
master $

===============================================================================================================================>

master $ ETCDCTL_API=3 etcdctl snapshot save -h
NAME:
        snapshot save - Stores an etcd node backend snapshot to a given file

USAGE:
        etcdctl snapshot save <filename>

GLOBAL OPTIONS:
      --cacert=""                               verify certificates of TLS-enabled secure servers using this CA bundle
      --cert=""                                 identify secure client using this TLS certificate file
      --command-timeout=5s                      timeout for short running command (excluding dial timeout)
      --debug[=false]                           enable client-side debug logging
      --dial-timeout=2s                         dial timeout for client connections
  -d, --discovery-srv=""                        domain name to query for SRV records describing cluster endpoints
      --endpoints=[127.0.0.1:2379]              gRPC endpoints
      --hex[=false]                             print byte strings as hex encoded strings
      --insecure-discovery[=true]               accept insecure SRV records describing cluster endpoints
      --insecure-skip-tls-verify[=false]        skip server certificate verification
      --insecure-transport[=true]               disable transport security for client connections
      --keepalive-time=2s                       keepalive time for client connections      --keepalive-timeout=6s                    keepalive timeout for client connections
      --key=""                                  identify secure client using this TLS key file
      --user=""                                 username[:password] for authentication (prompt if password is not supplied)
  -w, --write-out="simple"                      set the output format (fields, json, protobuf, simple, table)
master $

master $ ETCDCTL_API=3 etcdctl \
     --endpoints=https://[127.0.0.1]:2379  \
     --cacert=/etc/kubernetes/pki/etcd/ca.crt \
     --cert=/etc/kubernetes/pki/etcd/server.crt \
     --key=/etc/kubernetes/pki/etcd/server.key \
     snapshot status /tmp/snapshot-pre-boot.db
41a95567, 4434, 1077, 1.9 MB
master $

==================================================================================================================================>

master $ ETCDCTL_API=3 etcdctl snapshot restore  -h
NAME:
        snapshot restore - Restores an etcd member snapshot to an etcd directory

USAGE:
        etcdctl snapshot restore <filename> [options]

OPTIONS:
      --data-dir=""                                             Path to the data directory
      --initial-advertise-peer-urls=\"http://localhost:2380"     List of this member's peer URLs to advertise to the rest of the cluster
      --initial-cluster="default=http://localhost:2380"         Initial cluster configuration for restore bootstrap
      --initial-cluster-token="etcd-cluster"                    Initial cluster token for the etcd cluster during restore bootstrap
      --name="default"                                          Human-readable name for this member
      --skip-hash-check[=false]                                 Ignore snapshot integrity hash value (required if copied from data directory)
      --wal-dir=""                                              Path to the WAL directory (use --data-dir if none given)

GLOBAL OPTIONS:
      --cacert=""                               verify certificates of TLS-enabled secure servers using this CA bundle
      --cert=""                                 identify secure client using this TLS certificate file
      --command-timeout=5s                      timeout for short running command (excluding dial timeout)
      --debug[=false]                           enable client-side debug logging
      --dial-timeout=2s                         dial timeout for client connections
  -d, --discovery-srv=""                        domain name to query for SRV records describing cluster endpoints
      --endpoints=[127.0.0.1:2379]              gRPC endpoints
      --hex[=false]                             print byte strings as hex encoded strings
      --insecure-discovery[=true]               accept insecure SRV records describing cluster endpoints
      --insecure-skip-tls-verify[=false]        skip server certificate verification
      --insecure-transport[=true]               disable transport security for client connections
      --keepalive-time=2s                       keepalive time for client connections
      --keepalive-timeout=6s                    keepalive timeout for client connections
      --key=""                                  identify secure client using this TLS key file
      --user=""                                 username[:password] for authentication (prompt if password is not supplied)
  -w, --write-out=\"simple"                      set the output format (fields, json, protobuf, simple, table)

master $


Restore the original state of the cluster using the backup file.

master $ ETCDCTL_API=3 etcdctl
>      --endpoints=https://[127.0.0.1]:2379 \
>      --cacert=/etc/kubernetes/pki/etcd/ca.crt \
>      --cert=/etc/kubernetes/pki/etcd/server.crt \
>      --key=/etc/kubernetes/pki/etcd/server.key \
>      --name=master \
>      --data-dir /var/lib/etcd-from-backup \
>      --initial-cluster=master=https://127.0.0.1:2380 \
>      --initial-cluster-token etcd-cluster-1 \
>      --initial-advertise-peer-urls=https://127.0.0.1:2380 \
>      snapshot restore /tmp/snapshot-pre-boot.db
2020-05-15 02:10:30.896194 I | mvcc: restore compact to 3756
2020-05-15 02:10:30.905375 I | etcdserver/membership: added member e92d66acd89ecf29 [https://127.0.0.1:2380] to cluster 7581d6eb2d25405b
master $


=====================================================================AFTER RESTORE STEPS ==================================================

After the restore we have go to static pod definition files and update the etcd.yaml
with new --data-dir( /var/lib/etcd-from-backup) and
with new --initial-cluster-token(etcd-cluster-1) and
with new mountPath: /var/lib/etcd-from-backup

chech the path /etc/kubernetes/manifests/etcd.yaml


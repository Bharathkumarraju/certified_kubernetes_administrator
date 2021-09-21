root@controlplane:~# kubectl get all
NAME                        READY   STATUS    RESTARTS   AGE
pod/blue-746c87566d-6bdmd   1/1     Running   0          35s
pod/blue-746c87566d-757lx   1/1     Running   0          34s
pod/blue-746c87566d-rt6sn   1/1     Running   0          34s
pod/red-75f847bf79-ktzcc    1/1     Running   0          35s
pod/red-75f847bf79-phdd7    1/1     Running   0          35s

NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/blue-service   NodePort    10.111.50.175   <none>        80:30082/TCP   35s
service/kubernetes     ClusterIP   10.96.0.1       <none>        443/TCP        10m
service/red-service    NodePort    10.100.207.17   <none>        80:30080/TCP   35s

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/blue   3/3     3            3           35s
deployment.apps/red    2/2     2            2           35s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/blue-746c87566d   3         3         3       35s
replicaset.apps/red-75f847bf79    2         2         2       35s
root@controlplane:~# 


root@controlplane:~# ps -eaf | grep -i "etcd "
root      3998  3888  0 22:46 ?        00:00:22 etcd --advertise-client-urls=https://10.57.35.3:2379 --cert-file=/etc/kubernetes/pki/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/etcd --initial-advertise-peer-urls=https://10.57.35.3:2380 --initial-cluster=controlplane=https://10.57.35.3:2380 --key-file=/etc/kubernetes/pki/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://10.57.35.3:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://10.57.35.3:2380 --name=controlplane --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/etc/kubernetes/pki/etcd/peer.key --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt --snapshot-count=10000 --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
root     15626 12165  0 22:57 pts/0    00:00:00 grep --color=auto -i etcd 
root@controlplane:~# 

root@controlplane:~# kubectl logs etcd-controlplane -n kube-system | grep -i "version"
2021-09-21 22:46:41.918478 I | etcdmain: etcd Version: 3.4.13
2021-09-21 22:46:41.918578 I | etcdmain: Go Version: go1.12.17
2021-09-21 22:46:42.217126 I | etcdserver: starting server... [version: 3.4.13, cluster version: to_be_decided]
2021-09-21 22:46:42.407653 I | etcdserver: setting up the initial cluster version to 3.4
2021-09-21 22:46:42.407968 N | etcdserver/membership: set the initial cluster version to 3.4
2021-09-21 22:46:42.408282 I | etcdserver/api: enabled capabilities for version 3.4
root@controlplane:~# kubectl describe pod etcd-controlplane -n kube-system | grep -i version
root@controlplane:~# kubectl describe pod etcd-controlplane -n kube-system | grep -i image  
    Image:         k8s.gcr.io/etcd:3.4.13-0
    Image ID:      docker-pullable://k8s.gcr.io/etcd@sha256:4ad90a11b55313b182afc186b9876c8e891531b8db4c9bf1541953021618d0e2
root@controlplane:~# 


etcd:
--cert=/etc/kubernetes/pki/etcd/server.crt
--cacert=/etc/kubernetes/pki/etcd/ca.crt
--key=/etc/kubernetes/pki/etcd/server.key

Backup etcd cluster:
------------------------>
root@controlplane:/etc/kubernetes/pki/etcd# ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
> --cert=/etc/kubernetes/pki/etcd/server.crt --cacert=/etc/kubernetes/pki/etcd/ca.crt \
> --key=/etc/kubernetes/pki/etcd/server.key snapshot save /opt/snapshot-pre-boot.db
Snapshot saved at /opt/snapshot-pre-boot.db
root@controlplane:/etc/kubernetes/pki/etcd#


root@controlplane:/etc/kubernetes/pki/etcd# ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cert=/etc/kubernetes/pki/etcd/server.crt --cacert=/etc/kubernetes/pki/etcd/ca.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot status /opt/snapshot-pre-boot.db
40896334, 2161, 916, 2.2 MB
root@controlplane:/etc/kubernetes/pki/etcd# 



restore etcd cluster:
------------------------>

root@controlplane:~# ETCDCTL_API=3 etcdctl snapshot restore /opt/snapshot-pre-boot.db --data-dir /var/lib/etcd-from-backup
2021-09-21 23:15:35.337656 I | mvcc: restore compact to 1646
2021-09-21 23:15:35.350165 I | etcdserver/membership: added member 8e9e05c52164694d [http://localhost:2380] to cluster cdf818194e3a8c32
root@controlplane:~# 


Next, update the /etc/kubernetes/manifests/etcd.yaml to use new --data-dir as  /var/lib/etcd-from-backup



=============================================================================================================================================================>

First Restore the snapshot:

root@controlplane:~# ETCDCTL_API=3 etcdctl  --data-dir /var/lib/etcd-from-backup \
snapshot restore /opt/snapshot-pre-boot.db


2021-03-25 23:52:59.608547 I | mvcc: restore compact to 6466
2021-03-25 23:52:59.621400 I | etcdserver/membership: added member 8e9e05c52164694d [http://localhost:2380] to cluster cdf818194e3a8c32
root@controlplane:~# 
Note: In this case, we are restoring the snapshot to a different directory but in the same server where we took the backup (the controlplane node) 
As a result, the only required option for the restore command is the --data-dir.


Next, update the /etc/kubernetes/manifests/etcd.yaml:

We have now restored the etcd snapshot to a new path on the controlplane - /var/lib/etcd-from-backup, 
so, the only change to be made in the YAML file, is to change the hostPath for the volume called etcd-data from old directory (/var/lib/etcd) to the new directory /var/lib/etcd-from-backup.

have to update both in hostpaths and volumeMounts

    volumeMounts:
    - mountPath: /var/lib/etcd-from-backup
      name: etcd-data
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  hostNetwork: true
  priorityClassName: system-node-critical
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd-from-backup
      type: DirectoryOrCreate
    name: etcd-data


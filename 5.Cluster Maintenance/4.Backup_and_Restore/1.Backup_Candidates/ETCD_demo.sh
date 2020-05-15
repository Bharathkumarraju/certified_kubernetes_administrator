$ export ETCDCTL_API=3

$ etcdctl snapshot save -h
Since our ETCD database is TLS-Enabled, the following options are mandatory:
1. --cacert  --> verify certificates of TLS-enabled secure servers using this CA bundle.
2. --cert  --> identify secure client using this TLS certificate file.
3. --endpoints=[127.0.0.1:2379]  --> This is the default as ETCD is running on master node and exposed on localhost 2379.
4. --key  -->  identify secure client using this TLS key file

------------------------------------------------------------------->

master $ kubectl get pods --all-namespaces | egrep "(NAMESPACE|etcd)"
NAMESPACE     NAME                             READY   STATUS    RESTARTS   AGE
kube-system   etcd-master                      1/1     Running   0          27m
master $

master $ kubectl exec -it etcd-master sh -n kube-system
#
# etcdctl --version
etcdctl version: 3.3.15
API version: 2
#

------------------------------------------------------------------------------------>
master $ kubectl logs etcd-master -n kube-system| head2020-05-15 01:11:37.127032 I | etcdmain: etcd Version: 3.3.15
2020-05-15 01:11:37.128034 I | etcdmain: Git SHA: 94745a4ee
2020-05-15 01:11:37.128236 I | etcdmain: Go Version: go1.12.9
2020-05-15 01:11:37.128472 I | etcdmain: Go OS/Arch: linux/amd64
2020-05-15 01:11:37.128519 I | etcdmain: setting maximum number of CPUs to 2, total number of available CPUs is 2
2020-05-15 01:11:37.128831 I | embed: peerTLS: cert = /etc/kubernetes/pki/etcd/peer.crt, key = /etc/kubernetes/pki/etcd/peer.key, ca = , trusted-ca = /etc/kubernetes/pki/etcd/ca.crt, client-cert-auth = true, crl-file =
2020-05-15 01:11:37.133936 I | embed: listening for peers on https://172.17.0.36:2380
2020-05-15 01:11:37.135903 I | embed: listening for client requests on 127.0.0.1:2379
2020-05-15 01:11:37.141114 I | embed: listening for client requests on 172.17.0.36:23792020-05-15 01:11:37.150326 I | etcdserver: name = master
master $

----------------------------------------------------------------------------------------->

master $ kubectl describe pod  etcd-master -n kube-systemName:                 etcd-master
Namespace:            kube-system
Priority:             2000000000
Priority Class Name:  system-cluster-criticalNode:                 master/172.17.0.36Start Time:           Fri, 15 May 2020 01:11:35 +0000Labels:               component=etcd
                      tier=control-planeAnnotations:          kubernetes.io/config.hash: 53a993950d7c7b3112c753cc8f233025
                      kubernetes.io/config.mirror: 53a993950d7c7b3112c753cc8f233025
                      kubernetes.io/config.seen: 2020-05-15T01:11:32.143757159Z
                      kubernetes.io/config.source: file
Status:               Running
IP:                   172.17.0.36
IPs:
  IP:  172.17.0.36
Containers:
  etcd:
    Container ID:  docker://445849679ebe52ba9e3296fd57b68e7fcbb0c8d5ac1d48e1538f61a783d3e2f2
    Image:         k8s.gcr.io/etcd:3.3.15-0
    Image ID:      docker-pullable://k8s.gcr.io/etcd@sha256:12c2c5e5731c3bcd56e6f1c05c0f9198b6f06793fa7fca2fb43aab9622dc4afa
    Port:          <none>
    Host Port:     <none>
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
    State:          Running
      Started:      Fri, 15 May 2020 01:11:36 +0000
    Ready:          True
    Restart Count:  0
    Liveness:       http-get http://127.0.0.1:2381/health delay=15s timeout=15s period=10s #success=1 #failure=8
    Environment:    <none>
    Mounts:
      /etc/kubernetes/pki/etcd from etcd-certs (rw)
      /var/lib/etcd from etcd-data (rw)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  etcd-certs:
    Type:          HostPath (bare host directory volume)
    Path:          /etc/kubernetes/pki/etcd
    HostPathType:  DirectoryOrCreate
  etcd-data:
    Type:          HostPath (bare host directory volume)
    Path:          /var/lib/etcd
    HostPathType:  DirectoryOrCreate
QoS Class:         BestEffort
Node-Selectors:    <none>
Tolerations:       :NoExecute
Events:
  Type    Reason   Age   From             Message
  ----    ------   ----  ----             -------
  Normal  Pulled   36m   kubelet, master  Container image "k8s.gcr.io/etcd:3.3.15-0" already present on machine
  Normal  Created  36m   kubelet, master  Created container etcd
  Normal  Started  36m   kubelet, master  Started container etcd
master $
------------------------------------------------------------------------->
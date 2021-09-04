Kubelet registers the nodes with the cluster.


bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ docker ps
CONTAINER ID        IMAGE                                 COMMAND                  CREATED             STATUS              PORTS                                                                                                                                  NAMES
8271f1c15e16        gcr.io/k8s-minikube/kicbase:v0.0.22   "/usr/local/bin/entr…"   2 hours ago         Up 2 hours          127.0.0.1:32777->22/tcp, 127.0.0.1:32776->2376/tcp, 127.0.0.1:32775->5000/tcp, 127.0.0.1:32774->8443/tcp, 127.0.0.1:32773->32443/tcp   minikube
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ docker exec -it 8271f1c15e16 bash
root@minikube:/# 

root@minikube:/# ps auxwww
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.5  21948 11316 ?        Ss   06:54   0:01 /sbin/init
root         176  0.0  0.4  26944  8828 ?        S<s  06:54   0:00 /lib/systemd/systemd-journald
message+     188  0.0  0.1   7004  3744 ?        Ss   06:54   0:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         191  0.3  2.4 899352 49904 ?        Ssl  06:54   0:22 /usr/bin/containerd
root         198  0.0  0.3  12176  7272 ?        Ss   06:54   0:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root         211  3.4  5.2 1332080 106076 ?      Ssl  06:54   3:23 /usr/bin/dockerd -H tcp://0.0.0.0:2376 -H unix:///var/run/docker.sock --default-ulimit=nofile=1048576:1048576 --tlsverify --tlscacert /etc/docker/ca.pem --tlscert /etc/docker/server.pem --tlskey /etc/docker/server-key.pem --label provider=docker --insecure-registry 10.96.0.0/12
root         852 13.0  5.1 1853424 103888 ?      Ssl  06:54  12:40 /var/lib/minikube/binaries/v1.20.2/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime=docker --hostname-override=minikube --kubeconfig=/etc/kubernetes/kubelet.conf --node-ip=192.168.49.2
root        1380  0.0  0.3 113116  7376 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 0521ed07a4bc29e48c4ae345375861a9c7ce679cc00a3a6aaec2de20a55c5ac1 -address /run/containerd/containerd.sock
root        1413  0.0  0.3 111708  8032 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id be68ef7cc6eadc76b69492d4a5b5d737b20071358843a2547ecadd60091c0c44 -address /run/containerd/containerd.sock
root        1459  0.0  0.0    964     4 ?        Ss   06:54   0:00 /pause
root        1484  0.0  0.3 113372  8008 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 76c11b9d89f8c80fe78fba4e4765874f29918bb167eab657e318df429799871c -address /run/containerd/containerd.sock
root        1492  0.0  0.0    964     4 ?        Ss   06:54   0:00 /pause
root        1553  0.0  0.0    964     4 ?        Ss   06:54   0:00 /pause
root        1573  0.0  0.4 113116  8152 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 2670ae8640aed0b9856a3a4d3c7d3dc5077da3db73807378ad2ddc948607e6c7 -address /run/containerd/containerd.sock
root        1614  0.0  0.0    964     4 ?        Ss   06:54   0:00 /pause
root        1651  0.0  0.4 113372  8256 ?        Sl   06:54   0:01 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 43d8dfc0dbd698df1be1f870147100cd66932cd15595ebdebf44d94863818a27 -address /run/containerd/containerd.sock
root        1689  0.0  0.3 113372  8128 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 66439383eeb9ffb1f38dbea9b75d618988f48e0e98dca7bbc65e0484599a372b -address /run/containerd/containerd.sock
root        1708  4.9  2.6 10612468 54272 ?      Ssl  06:54   4:46 etcd --advertise-client-urls=https://192.168.49.2:2379 --cert-file=/var/lib/minikube/certs/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/minikube/etcd --initial-advertise-peer-urls=https://192.168.49.2:2380 --initial-cluster=minikube=https://192.168.49.2:2380 --key-file=/var/lib/minikube/certs/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://192.168.49.2:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://192.168.49.2:2380 --name=minikube --peer-cert-file=/var/lib/minikube/certs/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/var/lib/minikube/certs/etcd/peer.key --peer-trusted-ca-file=/var/lib/minikube/certs/etcd/ca.crt --proxy-refresh-interval=70000 --snapshot-count=10000 --trusted-ca-file=/var/lib/minikube/certs/etcd/ca.crt
root        1747  0.0  0.3 113372  6828 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 230087c66fbdab6719efad402a52e2075dee9ac456272b3ee30fbe5fc43c8702 -address /run/containerd/containerd.sock
root        1767 24.0 17.4 1097736 355104 ?      Ssl  06:54  23:11 kube-apiserver --advertise-address=192.168.49.2 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/var/lib/minikube/certs/ca.crt --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota --enable-bootstrap-token-auth=true --etcd-cafile=/var/lib/minikube/certs/etcd/ca.crt --etcd-certfile=/var/lib/minikube/certs/apiserver-etcd-client.crt --etcd-keyfile=/var/lib/minikube/certs/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --insecure-port=0 --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/var/lib/minikube/certs/front-proxy-client.crt --proxy-client-key-file=/var/lib/minikube/certs/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=8443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/var/lib/minikube/certs/sa.pub --service-account-signing-key-file=/var/lib/minikube/certs/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/var/lib/minikube/certs/apiserver.crt --tls-private-key-file=/var/lib/minikube/certs/apiserver.key
root        1810  0.0  0.3 113116  7388 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id e5f22d817beb70df847ac8e47e768c042ee04c1ada7f81b4a7b9fce1660f9a7f -address /run/containerd/containerd.sock
root        1867  9.4  4.8 816008 99624 ?        Ssl  06:54   9:06 kube-controller-manager --allocate-node-cidrs=true --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf --bind-address=127.0.0.1 --client-ca-file=/var/lib/minikube/certs/ca.crt --cluster-cidr=10.244.0.0/16 --cluster-name=mk --cluster-signing-cert-file=/var/lib/minikube/certs/ca.crt --cluster-signing-key-file=/var/lib/minikube/certs/ca.key --controllers=*,bootstrapsigner,tokencleaner --kubeconfig=/etc/kubernetes/controller-manager.conf --leader-elect=false --port=0 --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt --root-ca-file=/var/lib/minikube/certs/ca.crt --service-account-private-key-file=/var/lib/minikube/certs/sa.key --service-cluster-ip-range=10.96.0.0/12 --use-service-account-credentials=true
root        1878  1.1  2.2 747360 44964 ?        Ssl  06:54   1:05 kube-scheduler --authentication-kubeconfig=/etc/kubernetes/scheduler.conf --authorization-kubeconfig=/etc/kubernetes/scheduler.conf --bind-address=127.0.0.1 --kubeconfig=/etc/kubernetes/scheduler.conf --leader-elect=false --port=0
root        2614  0.0  0.3 113116  7864 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id f4dab4962dd953931d4ee6c39b835fb6b014882f7e3128f793dfc3a81ca1f899 -address /run/containerd/containerd.sock
root        2653  0.0  0.0    964     4 ?        Ss   06:54   0:00 /pause
root        2662  0.0  0.3 111964  7488 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id c18a9a7f27a07285f9f1ca38df8ee428d9f3ce8747a638cd8eee17626c58a776 -address /run/containerd/containerd.sock
root        2708  0.0  0.0    964     4 ?        Ss   06:54   0:00 /pause
root        2732  0.0  0.3 111964  7356 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 80230fe0322349551ca479677fea64e102dc769de6511b191c3fc63c859b7455 -address /run/containerd/containerd.sock
root        2782  0.0  0.0    964     4 ?        Ss   06:54   0:00 /pause
root        2864  0.0  0.3 111964  7708 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id cac6c4b8c7040c21b69516d63773ff715c640eaac6f8549fe2d1d1e7c3c1fdaa -address /run/containerd/containerd.sock
root        2898  0.1  1.7 743816 36288 ?        Ssl  06:54   0:06 /usr/local/bin/kube-proxy --config=/var/lib/kube-proxy/config.conf --hostname-override=minikube
root        2948  0.0  0.3 111964  6636 ?        Sl   06:54   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 839eb66914e336f14cef61800a3b20a9695e161610a9529cc4af79b53cdd4dab -address /run/containerd/containerd.sock
root        2968  1.5  1.8 747400 37672 ?        Ssl  06:54   1:29 /coredns -conf /etc/coredns/Corefile
root        3346  0.0  0.3 113372  7148 ?        Sl   06:55   0:00 /usr/bin/containerd-shim-runc-v2 -namespace moby -id 5b619918b8205f537c6cadcb4a14ad6fcd35c7c5f670f0e3ccc47a9ddece5c00 -address /run/containerd/containerd.sock
root        3368  0.7  1.4 735720 29168 ?        Ssl  06:55   0:44 /storage-provisioner
root       23642  0.3  0.1   4244  3528 pts/1    Ss   08:30   0:00 bash
root       23657  0.0  0.1   5896  2912 pts/1    R+   08:31   0:00 ps auxwww
root@minikube:/# cat /etc/*release*
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04.2 LTS"
NAME="Ubuntu"
VERSION="20.04.2 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.2 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
root@minikube:/#


root@minikube:/# ps auxwww | grep -i kubeler
root       23935  0.0  0.0   3304   720 pts/1    R+   08:32   0:00 grep --color=auto -i kubeler
root@minikube:/# ps auxwww | grep -i kubelet
root         852 13.0  5.1 1853424 103888 ?      Ssl  06:54  12:48 /var/lib/minikube/binaries/v1.20.2/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime=docker --hostname-override=minikube --kubeconfig=/etc/kubernetes/kubelet.conf --node-ip=192.168.49.2
root        1767 23.9 17.4 1097736 355104 ?      Ssl  06:54  23:28 kube-apiserver --advertise-address=192.168.49.2 --allow-privileged=true --authorization-mode=Node,RBAC --client-ca-file=/var/lib/minikube/certs/ca.crt --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota --enable-bootstrap-token-auth=true --etcd-cafile=/var/lib/minikube/certs/etcd/ca.crt --etcd-certfile=/var/lib/minikube/certs/apiserver-etcd-client.crt --etcd-keyfile=/var/lib/minikube/certs/apiserver-etcd-client.key --etcd-servers=https://127.0.0.1:2379 --insecure-port=0 --kubelet-client-certificate=/var/lib/minikube/certs/apiserver-kubelet-client.crt --kubelet-client-key=/var/lib/minikube/certs/apiserver-kubelet-client.key --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname --proxy-client-cert-file=/var/lib/minikube/certs/front-proxy-client.crt --proxy-client-key-file=/var/lib/minikube/certs/front-proxy-client.key --requestheader-allowed-names=front-proxy-client --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt --requestheader-extra-headers-prefix=X-Remote-Extra- --requestheader-group-headers=X-Remote-Group --requestheader-username-headers=X-Remote-User --secure-port=8443 --service-account-issuer=https://kubernetes.default.svc.cluster.local --service-account-key-file=/var/lib/minikube/certs/sa.pub --service-account-signing-key-file=/var/lib/minikube/certs/sa.key --service-cluster-ip-range=10.96.0.0/12 --tls-cert-file=/var/lib/minikube/certs/apiserver.crt --tls-private-key-file=/var/lib/minikube/certs/apiserver.key
root       23937  0.0  0.0   3436   736 pts/1    S+   08:32   0:00 grep --color=auto -i kubelet
root@minikube:/# cat /var/lib/kubelet/config.yaml 
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    cacheTTL: 0s
    enabled: true
  x509:
    clientCAFile: /var/lib/minikube/certs/ca.crt
authorization:
  mode: Webhook
  webhook:
    cacheAuthorizedTTL: 0s
    cacheUnauthorizedTTL: 0s
cgroupDriver: cgroupfs
clusterDNS:
- 10.96.0.10
clusterDomain: cluster.local
cpuManagerReconcilePeriod: 0s
evictionHard:
  imagefs.available: 0%
  nodefs.available: 0%
  nodefs.inodesFree: 0%
evictionPressureTransitionPeriod: 0s
failSwapOn: false
fileCheckFrequency: 0s
healthzBindAddress: 127.0.0.1
healthzPort: 10248
httpCheckFrequency: 0s
imageGCHighThresholdPercent: 100
imageMinimumGCAge: 0s
kind: KubeletConfiguration
logging: {}
nodeStatusReportFrequency: 0s
nodeStatusUpdateFrequency: 0s
rotateCertificates: true
runtimeRequestTimeout: 0s
shutdownGracePeriod: 0s
shutdownGracePeriodCriticalPods: 0s
staticPodPath: /etc/kubernetes/manifests
streamingConnectionIdleTimeout: 0s
syncFrequency: 0s
volumeStatsAggPeriod: 0s
root@minikube:/# 



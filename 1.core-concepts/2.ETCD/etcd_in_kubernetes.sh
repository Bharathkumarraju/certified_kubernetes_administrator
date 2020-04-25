ETCD store all the information about
Nodes
Pods
Configs
Secrets
Accounts
Roles
Bindings
Others....

Step1: if you set up your kubernetes cluster from scratch then we deploy etcd by downloading manually.
wget -q --https-only \
     "https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"

configure etcd.service

ExecStart = /usr/local/bin/etcd \\
...
...
        --advertise-client-urls https://${INTERNAL_IP}: 2379 \\
...
...
        --data-dir=/var/lib/etcd

Step2: if you deploy kubernetes using kubeadm then etcd runs in kube-system namespace.

Step3: if its minikube as below..check all the keys in the minikube-etcd folder as below

bharathdasaraju@MacBook-Pro (master) $ kubectl exec etcd-minikube -n kube-system etcdctl version
etcdctl version: 3.4.3
API version: 3.4
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl exec -it etcd-minikube -n kube-system sh

$ echo "$(ps aux)"
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  3.6  2.0 10612848 78800 ?      Ssl  Apr22 132:59 etcd --advertise-client-urls=https://192.168.64.2:2379 --cert-file=/var/lib/minikube/certs/etcd/server.crt --client-cert-auth=true --data-dir=/var/lib/minikube/etcd --initial-advertise-peer-urls=https://192.168.64.2:2380 --initial-cluster=minikube=https://192.168.64.2:2380 --key-file=/var/lib/minikube/certs/etcd/server.key --listen-client-urls=https://127.0.0.1:2379,https://192.168.64.2:2379 --listen-metrics-urls=http://127.0.0.1:2381 --listen-peer-urls=https://192.168.64.2:2380 --name=minikube --peer-cert-file=/var/lib/minikube/certs/etcd/peer.crt --peer-client-cert-auth=true --peer-key-file=/var/lib/minikube/certs/etcd/peer.key --peer-trusted-ca-file=/var/lib/minikube/certs/etcd/ca.crt --snapshot-count=10000 --trusted-ca-file=/var/lib/minikube/certs/etcd/ca.crt
root       171  0.0  0.0   4280  1376 pts/0    Ss+  08:49   0:00 sh
root       568  0.0  0.0  36636  2712 pts/0    R+   09:09   0:00 ps aux

echo "get the --advertise-client-urls from above ps output"

$ ADVERTISE_URL="https://192.168.64.2:2379"

$ echo $ADVERTISE_URL
https://192.168.64.2:2379

echo " Run the below command to get keys alone in ectd kv store "

kubernetes stores information in specific structure in etcd
i.e. root folder is /registry and then pods,replicasets,minions,deployments,roles,secrets as shown below

$ etcdctl  --endpoints $ADVERTISE_URL --cacert /var/lib/minikube/certs/etcd/ca.crt --cert /var/lib/minikube/certs/etcd/server.crt --key /var/lib/minikube/certs/etcd/server.key get / --prefix --keys-only
/registry/apiregistration.k8s.io/apiservices/v1.
/registry/apiregistration.k8s.io/apiservices/v1.admissionregistration.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apiextensions.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apps
/registry/apiregistration.k8s.io/apiservices/v1.authentication.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.autoscaling
/registry/apiregistration.k8s.io/apiservices/v1.batch
/registry/apiregistration.k8s.io/apiservices/v1.coordination.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.networking.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.rbac.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.scheduling.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.storage.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.admissionregistration.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.apiextensions.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.authentication.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.batch
/registry/apiregistration.k8s.io/apiservices/v1beta1.certificates.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.coordination.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.discovery.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.events.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.extensions
/registry/apiregistration.k8s.io/apiservices/v1beta1.networking.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.node.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.policy
/registry/apiregistration.k8s.io/apiservices/v1beta1.rbac.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.scheduling.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.storage.k8s.io
/registry/apiregistration.k8s.io/apiservices/v2beta1.autoscaling
/registry/apiregistration.k8s.io/apiservices/v2beta2.autoscaling
/registry/clusterrolebindings/cluster-admin
/registry/clusterrolebindings/kubeadm:get-nodes
/registry/clusterrolebindings/kubeadm:kubelet-bootstrap
/registry/clusterrolebindings/kubeadm:node-autoapprove-bootstrap
/registry/clusterrolebindings/kubeadm:node-autoapprove-certificate-rotation
/registry/clusterrolebindings/kubeadm:node-proxier
/registry/clusterrolebindings/kubernetes-dashboard
/registry/clusterrolebindings/minikube-rbac
/registry/clusterrolebindings/shpod
/registry/clusterrolebindings/storage-provisioner
/registry/clusterrolebindings/system:basic-user
/registry/clusterrolebindings/system:controller:attachdetach-controller
/registry/clusterrolebindings/system:controller:certificate-controller
/registry/clusterrolebindings/system:controller:clusterrole-aggregation-controller
/registry/clusterrolebindings/system:controller:cronjob-controller
/registry/clusterrolebindings/system:controller:daemon-set-controller
/registry/clusterrolebindings/system:controller:deployment-controller
/registry/clusterrolebindings/system:controller:disruption-controller
/registry/clusterrolebindings/system:controller:endpoint-controller
/registry/clusterrolebindings/system:controller:endpointslice-controller
/registry/clusterrolebindings/system:controller:expand-controller
/registry/clusterrolebindings/system:controller:generic-garbage-collector
/registry/clusterrolebindings/system:controller:horizontal-pod-autoscaler
/registry/clusterrolebindings/system:controller:job-controller
/registry/clusterrolebindings/system:controller:namespace-controller
/registry/clusterrolebindings/system:controller:node-controller
/registry/clusterrolebindings/system:controller:persistent-volume-binder
/registry/clusterrolebindings/system:controller:pod-garbage-collector
/registry/clusterrolebindings/system:controller:pv-protection-controller
/registry/clusterrolebindings/system:controller:pvc-protection-controller
/registry/clusterrolebindings/system:controller:replicaset-controller
/registry/clusterrolebindings/system:controller:replication-controller
/registry/clusterrolebindings/system:controller:resourcequota-controller
/registry/clusterrolebindings/system:controller:route-controller
/registry/clusterrolebindings/system:controller:service-account-controller
/registry/clusterrolebindings/system:controller:service-controller
/registry/clusterrolebindings/system:controller:statefulset-controller
/registry/clusterrolebindings/system:controller:ttl-controller
/registry/clusterrolebindings/system:coredns
/registry/clusterrolebindings/system:discovery
/registry/clusterrolebindings/system:kube-controller-manager
/registry/clusterrolebindings/system:kube-dns
/registry/clusterrolebindings/system:kube-scheduler
/registry/clusterrolebindings/system:node
/registry/clusterrolebindings/system:node-proxier
/registry/clusterrolebindings/system:public-info-viewer
/registry/clusterrolebindings/system:volume-scheduler
/registry/clusterroles/admin
/registry/clusterroles/cluster-admin
/registry/clusterroles/edit
/registry/clusterroles/kubeadm:get-nodes
/registry/clusterroles/kubernetes-dashboard
/registry/clusterroles/system:aggregate-to-admin
/registry/clusterroles/system:aggregate-to-edit
/registry/clusterroles/system:aggregate-to-view
/registry/clusterroles/system:auth-delegator
/registry/clusterroles/system:basic-user
/registry/clusterroles/system:certificates.k8s.io:certificatesigningrequests:nodeclient
/registry/clusterroles/system:certificates.k8s.io:certificatesigningrequests:selfnodeclient
/registry/clusterroles/system:certificates.k8s.io:kube-apiserver-client-approver
/registry/clusterroles/system:certificates.k8s.io:kube-apiserver-client-kubelet-approver
/registry/clusterroles/system:certificates.k8s.io:kubelet-serving-approver
/registry/clusterroles/system:certificates.k8s.io:legacy-unknown-approver
/registry/clusterroles/system:controller:attachdetach-controller
/registry/clusterroles/system:controller:certificate-controller
/registry/clusterroles/system:controller:clusterrole-aggregation-controller
/registry/clusterroles/system:controller:cronjob-controller
/registry/clusterroles/system:controller:daemon-set-controller
/registry/clusterroles/system:controller:deployment-controller
/registry/clusterroles/system:controller:disruption-controller
/registry/clusterroles/system:controller:endpoint-controller
/registry/clusterroles/system:controller:endpointslice-controller
/registry/clusterroles/system:controller:expand-controller
/registry/clusterroles/system:controller:generic-garbage-collector
/registry/clusterroles/system:controller:horizontal-pod-autoscaler
/registry/clusterroles/system:controller:job-controller
/registry/clusterroles/system:controller:namespace-controller
/registry/clusterroles/system:controller:node-controller
/registry/clusterroles/system:controller:persistent-volume-binder
/registry/clusterroles/system:controller:pod-garbage-collector
/registry/clusterroles/system:controller:pv-protection-controller
/registry/clusterroles/system:controller:pvc-protection-controller
/registry/clusterroles/system:controller:replicaset-controller
/registry/clusterroles/system:controller:replication-controller
/registry/clusterroles/system:controller:resourcequota-controller
/registry/clusterroles/system:controller:route-controller
/registry/clusterroles/system:controller:service-account-controller
/registry/clusterroles/system:controller:service-controller
/registry/clusterroles/system:controller:statefulset-controller
/registry/clusterroles/system:controller:ttl-controller
/registry/clusterroles/system:coredns
/registry/clusterroles/system:discovery
/registry/clusterroles/system:heapster
/registry/clusterroles/system:kube-aggregator
/registry/clusterroles/system:kube-controller-manager
/registry/clusterroles/system:kube-dns
/registry/clusterroles/system:kube-scheduler
/registry/clusterroles/system:kubelet-api-admin
/registry/clusterroles/system:node
/registry/clusterroles/system:node-bootstrapper
/registry/clusterroles/system:node-problem-detector
/registry/clusterroles/system:node-proxier
/registry/clusterroles/system:persistent-volume-provisioner
/registry/clusterroles/system:public-info-viewer
/registry/clusterroles/system:volume-scheduler
/registry/clusterroles/view
/registry/configmaps/development/haproxy
/registry/configmaps/development/registry
/registry/configmaps/kube-public/cluster-info
/registry/configmaps/kube-system/coredns
/registry/configmaps/kube-system/extension-apiserver-authentication
/registry/configmaps/kube-system/kube-proxy
/registry/configmaps/kube-system/kubeadm-config
/registry/configmaps/kube-system/kubelet-config-1.18
/registry/configmaps/kubernetes-dashboard/kubernetes-dashboard-settings
/registry/controllerrevisions/kube-system/kube-proxy-c8bb659c5
/registry/csinodes/minikube
/registry/daemonsets/kube-system/kube-proxy
/registry/deployments/kube-system/coredns
/registry/deployments/kubernetes-dashboard/dashboard-metrics-scraper
/registry/deployments/kubernetes-dashboard/kubernetes-dashboard
/registry/endpointslices/default/kubernetes
/registry/endpointslices/kube-system/kube-dns-7kd7s
/registry/endpointslices/kubernetes-dashboard/dashboard-metrics-scraper-9ssjc
/registry/endpointslices/kubernetes-dashboard/kubernetes-dashboard-nwgfl
/registry/leases/kube-node-lease/minikube
/registry/leases/kube-system/kube-controller-manager
/registry/leases/kube-system/kube-scheduler
/registry/masterleases/192.168.64.2
/registry/minions/minikube
/registry/namespaces/default
/registry/namespaces/development
/registry/namespaces/kube-node-lease
/registry/namespaces/kube-public
/registry/namespaces/kube-system
/registry/namespaces/kubernetes-dashboard
/registry/namespaces/production
/registry/namespaces/shpod
/registry/pods/kube-system/coredns-66bff467f8-js6rv
/registry/pods/kube-system/coredns-66bff467f8-pcnwb
/registry/pods/kube-system/etcd-minikube
/registry/pods/kube-system/kube-apiserver-minikube
/registry/pods/kube-system/kube-controller-manager-minikube
/registry/pods/kube-system/kube-proxy-gbxft
/registry/pods/kube-system/kube-scheduler-minikube
/registry/pods/kube-system/storage-provisioner
/registry/pods/kubernetes-dashboard/dashboard-metrics-scraper-84bfdf55ff-t5vlh
/registry/pods/kubernetes-dashboard/kubernetes-dashboard-bc446cc64-s9qjn
/registry/pods/shpod/shpod
/registry/priorityclasses/system-cluster-critical
/registry/priorityclasses/system-node-critical
/registry/ranges/serviceips
/registry/ranges/servicenodeports
/registry/replicasets/kube-system/coredns-66bff467f8
/registry/replicasets/kubernetes-dashboard/dashboard-metrics-scraper-84bfdf55ff
/registry/replicasets/kubernetes-dashboard/kubernetes-dashboard-bc446cc64
/registry/rolebindings/kube-public/kubeadm:bootstrap-signer-clusterinfo
/registry/rolebindings/kube-public/system:controller:bootstrap-signer
/registry/rolebindings/kube-system/kube-proxy
/registry/rolebindings/kube-system/kubeadm:kubelet-config-1.18
/registry/rolebindings/kube-system/kubeadm:nodes-kubeadm-config
/registry/rolebindings/kube-system/system::extension-apiserver-authentication-reader
/registry/rolebindings/kube-system/system::leader-locking-kube-controller-manager
/registry/rolebindings/kube-system/system::leader-locking-kube-scheduler
/registry/rolebindings/kube-system/system:controller:bootstrap-signer
/registry/rolebindings/kube-system/system:controller:cloud-provider
/registry/rolebindings/kube-system/system:controller:token-cleaner
/registry/rolebindings/kubernetes-dashboard/kubernetes-dashboard
/registry/roles/kube-public/kubeadm:bootstrap-signer-clusterinfo
/registry/roles/kube-public/system:controller:bootstrap-signer
/registry/roles/kube-system/extension-apiserver-authentication-reader
/registry/roles/kube-system/kube-proxy
/registry/roles/kube-system/kubeadm:kubelet-config-1.18
/registry/roles/kube-system/kubeadm:nodes-kubeadm-config
/registry/roles/kube-system/system::leader-locking-kube-controller-manager
/registry/roles/kube-system/system::leader-locking-kube-scheduler
/registry/roles/kube-system/system:controller:bootstrap-signer
/registry/roles/kube-system/system:controller:cloud-provider
/registry/roles/kube-system/system:controller:token-cleaner
/registry/roles/kubernetes-dashboard/kubernetes-dashboard
/registry/secrets/default/default-token-cljgp
/registry/secrets/development/default-token-bql99
/registry/secrets/kube-node-lease/default-token-4rm6x
/registry/secrets/kube-public/default-token-nhbhj
/registry/secrets/kube-system/attachdetach-controller-token-krhhz
/registry/secrets/kube-system/bootstrap-signer-token-hbv9z
/registry/secrets/kube-system/certificate-controller-token-lwgng
/registry/secrets/kube-system/clusterrole-aggregation-controller-token-lrd94
/registry/secrets/kube-system/coredns-token-gwg9t
/registry/secrets/kube-system/cronjob-controller-token-562lz
/registry/secrets/kube-system/daemon-set-controller-token-ljtwg
/registry/secrets/kube-system/default-token-h45qz
/registry/secrets/kube-system/deployment-controller-token-fh7kn
/registry/secrets/kube-system/disruption-controller-token-rpcj8
/registry/secrets/kube-system/endpoint-controller-token-klrhr
/registry/secrets/kube-system/endpointslice-controller-token-6m8sc
/registry/secrets/kube-system/expand-controller-token-fsg7k
/registry/secrets/kube-system/generic-garbage-collector-token-s9jgg
/registry/secrets/kube-system/horizontal-pod-autoscaler-token-ch4g6
/registry/secrets/kube-system/job-controller-token-ppcth
/registry/secrets/kube-system/kube-proxy-token-lm58d
/registry/secrets/kube-system/namespace-controller-token-rvjdj
/registry/secrets/kube-system/node-controller-token-7wtnq
/registry/secrets/kube-system/persistent-volume-binder-token-krxt9
/registry/secrets/kube-system/pod-garbage-collector-token-xghc5
/registry/secrets/kube-system/pv-protection-controller-token-gvlgj
/registry/secrets/kube-system/pvc-protection-controller-token-2rczz
/registry/secrets/kube-system/replicaset-controller-token-gpr9k
/registry/secrets/kube-system/replication-controller-token-6bh5k
/registry/secrets/kube-system/resourcequota-controller-token-fzng5
/registry/secrets/kube-system/service-account-controller-token-vc2cc
/registry/secrets/kube-system/service-controller-token-7zkv8
/registry/secrets/kube-system/statefulset-controller-token-9knw5
/registry/secrets/kube-system/storage-provisioner-token-8s79s
/registry/secrets/kube-system/token-cleaner-token-frsjv
/registry/secrets/kube-system/ttl-controller-token-t46hj
/registry/secrets/kubernetes-dashboard/default-token-7tqr9
/registry/secrets/kubernetes-dashboard/kubernetes-dashboard-certs
/registry/secrets/kubernetes-dashboard/kubernetes-dashboard-csrf
/registry/secrets/kubernetes-dashboard/kubernetes-dashboard-key-holder
/registry/secrets/kubernetes-dashboard/kubernetes-dashboard-token-qvx2b
/registry/secrets/production/default-token-lrrmb
/registry/secrets/shpod/default-token-vbdpb
/registry/secrets/shpod/shpod-token-5942f
/registry/serviceaccounts/default/default
/registry/serviceaccounts/development/default
/registry/serviceaccounts/kube-node-lease/default
/registry/serviceaccounts/kube-public/default
/registry/serviceaccounts/kube-system/attachdetach-controller
/registry/serviceaccounts/kube-system/bootstrap-signer
/registry/serviceaccounts/kube-system/certificate-controller
/registry/serviceaccounts/kube-system/clusterrole-aggregation-controller
/registry/serviceaccounts/kube-system/coredns
/registry/serviceaccounts/kube-system/cronjob-controller
/registry/serviceaccounts/kube-system/daemon-set-controller
/registry/serviceaccounts/kube-system/default
/registry/serviceaccounts/kube-system/deployment-controller
/registry/serviceaccounts/kube-system/disruption-controller
/registry/serviceaccounts/kube-system/endpoint-controller
/registry/serviceaccounts/kube-system/endpointslice-controller
/registry/serviceaccounts/kube-system/expand-controller
/registry/serviceaccounts/kube-system/generic-garbage-collector
/registry/serviceaccounts/kube-system/horizontal-pod-autoscaler
/registry/serviceaccounts/kube-system/job-controller
/registry/serviceaccounts/kube-system/kube-proxy
/registry/serviceaccounts/kube-system/namespace-controller
/registry/serviceaccounts/kube-system/node-controller
/registry/serviceaccounts/kube-system/persistent-volume-binder
/registry/serviceaccounts/kube-system/pod-garbage-collector
/registry/serviceaccounts/kube-system/pv-protection-controller
/registry/serviceaccounts/kube-system/pvc-protection-controller
/registry/serviceaccounts/kube-system/replicaset-controller
/registry/serviceaccounts/kube-system/replication-controller
/registry/serviceaccounts/kube-system/resourcequota-controller
/registry/serviceaccounts/kube-system/service-account-controller
/registry/serviceaccounts/kube-system/service-controller
/registry/serviceaccounts/kube-system/statefulset-controller
/registry/serviceaccounts/kube-system/storage-provisioner
/registry/serviceaccounts/kube-system/token-cleaner
/registry/serviceaccounts/kube-system/ttl-controller
/registry/serviceaccounts/kubernetes-dashboard/default
/registry/serviceaccounts/kubernetes-dashboard/kubernetes-dashboard
/registry/serviceaccounts/production/default
/registry/serviceaccounts/shpod/default
/registry/serviceaccounts/shpod/shpod
/registry/services/endpoints/default/kubernetes
/registry/services/endpoints/kube-system/kube-controller-manager
/registry/services/endpoints/kube-system/kube-dns
/registry/services/endpoints/kube-system/kube-scheduler
/registry/services/endpoints/kubernetes-dashboard/dashboard-metrics-scraper
/registry/services/endpoints/kubernetes-dashboard/kubernetes-dashboard
/registry/services/specs/default/kubernetes
/registry/services/specs/kube-system/kube-dns
/registry/services/specs/kubernetes-dashboard/dashboard-metrics-scraper
/registry/services/specs/kubernetes-dashboard/kubernetes-dashboard
/registry/storageclasses/standard

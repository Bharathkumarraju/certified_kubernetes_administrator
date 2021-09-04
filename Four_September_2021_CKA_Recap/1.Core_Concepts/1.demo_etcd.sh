bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ telnet localhost 2379
Trying ::1...
Connection failed: Connection refused
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
^]
telnet> quit
Connection closed.
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 



bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ etcdctl put bharath honest_guy
OK
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ etcdctl get bharath
bharath
honest_guy
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 


bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl exec -it etcd-kind-control-plane  -n kube-system sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
sh-5.0# 


etcdctl --endpoints=localhost:2379 get / --prefix --keys-only


bharathdasaraju@MacBook-Pro ~ $ minikube start
😄  minikube v1.20.0 on Darwin 11.2.3
✨  Using the docker driver based on existing profile
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
🔄  Restarting existing docker container for "minikube" ...
🐳  Preparing Kubernetes v1.20.2 on Docker 20.10.6 ...- 
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default
bharathdasaraju@MacBook-Pro ~ $ 
bharathdasaraju@MacBook-Pro ~ $ kubectl get nodes -o wide
NAME       STATUS   ROLES                  AGE     VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION    CONTAINER-RUNTIME
minikube   Ready    control-plane,master   2m48s   v1.20.2   192.168.49.2   <none>        Ubuntu 20.04.2 LTS   5.4.39-linuxkit   docker://20.10.6
bharathdasaraju@MacBook-Pro ~ $ 



bharathdasaraju@MacBook-Pro ~ $ kubectl get pod/etcd-minikube -n kube-system -o yaml | grep -i "192"
    kubeadm.kubernetes.io/etcd.advertise-client-urls: https://192.168.49.2:2379
          k:{"ip":"192.168.49.2"}:
    - --advertise-client-urls=https://192.168.49.2:2379
    - --initial-advertise-peer-urls=https://192.168.49.2:2380
    - --initial-cluster=minikube=https://192.168.49.2:2380
    - --listen-client-urls=https://127.0.0.1:2379,https://192.168.49.2:2379
    - --listen-peer-urls=https://192.168.49.2:2380
  hostIP: 192.168.49.2
  podIP: 192.168.49.2
  - ip: 192.168.49.2
bharathdasaraju@MacBook-Pro ~ $ 



bharathdasaraju@MacBook-Pro ~ $ kubectl exec etcd-minikube -n kube-system -- etcdctl --endpoints https://192.168.49.2:2379 --cacert /var/lib/minikube/certs/etcd/ca.crt --cert /var/lib/minikube/certs/etcd/server.crt --key /var/lib/minikube/certs/etcd/server.key get / --prefix --keys-only
/registry/apiregistration.k8s.io/apiservices/v1.
/registry/apiregistration.k8s.io/apiservices/v1.admissionregistration.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apiextensions.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apps
/registry/apiregistration.k8s.io/apiservices/v1.authentication.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.autoscaling
/registry/apiregistration.k8s.io/apiservices/v1.batch
/registry/apiregistration.k8s.io/apiservices/v1.certificates.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.coordination.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.events.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.networking.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.node.k8s.io
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
/registry/apiregistration.k8s.io/apiservices/v1beta1.flowcontrol.apiserver.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.networking.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.node.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.policy
/registry/apiregistration.k8s.io/apiservices/v1beta1.rbac.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.scheduling.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.storage.k8s.io
/registry/apiregistration.k8s.io/apiservices/v2beta1.autoscaling
/registry/apiregistration.k8s.io/apiservices/v2beta2.autoscaling
/registry/certificatesigningrequests/csr-scxvm
/registry/clusterrolebindings/cluster-admin
/registry/clusterrolebindings/kubeadm:get-nodes
/registry/clusterrolebindings/kubeadm:kubelet-bootstrap
/registry/clusterrolebindings/kubeadm:node-autoapprove-bootstrap
/registry/clusterrolebindings/kubeadm:node-autoapprove-certificate-rotation
/registry/clusterrolebindings/kubeadm:node-proxier
/registry/clusterrolebindings/minikube-rbac
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
/registry/clusterrolebindings/system:controller:endpointslicemirroring-controller
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
/registry/clusterrolebindings/system:controller:root-ca-cert-publisher
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
/registry/clusterrolebindings/system:monitoring
/registry/clusterrolebindings/system:node
/registry/clusterrolebindings/system:node-proxier
/registry/clusterrolebindings/system:public-info-viewer
/registry/clusterrolebindings/system:service-account-issuer-discovery
/registry/clusterrolebindings/system:volume-scheduler
/registry/clusterroles/admin
/registry/clusterroles/cluster-admin
/registry/clusterroles/edit
/registry/clusterroles/kubeadm:get-nodes
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
/registry/clusterroles/system:controller:endpointslicemirroring-controller
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
/registry/clusterroles/system:controller:root-ca-cert-publisher
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
/registry/clusterroles/system:monitoring
/registry/clusterroles/system:node
/registry/clusterroles/system:node-bootstrapper
/registry/clusterroles/system:node-problem-detector
/registry/clusterroles/system:node-proxier
/registry/clusterroles/system:persistent-volume-provisioner
/registry/clusterroles/system:public-info-viewer
/registry/clusterroles/system:service-account-issuer-discovery
/registry/clusterroles/system:volume-scheduler
/registry/clusterroles/view
/registry/configmaps/default/kube-root-ca.crt
/registry/configmaps/kube-node-lease/kube-root-ca.crt
/registry/configmaps/kube-public/cluster-info
/registry/configmaps/kube-public/kube-root-ca.crt
/registry/configmaps/kube-system/coredns
/registry/configmaps/kube-system/extension-apiserver-authentication
/registry/configmaps/kube-system/kube-proxy
/registry/configmaps/kube-system/kube-root-ca.crt
/registry/configmaps/kube-system/kubeadm-config
/registry/configmaps/kube-system/kubelet-config-1.20
/registry/controllerrevisions/kube-system/kube-proxy-b89db7f56
/registry/csinodes/minikube
/registry/daemonsets/kube-system/kube-proxy
/registry/deployments/kube-system/coredns
/registry/endpointslices/default/kubernetes
/registry/endpointslices/kube-system/kube-dns-9xfbw
/registry/events/default/minikube.16a18be4b7100538
/registry/events/default/minikube.16a18be4cca0b168
/registry/events/default/minikube.16a18be4cca1a014
/registry/events/default/minikube.16a18be4cca33910
/registry/events/default/minikube.16a18be4e2a57390
/registry/events/default/minikube.16a18be500264638
/registry/events/default/minikube.16a18be70d57d234
/registry/events/default/minikube.16a18be737e5b624
/registry/events/default/minikube.16a18be88fa18450
/registry/events/default/minikube.16a18be88fff0ae4
/registry/events/default/minikube.16a18bff9ae000dc
/registry/events/default/minikube.16a18bffab3fc5d4
/registry/events/default/minikube.16a18bffab4337dc
/registry/events/default/minikube.16a18bffab43eb8c
/registry/events/default/minikube.16a18bffb856d5b4
/registry/events/default/minikube.16a18c0567a6f3f0
/registry/events/default/minikube.16a18c0567c27300
/registry/events/default/minikube.16a18c06e82561c8
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18be742c04514
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18be7da9adc00
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18be87a2ae0f8
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18be88241dd3c
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18be8b317a838
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18c04b11c72f4
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18c0532ad6300
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18c05408d550c
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18c055b65a58c
/registry/events/kube-system/coredns-74ff55c5b-plhmt.16a18c07074c8f18
/registry/events/kube-system/coredns-74ff55c5b.16a18be7464bf318
/registry/events/kube-system/coredns.16a18be73ba3ec7c
/registry/events/kube-system/etcd-minikube.16a18bffc94ead88
/registry/events/kube-system/etcd-minikube.16a18c0003563654
/registry/events/kube-system/etcd-minikube.16a18c001158e878
/registry/events/kube-system/etcd-minikube.16a18c0035eab978
/registry/events/kube-system/k8s.io-minikube-hostpath.16a18be9c719b208
/registry/events/kube-system/k8s.io-minikube-hostpath.16a18c133afda854
/registry/events/kube-system/kube-apiserver-minikube.16a18be7460f1e70
/registry/events/kube-system/kube-apiserver-minikube.16a18bffd59f6e38
/registry/events/kube-system/kube-apiserver-minikube.16a18c000fa728a0
/registry/events/kube-system/kube-apiserver-minikube.16a18c001b1c3b08
/registry/events/kube-system/kube-apiserver-minikube.16a18c0042d614ac
/registry/events/kube-system/kube-apiserver-minikube.16a18c03068ac4e0
/registry/events/kube-system/kube-controller-manager-minikube.16a18bffe406f9f0
/registry/events/kube-system/kube-controller-manager-minikube.16a18c001a9b6758
/registry/events/kube-system/kube-controller-manager-minikube.16a18c0023552348
/registry/events/kube-system/kube-controller-manager-minikube.16a18c0056fe4c4c
/registry/events/kube-system/kube-proxy-w85sf.16a18be76ec9e6b0
/registry/events/kube-system/kube-proxy-w85sf.16a18be7c3afbdf8
/registry/events/kube-system/kube-proxy-w85sf.16a18be7d22c9d74
/registry/events/kube-system/kube-proxy-w85sf.16a18be81a6037cc
/registry/events/kube-system/kube-proxy-w85sf.16a18c04c505a2a4
/registry/events/kube-system/kube-proxy-w85sf.16a18c0510a67940
/registry/events/kube-system/kube-proxy-w85sf.16a18c051bc0eb44
/registry/events/kube-system/kube-proxy-w85sf.16a18c054616dd54
/registry/events/kube-system/kube-proxy.16a18be745ff2498
/registry/events/kube-system/kube-scheduler-minikube.16a18bfff14fcf38
/registry/events/kube-system/kube-scheduler-minikube.16a18c002877e568
/registry/events/kube-system/kube-scheduler-minikube.16a18c002f00620c
/registry/events/kube-system/kube-scheduler-minikube.16a18c005cfa74b8
/registry/events/kube-system/storage-provisioner.16a18be4716e7e74
/registry/events/kube-system/storage-provisioner.16a18be9444edd58
/registry/events/kube-system/storage-provisioner.16a18be983957148
/registry/events/kube-system/storage-provisioner.16a18be98a7f0d34
/registry/events/kube-system/storage-provisioner.16a18be9a3c8f9d0
/registry/events/kube-system/storage-provisioner.16a18c04abb0f9fc
/registry/events/kube-system/storage-provisioner.16a18c04e979be2c
/registry/events/kube-system/storage-provisioner.16a18c04f27351dc
/registry/events/kube-system/storage-provisioner.16a18c052fdd62b0
/registry/events/kube-system/storage-provisioner.16a18c0c68bb6918
/registry/flowschemas/catch-all
/registry/flowschemas/exempt
/registry/flowschemas/global-default
/registry/flowschemas/kube-controller-manager
/registry/flowschemas/kube-scheduler
/registry/flowschemas/kube-system-service-accounts
/registry/flowschemas/service-accounts
/registry/flowschemas/system-leader-election
/registry/flowschemas/system-nodes
/registry/flowschemas/workload-leader-election
/registry/leases/kube-node-lease/minikube
/registry/masterleases/192.168.49.2
/registry/minions/minikube
/registry/namespaces/default
/registry/namespaces/kube-node-lease
/registry/namespaces/kube-public
/registry/namespaces/kube-system
/registry/pods/kube-system/coredns-74ff55c5b-plhmt
/registry/pods/kube-system/etcd-minikube
/registry/pods/kube-system/kube-apiserver-minikube
/registry/pods/kube-system/kube-controller-manager-minikube
/registry/pods/kube-system/kube-proxy-w85sf
/registry/pods/kube-system/kube-scheduler-minikube
/registry/pods/kube-system/storage-provisioner
/registry/priorityclasses/system-cluster-critical
/registry/priorityclasses/system-node-critical
/registry/prioritylevelconfigurations/catch-all
/registry/prioritylevelconfigurations/exempt
/registry/prioritylevelconfigurations/global-default
/registry/prioritylevelconfigurations/leader-election
/registry/prioritylevelconfigurations/system
/registry/prioritylevelconfigurations/workload-high
/registry/prioritylevelconfigurations/workload-low
/registry/ranges/serviceips
/registry/ranges/servicenodeports
/registry/replicasets/kube-system/coredns-74ff55c5b
/registry/rolebindings/kube-public/kubeadm:bootstrap-signer-clusterinfo
/registry/rolebindings/kube-public/system:controller:bootstrap-signer
/registry/rolebindings/kube-system/kube-proxy
/registry/rolebindings/kube-system/kubeadm:kubelet-config-1.20
/registry/rolebindings/kube-system/kubeadm:nodes-kubeadm-config
/registry/rolebindings/kube-system/system::extension-apiserver-authentication-reader
/registry/rolebindings/kube-system/system::leader-locking-kube-controller-manager
/registry/rolebindings/kube-system/system::leader-locking-kube-scheduler
/registry/rolebindings/kube-system/system:controller:bootstrap-signer
/registry/rolebindings/kube-system/system:controller:cloud-provider
/registry/rolebindings/kube-system/system:controller:token-cleaner
/registry/rolebindings/kube-system/system:persistent-volume-provisioner
/registry/roles/kube-public/kubeadm:bootstrap-signer-clusterinfo
/registry/roles/kube-public/system:controller:bootstrap-signer
/registry/roles/kube-system/extension-apiserver-authentication-reader
/registry/roles/kube-system/kube-proxy
/registry/roles/kube-system/kubeadm:kubelet-config-1.20
/registry/roles/kube-system/kubeadm:nodes-kubeadm-config
/registry/roles/kube-system/system::leader-locking-kube-controller-manager
/registry/roles/kube-system/system::leader-locking-kube-scheduler
/registry/roles/kube-system/system:controller:bootstrap-signer
/registry/roles/kube-system/system:controller:cloud-provider
/registry/roles/kube-system/system:controller:token-cleaner
/registry/roles/kube-system/system:persistent-volume-provisioner
/registry/secrets/default/default-token-lxpp9
/registry/secrets/kube-node-lease/default-token-tvrxs
/registry/secrets/kube-public/default-token-49sct
/registry/secrets/kube-system/attachdetach-controller-token-966hx
/registry/secrets/kube-system/bootstrap-signer-token-8l2q5
/registry/secrets/kube-system/bootstrap-token-1eo1in
/registry/secrets/kube-system/certificate-controller-token-4gkjg
/registry/secrets/kube-system/clusterrole-aggregation-controller-token-pm2bh
/registry/secrets/kube-system/coredns-token-t7784
/registry/secrets/kube-system/cronjob-controller-token-5jt7h
/registry/secrets/kube-system/daemon-set-controller-token-pwkrh
/registry/secrets/kube-system/default-token-dfnc4
/registry/secrets/kube-system/deployment-controller-token-9vhsp
/registry/secrets/kube-system/disruption-controller-token-c54kt
/registry/secrets/kube-system/endpoint-controller-token-hm49x
/registry/secrets/kube-system/endpointslice-controller-token-m6wvn
/registry/secrets/kube-system/endpointslicemirroring-controller-token-w6qlt
/registry/secrets/kube-system/expand-controller-token-2x7fc
/registry/secrets/kube-system/generic-garbage-collector-token-mnh22
/registry/secrets/kube-system/horizontal-pod-autoscaler-token-vt2g8
/registry/secrets/kube-system/job-controller-token-54xh4
/registry/secrets/kube-system/kube-proxy-token-qsxdd
/registry/secrets/kube-system/namespace-controller-token-kndll
/registry/secrets/kube-system/node-controller-token-fzn8p
/registry/secrets/kube-system/persistent-volume-binder-token-gmgqp
/registry/secrets/kube-system/pod-garbage-collector-token-pq26q
/registry/secrets/kube-system/pv-protection-controller-token-hzmsl
/registry/secrets/kube-system/pvc-protection-controller-token-wtkk4
/registry/secrets/kube-system/replicaset-controller-token-dncxp
/registry/secrets/kube-system/replication-controller-token-ljk6m
/registry/secrets/kube-system/resourcequota-controller-token-gkchp
/registry/secrets/kube-system/root-ca-cert-publisher-token-km4f2
/registry/secrets/kube-system/service-account-controller-token-mb5qg
/registry/secrets/kube-system/service-controller-token-5glzt
/registry/secrets/kube-system/statefulset-controller-token-s7wqm
/registry/secrets/kube-system/storage-provisioner-token-z7lw7
/registry/secrets/kube-system/token-cleaner-token-7btq6
/registry/secrets/kube-system/ttl-controller-token-vc2wg
/registry/serviceaccounts/default/default
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
/registry/serviceaccounts/kube-system/endpointslicemirroring-controller
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
/registry/serviceaccounts/kube-system/root-ca-cert-publisher
/registry/serviceaccounts/kube-system/service-account-controller
/registry/serviceaccounts/kube-system/service-controller
/registry/serviceaccounts/kube-system/statefulset-controller
/registry/serviceaccounts/kube-system/storage-provisioner
/registry/serviceaccounts/kube-system/token-cleaner
/registry/serviceaccounts/kube-system/ttl-controller
/registry/services/endpoints/default/kubernetes
/registry/services/endpoints/kube-system/k8s.io-minikube-hostpath
/registry/services/endpoints/kube-system/kube-dns
/registry/services/specs/default/kubernetes
/registry/services/specs/kube-system/kube-dns
/registry/storageclasses/standard
bharathdasaraju@MacBook-Pro ~ $



bharathdasaraju@MacBook-Pro ~ $ kubectl exec etcd-minikube -n kube-system -- sh -c " etcdctl --endpoints https://192.168.49.2:2379 --cacert /var/lib/minikube/certs/etcd/ca.crt --cert /var/lib/minikube/certs/etcd/server.crt --key /var/lib/minikube/certs/etcd/server.key get / --prefix --keys-only --limit=10"
/registry/apiregistration.k8s.io/apiservices/v1.
/registry/apiregistration.k8s.io/apiservices/v1.admissionregistration.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apiextensions.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apps
/registry/apiregistration.k8s.io/apiservices/v1.authentication.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.autoscaling
/registry/apiregistration.k8s.io/apiservices/v1.batch
/registry/apiregistration.k8s.io/apiservices/v1.certificates.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.coordination.k8s.io
bharathdasaraju@MacBook-Pro ~ $


bharathdasaraju@MacBook-Pro ~ $ kubectl exec etcd-minikube -n kube-system -- sh -c " etcdctl --endpoints https://192.168.49.2:2379 --cacert /var/lib/minikube/certs/etcd/ca.crt --cert /var/lib/minikube/certs/etcd/server.crt --key /var/lib/minikube/certs/etcd/server.key get / --prefix --keys-only --limit=20"
/registry/apiregistration.k8s.io/apiservices/v1.
/registry/apiregistration.k8s.io/apiservices/v1.admissionregistration.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apiextensions.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.apps
/registry/apiregistration.k8s.io/apiservices/v1.authentication.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.autoscaling
/registry/apiregistration.k8s.io/apiservices/v1.batch
/registry/apiregistration.k8s.io/apiservices/v1.certificates.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.coordination.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.events.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.networking.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.node.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.rbac.authorization.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.scheduling.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1.storage.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.admissionregistration.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.apiextensions.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.authentication.k8s.io
/registry/apiregistration.k8s.io/apiservices/v1beta1.authorization.k8s.io
bharathdasaraju@MacBook-Pro ~ $





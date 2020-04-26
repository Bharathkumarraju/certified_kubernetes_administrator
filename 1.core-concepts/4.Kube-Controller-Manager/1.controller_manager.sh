This contoller manager takes care of
1. status of nodes and containers
2. Like whenever new node added and removed...looking after about its health etc....
3. Remediate situation and Watch status

The contoller is a Process the continuously monitors the state of the various components with in the k8s cluster.
and works towards bringing the whole system to the desired functioning state.

For example:
Node-Controller -->
1. responsible for monitor the status of the node and taking necessary actions to keep the
   application running 24/7, it does to the kube-apiserver
2. Node controller checks the status of the nodes in every 5 seconds. Node Monitor Period = 5seconds
   that way it can monitor the hralth of the nodes.
   If it stops recieving the heartbeat from a node then node is marked as Unreachable.
   but it waits for 40seconds before marking it as unreachable. i.e. Node Monitor Grace Period = 40seconds
3. After node is marked as unreachable, it gives 5 minits to come backup. POD Eviction Timeout = 5minits
  if node does not come backup then it removes all the pods on that node and reprovision them on the healthy nodes,
  if the pods are pod of a replicaset

Replication-Controller -->
1. It is responsible for monitoring the status of the replicasets and ensuring that the desired number of pods are available
   all time with in the replicaset
2. If a pod dies then replication controller creates another one.

There are many more controllers are available within the kubernetes...

like Deployment-Controller,
     Namespace-controller,
     Endpoint-controller,
     Job-controller,
     PV-protection-controller,
     PVC-protection-controller,
     Daemonset-controller,
     PV-Binder-Controller,
     Service-Account-Controller,
     bootstrapsigner,
     tokencleaner
So were are all these controllers are located in our cluster....
They are all packaged in  single process called Kube-Controller-Manager.

Installing Kube-Controller-manager:
------------------------------------->
Download kube-controller-manager from kubernetes official downloads page and run it as service in linux box.

kube-controller-manager.service
ExecStart=/usr/local/bin/kube-controller-manager \\
...
...
     --node-monitor-period=5s
     --node-monitor-grace-period=40s
     --pod-eviction-timeout=5m0s
     --controllers stringSlice   Default: [*]
     A list of controller to enable. '*' enables all on-by-default controllers, 'foo' enables the controller named foo,
     '-foo' disables the controller named foo.



bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get pod kube-controller-manager-minikube -n kube-system -o yaml  | grep -C20 "\-\-controllers"
spec:
  containers:
  - command:
    - kube-controller-manager
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --bind-address=127.0.0.1
    - --client-ca-file=/var/lib/minikube/certs/ca.crt
    - --cluster-name=mk
    - --cluster-signing-cert-file=/var/lib/minikube/certs/ca.crt
    - --cluster-signing-key-file=/var/lib/minikube/certs/ca.key
    - --controllers=*,bootstrapsigner,tokencleaner
    - --kubeconfig=/etc/kubernetes/controller-manager.conf
    - --leader-elect=true
    - --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt
    - --root-ca-file=/var/lib/minikube/certs/ca.crt
    - --service-account-private-key-file=/var/lib/minikube/certs/sa.key
    - --use-service-account-credentials=true
    image: k8s.gcr.io/kube-controller-manager:v1.18.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 15
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 15
    name: kube-controller-manager
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $





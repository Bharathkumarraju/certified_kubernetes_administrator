1. Node Controller
2. Replica Controller
3. Deployment Controller
4. Namespace Controller
5. Endpoint Controller
6. Job Controller
7. Service-Account-Controller
8. Stateful-Set 
9. PV-Binder-Controller
10. PV-Protection-Controller 
...
...
Many more




bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get pod kube-controller-manager-minikube -n kube-system -o yaml | grep -iC45 "kube-controller-manager"
spec:
  containers:
  - command:
    - kube-controller-manager
    - --allocate-node-cidrs=true
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --bind-address=127.0.0.1
    - --client-ca-file=/var/lib/minikube/certs/ca.crt
    - --cluster-cidr=10.244.0.0/16
    - --cluster-name=mk
    - --cluster-signing-cert-file=/var/lib/minikube/certs/ca.crt
    - --cluster-signing-key-file=/var/lib/minikube/certs/ca.key
    - --controllers=*,bootstrapsigner,tokencleaner
    - --kubeconfig=/etc/kubernetes/controller-manager.conf
    - --leader-elect=false
    - --port=0
    - --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt
    - --root-ca-file=/var/lib/minikube/certs/ca.crt
    - --service-account-private-key-file=/var/lib/minikube/certs/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --use-service-account-credentials=true
--
    - --allocate-node-cidrs=true
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --bind-address=127.0.0.1
    - --client-ca-file=/var/lib/minikube/certs/ca.crt
    - --cluster-cidr=10.244.0.0/16
    - --cluster-name=mk
    - --cluster-signing-cert-file=/var/lib/minikube/certs/ca.crt
    - --cluster-signing-key-file=/var/lib/minikube/certs/ca.key
    - --controllers=*,bootstrapsigner,tokencleaner
    - --kubeconfig=/etc/kubernetes/controller-manager.conf
    - --leader-elect=false
    - --port=0
    - --requestheader-client-ca-file=/var/lib/minikube/certs/front-proxy-ca.crt
    - --root-ca-file=/var/lib/minikube/certs/ca.crt
    - --service-account-private-key-file=/var/lib/minikube/certs/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --use-service-account-credentials=true
    image: k8s.gcr.io/kube-controller-manager:v1.20.2
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 15



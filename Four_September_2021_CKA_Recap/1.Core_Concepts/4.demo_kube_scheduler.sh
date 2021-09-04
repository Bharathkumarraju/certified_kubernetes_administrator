bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get all --all-namespaces | grep -i "scheduler"
kube-system   pod/kube-scheduler-minikube            1/1     Running   1          92m
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 



  uid: 1487f521-591a-4fa5-829a-9554400a9992
spec:
  containers:
  - command:
    - kube-scheduler
    - --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
    - --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
    - --bind-address=127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    - --leader-elect=false
    - --port=0
--
    - --authentication-kubeconfig=/etc/kubernetes/scheduler.conf
    - --authorization-kubeconfig=/etc/kubernetes/scheduler.conf
    - --bind-address=127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    - --leader-elect=false
    - --port=0
    image: k8s.gcr.io/kube-scheduler:v1.20.2
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10259
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 15

      
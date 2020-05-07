bharathdasaraju@MacBook-Pro ~ $ minikube addons enable metrics-server
🌟  The 'metrics-server' addon is enabled
bharathdasaraju@MacBook-Pro ~ $

bharathdasaraju@MacBook-Pro ~ $ kubectl top node
error: metrics not available yet
bharathdasaraju@MacBook-Pro ~ $ kubectl top node
NAME       CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
minikube   246m         12%    1693Mi          45%


bharathdasaraju@MacBook-Pro ~ $ kubectl top pod
NAME    CPU(cores)   MEMORY(bytes)
nginx   0m           2Mi
bharathdasaraju@MacBook-Pro ~


bharathdasaraju@MacBook-Pro ~ $ kubectl top pod -n kube-system
NAME                               CPU(cores)   MEMORY(bytes)
coredns-66bff467f8-js6rv           5m           6Mi
coredns-66bff467f8-pcnwb           5m           6Mi
etcd-minikube                      26m          87Mi
kube-apiserver-minikube            74m          247Mi
kube-controller-manager-minikube   32m          35Mi
kube-proxy-gbxft                   0m           14Mi
kube-scheduler-minikube            4m           11Mi
metrics-server-7bc6d75975-qr78m    0m           10Mi
storage-provisioner                0m           14Mi
bharathdasaraju@MacBook-Pro ~ $
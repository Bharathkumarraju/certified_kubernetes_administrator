master $ git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git
Cloning into 'kubernetes-metrics-server'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 15 (delta 0), reused 0 (delta 0), pack-reused 12
Unpacking objects: 100% (15/15), done.
Checking connectivity... done.
master $

master $ cd kubernetes-metrics-server/
master $ ls -rtlh
total 32K
-rw-r--r-- 1 root root 612 May  7 03:49 resource-reader.yaml
-rw-r--r-- 1 root root 219 May  7 03:49 README.md
-rw-r--r-- 1 root root 249 May  7 03:49 metrics-server-service.yaml
-rw-r--r-- 1 root root 976 May  7 03:49 metrics-server-deployment.yaml
-rw-r--r-- 1 root root 298 May  7 03:49 metrics-apiservice.yaml
-rw-r--r-- 1 root root 329 May  7 03:49 auth-reader.yaml
-rw-r--r-- 1 root root 308 May  7 03:49 auth-delegator.yaml
-rw-r--r-- 1 root root 384 May  7 03:49 aggregated-metrics-reader.yaml
master $

master $ kubectl apply -f .
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
serviceaccount/metrics-server created
deployment.apps/metrics-server created
service/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
master $

master $ kubectl top node
NAME     CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
master   102m         5%     1276Mi          67%
node01   1981m        99%    1038Mi          26%
master $

master $ kubectl top pod
NAME       CPU(cores)   MEMORY(bytes)
elephant   15m          50Mi
lion       960m         0Mi
rabbit     972m         0Mi
master $
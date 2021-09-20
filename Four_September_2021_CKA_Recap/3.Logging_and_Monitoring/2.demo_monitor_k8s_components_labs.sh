root@controlplane:~# kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
elephant   1/1     Running   0          47s
lion       1/1     Running   0          47s
rabbit     1/1     Running   0          47s
root@controlplane:~# 


Deploy a metrics-server

git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git

root@controlplane:~# git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git
Cloning into 'kubernetes-metrics-server'...
remote: Enumerating objects: 24, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 24 (delta 4), reused 0 (delta 0), pack-reused 12
Unpacking objects: 100% (24/24), done.
root@controlplane:~# 

root@controlplane:~# cd kubernetes-metrics-server/
root@controlplane:~/kubernetes-metrics-server# ls -rtlh
total 32K
-rw-r--r-- 1 root root 384 Sep 20 02:53 aggregated-metrics-reader.yaml
-rw-r--r-- 1 root root 219 Sep 20 02:53 README.md
-rw-r--r-- 1 root root 612 Sep 20 02:53 resource-reader.yaml
-rw-r--r-- 1 root root 249 Sep 20 02:53 metrics-server-service.yaml
-rw-r--r-- 1 root root 976 Sep 20 02:53 metrics-server-deployment.yaml
-rw-r--r-- 1 root root 293 Sep 20 02:53 metrics-apiservice.yaml
-rw-r--r-- 1 root root 324 Sep 20 02:53 auth-reader.yaml
-rw-r--r-- 1 root root 303 Sep 20 02:53 auth-delegator.yaml
root@controlplane:~/kubernetes-metrics-server# 


root@controlplane:~/kubernetes-metrics-server# kubectl create -f .
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
serviceaccount/metrics-server created
deployment.apps/metrics-server created
service/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
root@controlplane:~/kubernetes-metrics-server# 


root@controlplane:~/kubernetes-metrics-server# kubectl top node
NAME           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
controlplane   502m         1%     1274Mi          0%        
node01         88m          0%     374Mi           0%        
root@controlplane:~/kubernetes-metrics-server# 


root@controlplane:~/kubernetes-metrics-server# kubectl top pod -n kube-system
NAME                                   CPU(cores)   MEMORY(bytes)   
coredns-74ff55c5b-lvss6                6m           18Mi            
coredns-74ff55c5b-vcmhj                5m           18Mi            
etcd-controlplane                      35m          42Mi            
kube-apiserver-controlplane            104m         306Mi           
kube-controller-manager-controlplane   37m          56Mi            
kube-flannel-ds-sz9vl                  5m           36Mi            
kube-flannel-ds-v54mw                  6m           36Mi            
kube-proxy-274jt                       1m           30Mi            
kube-proxy-7nfrj                       1m           30Mi            
kube-scheduler-controlplane            8m           24Mi            
metrics-server-774b56d589-2wb8t        3m           19Mi            
root@controlplane:~/kubernetes-metrics-server# kubectl top pod -n default    
NAME       CPU(cores)   MEMORY(bytes)   
elephant   28m          32Mi            
lion       1m           18Mi            
rabbit     171m         253Mi           
root@controlplane:~/kubernetes-metrics-server# 


root@controlplane:~/kubernetes-metrics-server# kubectl top node
NAME           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
controlplane   501m         1%     1174Mi          0%        
node01         103m         0%     378Mi           0%        
root@controlplane:~/kubernetes-metrics-server# 


root@controlplane:~/kubernetes-metrics-server# kubectl top node
NAME           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
controlplane   500m         1%     1237Mi          0%        
node01         92m          0%     380Mi           0%        
root@controlplane:~/kubernetes-metrics-server# 


root@controlplane:~/kubernetes-metrics-server# kubectl top pod
NAME       CPU(cores)   MEMORY(bytes)   
elephant   30m          30Mi            
lion       1m           18Mi            
rabbit     156m         253Mi           
root@controlplane:~/kubernetes-metrics-server# 



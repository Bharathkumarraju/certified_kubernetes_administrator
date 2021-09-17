root@controlplane:~# kubectl describe node node01 | grep -iwC10 "Labels:"
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"9e:a5:53:b7:a3:98"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 10.49.14.3
                    kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
root@controlplane:~# 

root@controlplane:~# kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
controlplane   Ready    control-plane,master   21m   v1.20.0
node01         Ready    <none>                 20m   v1.20.0
root@controlplane:~# 


root@controlplane:~# kubectl label node node01 color=blue
node/node01 labeled
root@controlplane:~# kubectl describe node node01 | grep -iwC10 "Labels:"
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    color=blue
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"9e:a5:53:b7:a3:98"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 10.49.14.3
                    kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
root@controlplane:~# 


root@controlplane:~# kubectl create deploy blue --image=nginx --replicas=3 --dry-run=client -o yaml > blue_deployment.yaml
root@controlplane:~# kubectl apply -f blue_deployment.yaml 
deployment.apps/blue created
root@controlplane:~# 

root@controlplane:~# kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE   IP           NODE     NOMINATED NODE   READINESS GATES
blue-7bb46df96d-7n2tq   1/1     Running   0          43s   10.244.1.4   node01   <none>           <none>
blue-7bb46df96d-qd5sv   1/1     Running   0          43s   10.244.1.2   node01   <none>           <none>
blue-7bb46df96d-wvvb4   1/1     Running   0          43s   10.244.1.3   node01   <none>           <none>
root@controlplane:~# 

root@controlplane:~# kubectl describe node node01 | grep -i "taint"
Taints:             <none>
root@controlplane:~# kubectl describe node controlplane | grep -i "taint"
Taints:             <none>
root@controlplane:~# 

Set Node Affinity to the deployment to place the pods on node01 only.

Name: blue
Replicas: 3
Image: nginx
NodeAffinity: requiredDuringSchedulingIgnoredDuringExecution
Key: color
values: blue



root@controlplane:~# vim blue_deployment.yaml 
root@controlplane:~# kubectl apply -f blue_deployment.yaml 
deployment.apps/blue configured
root@controlplane:~# 


Use the label - node-role.kubernetes.io/master - set on the controlplane node.





root@controlplane:~# kubectl describe node controlplane | grep -iwC10 "Labels:"
Name:               controlplane
Roles:              control-plane,master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=controlplane
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node-role.kubernetes.io/master=
Annotations:        flannel.alpha.coreos.com/backend-data: {"VNI":1,"VtepMAC":"da:0c:0a:a9:ce:3f"}
                    flannel.alpha.coreos.com/backend-type: vxlan
                    flannel.alpha.coreos.com/kube-subnet-manager: true
                    flannel.alpha.coreos.com/public-ip: 10.49.14.12
root@controlplane:~# cp blue_deployment.yaml red_deployment.yaml
root@controlplane:~# vim red_deployment.yaml 
root@controlplane:~# vim red_deployment.yaml 
root@controlplane:~# kubectl apply -f red_deployment.yaml 
deployment.apps/red created
root@controlplane:~# kubectl get pods -o wide | grep -i red
red-5cbd45ccb6-r2ph2    0/1     ContainerCreating   0          14s     <none>       controlplane   <none>           <none>
red-5cbd45ccb6-zmgkc    0/1     ContainerCreating   0          14s     <none>       controlplane   <none>           <none>
root@controlplane:~# kubectl get pods -o wide | grep -i red
red-5cbd45ccb6-r2ph2    1/1     Running   0          32s     10.244.0.4   controlplane   <none>           <none>
red-5cbd45ccb6-zmgkc    1/1     Running   0          32s     10.244.0.5   controlplane   <none>           <none>
root@controlplane:~# 

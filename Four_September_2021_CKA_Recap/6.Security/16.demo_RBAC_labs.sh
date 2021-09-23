root@controlplane:/etc/kubernetes/manifests# kubectl get roles
No resources found in default namespace.
root@controlplane:/etc/kubernetes/manifests# 



root@controlplane:/etc/kubernetes/manifests# kubectl get roles --all-namespaces
NAMESPACE     NAME                                             CREATED AT
blue          developer                                        2021-09-23T08:54:07Z
kube-public   kubeadm:bootstrap-signer-clusterinfo             2021-09-23T08:51:21Z
kube-public   system:controller:bootstrap-signer               2021-09-23T08:51:19Z
kube-system   extension-apiserver-authentication-reader        2021-09-23T08:51:19Z
kube-system   kube-proxy                                       2021-09-23T08:51:24Z
kube-system   kubeadm:kubelet-config-1.20                      2021-09-23T08:51:20Z
kube-system   kubeadm:nodes-kubeadm-config                     2021-09-23T08:51:20Z
kube-system   system::leader-locking-kube-controller-manager   2021-09-23T08:51:19Z
kube-system   system::leader-locking-kube-scheduler            2021-09-23T08:51:19Z
kube-system   system:controller:bootstrap-signer               2021-09-23T08:51:19Z
kube-system   system:controller:cloud-provider                 2021-09-23T08:51:19Z
kube-system   system:controller:token-cleaner                  2021-09-23T08:51:19Z
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:/etc/kubernetes/manifests# kubectl describe role kube-proxy -n kube-system
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources   Non-Resource URLs  Resource Names  Verbs
  ---------   -----------------  --------------  -----
  configmaps  []                 [kube-proxy]    [get]
root@controlplane:/etc/kubernetes/manifests# 



root@controlplane:/etc/kubernetes/manifests# kubectl describe rolebindings kube-proxy -n kube-system  
Name:         kube-proxy
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  Role
  Name:  kube-proxy
Subjects:
  Kind   Name                                             Namespace
  ----   ----                                             ---------
  Group  system:bootstrappers:kubeadm:default-node-token  
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:/etc/kubernetes/manifests# kubectl auth can-i list pods --as dev-user
no
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:/etc/kubernetes/manifests# kubectl get pods --as dev-user
Error from server (Forbidden): pods is forbidden: User "dev-user" cannot list resource "pods" in API group "" in the namespace "default"
root@controlplane:/etc/kubernetes/manifests# 



Create the necessary roles and role bindings required for the dev-user to create, list and delete pods in the default namespace

Role: developer
Role Resources: pods
Role Actions: list
Role Actions: create
RoleBinding: dev-user-binding
RoleBinding: Bound to dev-user


root@controlplane:/etc/kubernetes/manifests# kubectl create role devloper --verb=create --verb=list --verb=delete --resource=pods --dry-run=client -o yaml > dev_role.yaml
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:/etc/kubernetes/manifests# kubectl create rolebinding dev-user-binding --role=developer --user=dev-user --dry-run=client -o yaml > dev_rolebinding.yaml
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:/etc/kubernetes/manifests# kubectl apply -f dev_rolebinding.yaml
rolebinding.rbac.authorization.k8s.io/dev-user-binding created
root@controlplane:/etc/kubernetes/manifests# kubectl get pods --as dev-user
NAME                  READY   STATUS    RESTARTS   AGE
red-c898cbdc6-54wnb   1/1     Running   0          14m
red-c898cbdc6-gb459   1/1     Running   0          14m
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:/etc/kubernetes/manifests# kubectl get role
NAME        CREATED AT
developer   2021-09-23T09:06:28Z
root@controlplane:/etc/kubernetes/manifests# kubectl get rolebinding
NAME               ROLE             AGE
dev-user-binding   Role/developer   86s
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:~# kubectl auth can-i list pods -n blue  
yes
root@controlplane:~# 




root@controlplane:~# kubectl create role deploy-role --verb=create --resource=deployments --dry-run=client -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: blue
  name: deploy-role
rules:
- apiGroups:
  - apps
  resources:
  - deployments
  verbs:
  - create
root@controlplane:~# 


root@controlplane:~# kubectl create rolebinding dev-user-deploy-binding  --role=deploy-role --user=dev-user --dry-run=client -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: blue
  name: dev-user-deploy-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: deploy-role
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: dev-user
root@controlplane:~# 





root@controlplane:~# kubectl apply -f deploy-role-rolebinding.yaml
role.rbac.authorization.k8s.io/deploy-role created
rolebinding.rbac.authorization.k8s.io/dev-user-deploy-binding created
root@controlplane:~# cat deploy-role-rolebinding.yaml
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: blue
  name: deploy-role
rules:
- apiGroups:
  - apps
  - extensions
  resources:
  - deployments
  verbs:
  - create
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: blue
  name: dev-user-deploy-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: deploy-role
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: dev-user
root@controlplane:~# 

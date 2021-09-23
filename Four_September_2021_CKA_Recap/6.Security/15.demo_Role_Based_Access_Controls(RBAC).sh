RoleBasedAccesControl(RBAC)
-------------------------------->
How to Create a role 
==============================================>

MacBook-Pro:6.Security bharathdasaraju$ kubectl create role developer --verb=get --verb=list --verb=watch --resource=pods --dry-run=client -o yaml > deveoper-role.yaml
MacBook-Pro:6.Security bharathdasaraju$ 


MacBook-Pro:6.Security bharathdasaraju$ kubectl apply -f deveoper-role.yaml
role.rbac.authorization.k8s.io/developer created
MacBook-Pro:6.Security bharathdasaraju$ 

MacBook-Pro:6.Security bharathdasaraju$ kubectl describe role developer
Name:         developer
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources  Non-Resource URLs  Resource Names  Verbs
  ---------  -----------------  --------------  -----
  pods       []                 []              [get list watch create update delete]
MacBook-Pro:6.Security bharathdasaraju$ 


MacBook-Pro:6.Security bharathdasaraju$ kubectl apply -f deveoper-role.yaml 
role.rbac.authorization.k8s.io/developer configured
MacBook-Pro:6.Security bharathdasaraju$ kubectl describe role developer
Name:         developer
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources  Non-Resource URLs  Resource Names  Verbs
  ---------  -----------------  --------------  -----
  ConfigMaP  []                 []              [create delete]
  pods       []                 []              [get list watch create update delete]
MacBook-Pro:6.Security bharathdasaraju$ 


Create a RoleBinding:
==============================================>

RoleBinding is to assign that created to role to specific user/group

MacBook-Pro:6.Security bharathdasaraju$  kubectl create rolebinding devuser-developer-binding --role=developer --user=dev-user --dry-run=client -o yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: devuser-developer-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: developer
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: dev-user
MacBook-Pro:6.Security bharathdasaraju$

MacBook-Pro:6.Security bharathdasaraju$  kubectl create rolebinding devuser-developer-binding --role=developer --user=dev-user --dry-run=client -o yaml > devuser-developer-binding.yaml
MacBook-Pro:6.Security bharathdasaraju$ 

MacBook-Pro:6.Security bharathdasaraju$ kubectl apply -f devuser-developer-binding.yaml
rolebinding.rbac.authorization.k8s.io/devuser-developer-binding created
MacBook-Pro:6.Security bharathdasaraju$ kubectl describe rolebinding devuser-developer-binding
Name:         devuser-developer-binding
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  Role
  Name:  developer
Subjects:
  Kind  Name      Namespace
  ----  ----      ---------
  User  dev-user  
MacBook-Pro:6.Security bharathdasaraju$ 

note that roles and rolebindings falls under the scope of the namespaces.

where as 

clusterrole and clusterrolebinding falls under the scope of the cluster.



MacBook-Pro:6.Security bharathdasaraju$ kubectl get roles
NAME        CREATED AT
developer   2021-09-23T07:32:54Z
MacBook-Pro:6.Security bharathdasaraju$ kubectl get rolebindings
NAME                        ROLE             AGE
devuser-developer-binding   Role/developer   4m25s
MacBook-Pro:6.Security bharathdasaraju$ 


how to check can i have acces to particular resource in kubernetes:
--------------------------------------------------------------------------------->
MacBook-Pro:6.Security bharathdasaraju$ kubectl auth can-i create deployments
yes
MacBook-Pro:6.Security bharathdasaraju$ kubectl auth can-i delete nodes
Warning: resource 'nodes' is not namespace scoped
yes
MacBook-Pro:6.Security bharathdasaraju$ 




MacBook-Pro:6.Security bharathdasaraju$ kubectl auth can-i delete nodes --as dev-user
Warning: resource 'nodes' is not namespace scoped
no
MacBook-Pro:6.Security bharathdasaraju$ kubectl auth can-i delete secrets --as dev-user
no
MacBook-Pro:6.Security bharathdasaraju$ kubectl auth can-i create secrets --as dev-user
no
MacBook-Pro:6.Security bharathdasaraju$ kubectl auth can-i create services --as dev-user
no
MacBook-Pro:6.Security bharathdasaraju$ kubectl auth can-i create pods --as dev-user
yes
MacBook-Pro:6.Security bharathdasaraju$ kubectl auth can-i create configmaps --as dev-user
no
MacBook-Pro:6.Security bharathdasaraju$ 




MacBook-Pro:6.Security bharathdasaraju$ kubectl create role developer_granualr --verb=get --verb=list --verb=watch --resource=pods --dry-run=client -o yaml > deveoper_granualr-role.yaml
MacBook-Pro:6.Security bharathdasaraju$ 

we can also use "ResourceNames" to give access to certain pods alone.

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer_granualr
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
  resourceNames: ["blue", "orange"]
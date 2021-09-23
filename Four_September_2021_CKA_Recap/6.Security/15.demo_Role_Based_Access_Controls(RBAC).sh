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


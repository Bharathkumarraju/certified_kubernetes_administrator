RoleBasedAccesControl(RBAC)
-------------------------------->
How to Create a role 

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
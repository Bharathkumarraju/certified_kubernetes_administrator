The role and rolebindings limit to a namespace level only.

We do create role by defining a Role object.

bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f 2.developer-role.yaml
role.rbac.authorization.k8s.io/developer created
bharathdasaraju@MacBook-Pro (master) $


bharathdasaraju@MacBook-Pro (master) $ kubectl describe  role developer
Name:         developer
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"rbac.authorization.k8s.io/v1","kind":"Role","metadata":{"annotations":{},"name":"developer","namespace":"default"},"rules":...
PolicyRule:
  Resources  Non-Resource URLs  Resource Names  Verbs
  ---------  -----------------  --------------  -----
  ConfigMap  []                 []              [create]
  pods       []                 []              [list get create update delete]
bharathdasaraju@MacBook-Pro (master) $

How link the users to that developer role.
For this we have to create anothet object called RoleBinding.
The RoleBinding object links a user object to a role.


bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f 3.bharathuser-developer-binding.yaml
rolebinding.rbac.authorization.k8s.io/bharathuser-developer-binding created
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl describe rolebinding  bharathuser-developer-binding
Name:         bharathuser-developer-binding
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":\"rbac.authorization.k8s.io/v1","kind":"RoleBinding","metadata":{"annotations":{},"name":"bharathuser-developer-binding","nam...
Role:
  Kind:  Role
  Name:  developer
Subjects:
  Kind  Name         Namespace
  ----  ----         ---------
  User  bharathuser
bharathdasaraju@MacBook-Pro (master) $



bharathdasaraju@MacBook-Pro ~ $ kubectl auth can-i  '*'  '*'
yes
bharathdasaraju@MacBook-Pro ~ $ kubectl auth can-i create pods --all-namespaces
yes
bharathdasaraju@MacBook-Pro ~ $
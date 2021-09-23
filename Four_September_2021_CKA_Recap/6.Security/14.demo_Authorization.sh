once someone get into cluster...what they can do..... thats what authorization defines

What the devlopers can do in k8s cluster
what the external services can do in k8s cluster

we should be giving exact required roles and role binding to the deveopers and service accounts.

Different types of authorization mechanisms available:
---------------------------------------------------------------------------------------------->
1. Node authorization
--------------------->
--> NodeAuthorizer this used by kubelet to communicate with kube-apiserver

2. Attribute Based Access Controls(ABAC)
--------------------------------------->
 we need to maintain a json file by having user(or) group based resource Access
 if any update needed everytime we need to manually edit this policy json file.
 {"kind": "Policy", "spec": { "user": "dev-user-1", "namespace": "*", "resource": "pods", "apiGroup": "*"}}
{"kind": "Policy", "spec": { "user": "dev-users", "namespace": "*", "resource": "pods", "apiGroup": "*"}}

3.RBAC
----------->

here we create a role and assign set of users/groups to that role


4.Webhook:
----------->
What if, if you want to outsource all the authorization mechanisms.
say you want to manage authorization externally not through the builtin mechanisms.

For example: "Open Policy Agent" is a third party tool which helps with admission control and authorization.
we can have a kubernetes makes an API call to the "open policy agent" with the information about the user and his access requirements.
And have the "open policy agent" decide if the user should be permitted or not.


5.AlwaysAllow
--------------------->


6.AlwaysDeny
------------------------------>


in the kube-apiserver service file we can specify which authorization mode is needed. Bydefault it is "AlwaysAllow" mode 

--authorization-mode=Node,RBAC,Webhook


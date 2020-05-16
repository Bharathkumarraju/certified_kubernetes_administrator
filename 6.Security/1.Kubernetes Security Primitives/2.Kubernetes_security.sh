Kubernetes Related security
------------------------------>
What are the risks and what measures do you need to take to secure the cluster.

Kube-apiserver is the centre of all operations within the kubernetes.

We interact with it through the kubectl utility (or) by accessing the API directly
and through this we can perform almost any operation on the cluster.

So we need to secure the Kube-Apiserver:
------------------------------------------>

1. Who can access the kubernetes cluster
2. What can they do in the kubernetes cluster

Who can access the kube-apiserver is defined by the authentication mechanisms.
-------------------------------------------------------------------------------->

There are different ways that we can authenticate to the APIServer.
1. Files - User IDs and Passwords stored in static files
2. Files - User IDs and tokens
3. Certificates
4. External Authentication Providers(LDAP)

Finally for machines we create the serviceaccounts.
5. Service Accounts

Once they gain access to the cluster what can they do is defined by authorization mechanisms
--------------------------------------------------------------------------------------------->
Authorization is implemented using ROle Based Access COntrol(RBAC) where users are associated
to groups with specific permissions.
1. RBAC Authorization
In addition to RBAC there are other authorization module like
2. Attribute based access control(ABAC)
3. Node Authorization
4. Webhook Mode















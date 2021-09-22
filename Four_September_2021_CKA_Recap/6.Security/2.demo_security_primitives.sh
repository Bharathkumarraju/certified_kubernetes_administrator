kubernetes related security

secure the "kube-apiserver" in two ways

1. who can access the kube-apiserver --> "Authentication" like username and passwords, username and Tokens,
   Certificates, External Authentication providers(LDAP) and for machines its Service Accounts

2. What can they do in kube-apiserver --> "Authorization" using RBAC Authorization, Node Authorization, Webhook mode, 
   ABAC Authorization(Attribute Based Access Controls)

   All communication between k8s components achieved with TLS encryption.

   How about between application --> by default all pods can access all other pods with in the cluster,
   we can use "network policies" to restrict the access between pods.


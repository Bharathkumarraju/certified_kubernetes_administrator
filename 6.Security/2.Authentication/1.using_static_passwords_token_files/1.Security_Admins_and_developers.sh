Kubernetes does not manage user accounts natively.
It relies on the external source like
1. A file user details
2. Certifiates
3. THird party identity service like LDAP to manage users.

ANd so you can not create users in a k8s cluster or view the users.

However in case of service accounts kubernetes can manage them.
So we can create and manage the service accounts using the kubernetes API.

All user access is managed by the Kube-APIserver.
------------------------------------------------->

Whether you access kubernetes cluster through the kubectl (or) API all requests go through the kube-apiserver

So the kube-apiserver authenticates the requests before processing it.

How does the kube-apiserver authenticates:
---------------------------------------------------->
There are different authentication mechanisms that can be configured.
1. You can have a list of usernames and passwords in a static password file. (or)
2. Usernames and tokens in a static token file. (or)
3. We can authenticate using certificates. (or)
4. Connect to thirdparty authentication protocols like LDAP, Kerberos etc...


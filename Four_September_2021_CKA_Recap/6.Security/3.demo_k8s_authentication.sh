k8s can be accessbed by
1. Admins  --> ClusterAdmin
2. Developers  --> Application Developers who gonna host an application in k8s
3. Endusers --> applications hosted in pods can be accessed 

4. Bots(Service Accounts, Other services, third party services)



Users are managed by "kube-apiserver"
------------------------------------------->
1. Static Password File
2. Static Token File
3. Certificates
4. Identity services(LDAP, kerberos)


1. Static Password File
user-details.csv
--------------------------->
password123,user1,u001
password12,user2,u002

kube-apiserver.service:
------------------------>
--basic-auth-file=user-details.csv
curl -vk https://master-node-ip:6443/api/v1/pods -u "user1:password123"


2. Static Token File

user-token-details.csv:
-------------------------->
sdjhflsdfiriwlerwqerowpjf84043w,user10,u001
wewerweirwreowwoewqerowpjf8werw,user11,u002

kube-apiserver.service:
---------------------------------------------->
--token-auth-file=user-token-details.csv
curl -vk https://master-node-ip:6443/api/v1/pods --header "Authorization: Bearer sdjhflsdfiriwlerwqerowpjf84043w"


Certificates:
----------------------------------------------------->
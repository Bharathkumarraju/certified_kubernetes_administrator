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



Create a file with user details locally at /tmp/users/user-details.csv
# User File Contents
password123,user1,u0001
password123,user2,u0002
password123,user3,u0003
password123,user4,u0004
password123,user5,u0005


/etc/kubernetes/manifests/kube-apiserver.yaml
----------------------------------------------------------------------------->
apiVersion: v1
kind: Pod
metadata:
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
      <content-hidden>
    image: k8s.gcr.io/kube-apiserver-amd64:v1.11.3
    name: kube-apiserver
    volumeMounts:
    - mountPath: /tmp/users
      name: usr-details
      readOnly: true
  volumes:
  - hostPath:
      path: /tmp/users
      type: DirectoryOrCreate
    name: usr-details



Modify the kube-apiserver startup options to include the basic-auth file
----------------------------------------------------------------------------------------->
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --authorization-mode=Node,RBAC
      <content-hidden>
    - --basic-auth-file=/tmp/users/user-details.csv


Create the necessary roles and role bindings for these users:
------------------------------------------------------------------->

---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]

---
# This role binding allows "jane" to read pods in the "default" namespace.
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: user1 # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io

after running above we can access kube-apiserver as --> curl -v -k https://localhost:6443/api/v1/pods -u "user1:password123"


Certificates:
----------------------------------------------------->
1. TLS Basics
2. TLS in kubernetes - Certificate creation




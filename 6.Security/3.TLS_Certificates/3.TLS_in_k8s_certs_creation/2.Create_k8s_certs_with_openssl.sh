openssl:
------------------------------------------------------------------------->

Certificate Authority(CA) certificates: ca.key and ca.crt
---------------------------------------------------------------->
1. First we create a private key using the openssl command.

$ openssl genrsa -out ca.key 2048
bharathdasaraju@MacBook-Pro TLSCERTS $ openssl genrsa -out ca.key 2048
Generating RSA private key, 2048 bit long modulus
......................................+++
..................................+++
e is 65537 (0x10001)
bharathdasaraju@MacBook-Pro TLSCERTS $

bharathdasaraju@MacBook-Pro TLSCERTS $ ls -rtlh
total 8
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 16:24 ca.key
bharathdasaraju@MacBook-Pro TLSCERTS $

2. Then we use openssl requests command along with the key we just created to generate a
certificate signing request.
The certificate signing request is like a certificate with all of your details but with no signature.
In the certificate signing request we specified the
     1. name of the component this certificate is for in the common name or CN field
in this since we are creating certificate for kubernetes we name it as "KUBERNETES-CA".

$ openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
bharathdasaraju@MacBook-Pro TLSCERTS $ openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -rtlh
total 16
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 16:24 ca.key
-rw-r--r--  1 bharathdasaraju  staff   895B May 20 16:32 ca.csr
bharathdasaraju@MacBook-Pro TLSCERTS

3. Finally we sign the certificate using the "openssl x509" command and by specifying the certificate signing request
   we generated in the previous command.
Since this is for the CA itself, it is self signed by the CA using its own private key(ca.key) that
it generated in first step.

$ openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
bharathdasaraju@MacBook-Pro TLSCERTS $ openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
Signature ok
subject=/CN=KUBERNETES-CA
Getting Private key
bharathdasaraju@MacBook-Pro TLSCERTS $
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -rtlh
total 24
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 16:24 ca.key
-rw-r--r--  1 bharathdasaraju  staff   895B May 20 16:32 ca.csr
-rw-r--r--  1 bharathdasaraju  staff   989B May 20 16:40 ca.crt
bharathdasaraju@MacBook-Pro TLSCERTS $

So going forward for all certificates we will use this ca key pair to sign them.
The CA now has the private key(ca.key) and the root certificate file(ca.crt)

Lets generate client certificates:
---------------------------------------------------------------------------------------------------->
1. ADMINS  --> admin.crt and admin.key
---------------------------------------->
1. generate admin.key using openssl

bharathdasaraju@MacBook-Pro admin $ openssl genrsa -out admin.key 2048
Generating RSA private key, 2048 bit long modulus
....+++
......................................................................................................+++
e is 65537 (0x10001)
bharathdasaraju@MacBook-Pro admin $ ls -lrth
total 8
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 21:48 admin.key
bharathdasaraju@MacBook-Pro admin $

2. We then generate a CSR and that is where we specify the name(common name) of the admin user which kube-admin.
A quick note about the name, it does not really have to be kube-admin, it could be anything.
But remember this is the name that kubectl client authenticates with when you run kubectl command.
So in the audit logs and elsewhere this is the name("kube-admin") that you will see.
So provide a relevant name("kube-admin") in this field.

bharathdasaraju@MacBook-Pro admin $ openssl req -new -key admin.key  -subj "/CN=kube-admin" -out admin.csr
bharathdasaraju@MacBook-Pro admin $ ls -rtlh
total 16
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 21:48 admin.key
-rw-r--r--  1 bharathdasaraju  staff   891B May 20 21:54 admin.csr
bharathdasaraju@MacBook-Pro admin $

3. Fianlly, generate a signed certificate using openssl x509 command.
   But this time you specify the CA certificate and the CA key.you are signing your certificate with the CA key pair.
   That makes this valid certificate within your cluster.The signed certificate is then output to the admin.crt file.
   That is the certificate that the admin user will use to authenticate to k8s cluster.

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt
Signature ok
subject=/CN=kube-admin
Getting CA Private Key
ca.srl: No such file or directory
4641332844:error:02FFF002:system library:func(4095):No such file or directory:/AppleInternal/BuildRoot/Library/Caches/com.apple.xbs/Sources/libressl/libressl-47.100.4/libressl-2.8/crypto/bio/bss_file.c:255:fopen('ca.srl', 'r')
4641332844:error:20FFF002:BIO routines:CRYPTO_internal:system lib:/AppleInternal/BuildRoot/Library/Caches/com.apple.xbs/Sources/libressl/libressl-47.100.4/libressl-2.8/crypto/bio/bss_file.c:257:
bharathdasaraju@MacBook-Pro TLSCERTS $

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl x509 -req -in admin.csr -CAcreateserial -CA ca.crt -CAkey ca.key -out admin.crt
Signature ok
subject=/CN=kube-admin
Getting CA Private Key
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -rtlh
total 56
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 16:24 ca.key
-rw-r--r--  1 bharathdasaraju  staff   895B May 20 16:32 ca.csr
-rw-r--r--  1 bharathdasaraju  staff   989B May 20 16:40 ca.crt
-rw-r--r--  1 bharathdasaraju  staff   891B May 21 16:36 admin.csr
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 21 16:36 admin.key
-rw-r--r--  1 bharathdasaraju  staff    17B May 21 16:40 ca.srl
-rw-r--r--  1 bharathdasaraju  staff   985B May 21 16:40 admin.crt
bharathdasaraju@MacBook-Pro TLSCERTS $

So if you look at it, the whole process of generating a key and a certificate pair is similar to creating a user account for a new user.
The certificate is the validated userID and key is like the password.
its just that its much more secure than a simple username and password. so this is for the admin user.

Q: How do you differentiate this user from any other users?
A: The user account needs to be identified as an admin user not just another basic user.
   we can do that by adding the group details for the user in the certificate.
   in this case a group named SYSTEM:MASTERS exists on the kubernetes with administrative privileges.
   it is important to know that you must mention this information in your certificate siging request.
   you can do this by adding group details with the OU parameter("system:masters") while generating a certificate signing request(CSR).
   once its signed we now have our certificate for the admin user with admin privileges.

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr
bharathdasaraju@MacBook-Pro TLSCERTS $ openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt
Signature ok
subject=/CN=kube-admin/O=system:masters
Getting CA Private Key
bharathdasaraju@MacBook-Pro TLSCERTS $

We follow the same process to generate client certificates for all other components that access the kube-apiserver.


2. KUBE-SCHEDULER  --> scheduler.crt and scheduler.key
------------------------------------------------------------------------------>
The kube-scheduler is a system component part of the kubernetes control plane.
so its name must be pre-fixed with the keyword "system". i.e "SYSTEM.KUBE-SCHEDULER"

3. KUBE-CONTROLLER-MANAGER --> controller-manager.crt and controller-manager.key
----------------------------------------------------------------------------------------->
The same with the Kube-Controller-manager. It is again a system component. so its name must be prefixed with keyword "system".
i.e. "SYSTEM.KUBE-CONTROLLER-MANAGER"

4. KUBE-PROXY --> kube-proxy.crt and kube-proxy.key
--------------------------------------------------------------->
Fianlly kube-proxy, we follow same process to create key, csr  and crt certificates.

So far we have created CA certificates, then all of the client certificates including the admin user,scheduler,controller-manager, kube-proxy.

We will follow the same procedure to create the remaining 3 client certificates for the apiservers and kubelets when we create the server certificates for them.
5. KUBE-APISERVER --> apiserver-kubelet-client.crt and apiserver-kubelet-client.key
6. KUBE-APISERVER --> apiserver-etcd-client.crt and apiserver-etcd-client.key
7. KUBELET-SERVER --> kubelet-client.crt and kubelet-client.key

Now what do you do with these certificates?

Take the admin certificate for instance to manage the k8s cluster.
you can use the admin certificate instead of a user and password in a REST API call you make to the kube-apiserver.
you specify the key, the certificate and the ca certific as options. Thats one simple way.
Other way us to move all these parameters into a configuration file called kube-config(4.Access_k8s_api_with_config_file.yaml).
within kube-config we specify the API server endpoint details, the certificates to use etc..this is what most of the k8s clients use.

curl https://kube-apiserver:6443/api/v1/pods \
  --key admin.key --cert admin.crt --cacert ca.crt

Before moving to server certificates remember,
For the clients to validate certificate sent by the server and vice versa they all need a copy of the certificate authorities public certificate
( i.e. the one that we said is already installed within the users browsers in case of a web application ).
Similarly, in kubernetes for these various components to verify each other, they all need a copy of the CAs root certificate(ca.crt).

So whenever you configure a server or a client with certificates you will need to specify the CA root certificate(ca.crt) as well.


Lets generate server certificates:
---------------------------------------------------------------------------------------------------->

1. ETCD-SERVER  --> etcdserver.key  and etcdserver.crt
--------------------------------------------------------->
We will follow same process to generate certificate for ETCD-SERVER as well.
ETCD-server can be deployed as cluster across multiple servers as in high availability environment.
In that case to secure communication between the different members in the cluster, we must generate additional peer certificates as well.
etcdpeer1.crt and etcdpeer1.key / etcdpeer2.crt and etcdpeer2.key

Once the certificates are generated specify them while starting the ETCD server. There are key and cert file options where you specify the etcdserver keys.
There are other options available for specifying the peer certificates.
And finally as we discussed earlier it requires the CA root certificate to verify the clients that are connecting to the ETCD server are valid.

Since etcd server deployed as a static pod you can specify the certs in yaml file(5.example_certs_in_etcd.yaml):
----------------------------------------------------------------------------------------------------------------------------------------->>
        - --cert-file=/path-to-certs/etcdserver.crt
        - --key-file=/path-to-certs/etcdserver.key
        - --peer-cert-file=/path-to-certs/etcdpeer1.crt
        - --peer-key-file=/path-to-certs/etcdpeer1.key
        - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
        - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt



2. KUBE-APISERVER --> apiserver.crt and apiserver.key
----------------------------------------------------------------------------------------------------------------------------------------

1. We generate a certificate for the API server like before, But wait the API server is the most popular of all components within the cluster.

kubernetes
kubernetes.default
kubernetes.default.svc
kubernetes.default.svc.cluster.local

Everyone talks to the kube-api server. Every operation goes through the kube-api server.
Anything moves within the cluster the API server knows about it.
lets say you need information you talk to the API server and so it goes by many names and aliases within the cluster.

Its real name is kube-apiserver, but some call it as kubernetes itself.
Because for a lot of people who dont really know what goes under the hoods of kubernetes,
the kube-apiserver is "kubernetes".

Others like to call it as "kubernetes.default"

while some refer to it as "kubernetes.default.svc"

and some like to call it by its full name i.e. "kubernetes.default.svc.cluster.local"

Finally, it is also referred simply by its IP address(10.96.0.1) in some places.
The IP address of the host(172.17.0.87) running the kube-apiserver or the pod (10.96.0.1)running it.

So all these names must be present in the certificate generated for the kube-apiserver.
only then those referring to kube-apiserver by these names will be able to establish a valid connection.

So we use the same set of commands as earlier to generate a key(apiserver.key)
In the certificate signing request(CSR) we specify the name KUBE-APIserver.
But how do we specify all the alternate names.

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl genrsa -out apiserver.key 2048
Generating RSA private key, 2048 bit long modulus
....................................+++
.............................+++
e is 65537 (0x10001)
bharathdasaraju@MacBook-Pro TLSCERTS $

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl req -new -key apiserver.key -subj "/CN=kube-apiserver" -out apiserver.csr
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -rtlh
total 72
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 16:24 ca.key
-rw-r--r--  1 bharathdasaraju  staff   895B May 20 16:32 ca.csr
-rw-r--r--  1 bharathdasaraju  staff   989B May 20 16:40 ca.crt
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 21 16:36 admin.key
-rw-r--r--  1 bharathdasaraju  staff   928B May 22 10:07 admin.csr
-rw-r--r--  1 bharathdasaraju  staff    17B May 22 10:08 ca.srl
-rw-r--r--  1 bharathdasaraju  staff   1.0K May 22 10:08 admin.crt
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 23 14:43 apiserver.key
-rw-r--r--  1 bharathdasaraju  staff   899B May 23 14:44 apiserver.csr
bharathdasaraju@MacBook-Pro TLSCERTS $

But how do we specify all the alternate names.
For that you must create an openssl config file. create an openssl.cnf file and specify the alternate names.
Pass this config file as an option while generating the certificate signing request.

bharath $ openssl req -new -key apiserver.key -subj "/CN=kube-apiserver" -out apiserver.csr -config openssl.cnf
bharath $

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl req -new -key apiserver.key -subj "/CN=kube-apiserver" -out apiserver.csr -config openssl.cnf
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -lrth
total 80
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 16:24 ca.key
-rw-r--r--  1 bharathdasaraju  staff   895B May 20 16:32 ca.csr
-rw-r--r--  1 bharathdasaraju  staff   989B May 20 16:40 ca.crt
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 21 16:36 admin.key
-rw-r--r--  1 bharathdasaraju  staff   928B May 22 10:07 admin.csr
-rw-r--r--  1 bharathdasaraju  staff    17B May 22 10:08 ca.srl
-rw-r--r--  1 bharathdasaraju  staff   1.0K May 22 10:08 admin.crt
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 23 14:43 apiserver.key
-rw-r--r--  1 bharathdasaraju  staff   425B May 23 15:07 openssl.cnf
-rw-r--r--  1 bharathdasaraju  staff   1.1K May 23 15:07 apiserver.csr
bharathdasaraju@MacBook-Pro TLSCERTS $

view openssl-apiserver.cnf
------------------->
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = kubernetes
DNS.2 = kubernetes.default
DNS.3 = kubernetes.default.svc
DNS.4 = kubernetes.default.svc.cluster.local
DNS.5 = k8s-master.local
IP.1 = 10.254.0.1
IP.2 = 192.168.1.230


and finally sign the certificate(openssl x509) using the CA certificate and key.
we then have the kube-apiserver certificate.
openssl x509 -req -in apiserver.csr -CA ca.crt -CAkey ca.key -out apiserver.crt

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl x509 -req -in apiserver.csr -CA ca.crt -CAkey ca.key -out apiserver.crt
Signature ok
subject=/CN=kube-apiserver
Getting CA Private Key
bharathdasaraju@MacBook-Pro TLSCERTS $
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -lrth
total 88
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 20 16:24 ca.key
-rw-r--r--  1 bharathdasaraju  staff   895B May 20 16:32 ca.csr
-rw-r--r--  1 bharathdasaraju  staff   989B May 20 16:40 ca.crt
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 21 16:36 admin.key
-rw-r--r--  1 bharathdasaraju  staff   928B May 22 10:07 admin.csr
-rw-r--r--  1 bharathdasaraju  staff   1.0K May 22 10:08 admin.crt
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 23 14:43 apiserver.key
-rw-r--r--  1 bharathdasaraju  staff   425B May 23 15:07 openssl.cnf
-rw-r--r--  1 bharathdasaraju  staff   1.1K May 23 15:07 apiserver.csr
-rw-r--r--  1 bharathdasaraju  staff    17B May 23 15:16 ca.srl
-rw-r--r--  1 bharathdasaraju  staff   989B May 23 15:16 apiserver.crt
bharathdasaraju@MacBook-Pro TLSCERTS $


It is time to look at where we are going to specify these keys.
Remember to consider the apiserver client certificates that are used by the apiserver while communicating
as a client to the etcd and kubelet servers.

apiserver client certificates:
------------------------------->
1. KUBE-APISERVER --> apiserver-kubelet-client.crt and apiserver-kubelet-client.key
2. KUBE-APISERVER --> apiserver-etcd-client.crt and apiserver-etcd-client.key

The location of these certificates are passed into the kube-apiserver executable or service configuration.

1. First The CA file needs to be passed in. Remember every component needs the CA certificate to verify its clients
2. Then we provide the apiserver certificates under the "tls-cert" options
3. We then specify the client certificates used by the kube-apiserver to the etcd server , again with the CA file.
4. And finally the kube-apiserver client client certificate to connect to kubelets.


KUBE-APISERVER:
---------------->
ExecStart=/usr/loca/bin/kube-apiserver \\
  --advertise-address=${INTERNAL_IP} \\
  ...
  ...
  --client-ca-file=/var/lib/kubernetes/ca.pem \\
  ...
  --tls-cert-file=/var/lib/kubernetes/apiserver.crt \\
  --tls-private-key-file=/var/lib/kubernetes/apiserver.key \\
  ...
  --etcd-cafile=/var/lib/kubernetes/ca.pem \\
  --etcd-certfile=/var/lib/kubernetes/apiserver-etcd-client.crt \\
  --etcd-keyfile=/var/lib/kubernetes/apiserver-etcd-client.key \\
  ...
  --kubelet-certificate-authority=/var/lib/kubernetes/ca.pem \\
  --kubelet-client-certificate=/var/lib/kubernetes/apiserver-kubelet-client.crt \\
  --kubelet-client-key=/var/lib/kubernetes/apiserver-kubelet-client.key \\


3. KUBELET-SERVER --> kubelet.crt and kubelet.key
---------------------------------------------------------------------------------------------------------------------------------------->

THE kubelet server is an HTTPS API Server that runs on each node, responsible for managing the node.
Thats were the KUBELET-SERVER talks to monitor the node as well as any information regarding what pods to schedule on this node.

As such you need a key-certificate pair for each node in the cluster.

Now what do you name these certificates...Are they all going to be names kubelets? No.
They will be named after their nodes. node01, node02 and node03 etc...
once the certificates are created, use them in the kubelet-config file.

1. As always first you specify the root CA certificate.
2. And then provide the kubelet node certificates.
We must do this for all nodes in the cluster.

kubelet-config.yaml(node01)
------------------------------>
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  x509:
    clientCAFile: "/var/lib/kubernetes/ca.pem"
authorization:
  mode: webhook
clusterDomain: "cluster.local"
clusterDNS:
  - "10.32.0.10"
podCIDR: "${POD_CIDR}"
resolvConf: "/run/systemd/resolve/resolv.conf"
runtimeRequestTimeout: "15m"
tlsCertFile: "/var/lib/kubelet/node01.crt"
tlsPrivateKeyFile: "/var/lib/kubelet/node01.key"



There also a set of client certificates that will be used by the kubelet to communicate with the kube-apiserver.
These are used by kubelet to authenticate into the kube-apiserver.They need to generated as well.

What do you name these certificates.
The APISERVER needs to know which node is authenticated and give it the right set of permissions.
so it requires nodes to have the right names in the right format.

since the nodes are the system components,
like the kube-scheduler and controller-manager the format starts with the "system" keyword followed by node and then the node name(node01,node02,node03).

And how would the apiserver give the node to right set of permissions.
as we specified a group name for the admin user (-subj "/CN=kube-admin/O=system:masters") so the admin user gets administrative privileges.

similarly, the nodes must be added to a group named "system:nodes"

KUBELET-SERVER --> kubelet-client.crt and kubelet-client.key
------------------------------------------------------------------------>
once the certificates are generated they go into the kube-config files
















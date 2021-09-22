Server certificate for Server components in k8s :
--------------------------------------------------->
1."kube-apiserver"  --> apiserver.crt and apiserver.key
2."etcd server"  --> etcdserver.crt and etcdserver.key
3."kubelet server" --> kubelet.crt and kubelet.key

Client certificates for Client components in k8s:
--------------------------------------------------------->
4."admins(we)" --> we need admin.crt and admin.key to authenticate with the "kube-apiserver"
5."kube-scheduler" --> scheduler.crt and scheduler.key 
6."kube-controller-manager" --> controller-manager.crt and controller-manager.key
7."kube-proxy" --> kube-proxy.crt and kube-proxy.key 
8."apisever-etcd client" --> apiserver-etcd-client.crt  and apiserver-etcd-client.key
9."apiserver-kubelet client" --> apiserver-kubelet-client.crt and apiserver-kubelet-client.key 

CA Certs:
---------------------------------------------------------->
10. "CA certs" --> ca.crt and ca.key 


to generate certs we can use "openssl" tool(Someother tools easyrsa and cfssl also available)


"tls certs generation for CA":
------------------------------------------------------------------------------------------------------------------------------->
1. "generate private key for CA i.e. ca.key":

MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl genrsa -out ca.key 2048
Generating RSA private key, 2048 bit long modulus
...................................................................+++
........+++
e is 65537 (0x10001)
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 

2. "Generate csr(certificate signing request) using ca.key":

MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ ls
ca.csr  ca.key
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 

3. "Sign the csr and create crt using with self-signed private key(ca.key)":

MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt
Signature ok
subject=/CN=KUBERNETES-CA
Getting Private key
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 

going forrward we will use the CA key pairs to sign them.
the CA now has its own "private key(ca.key)" and the "root certificate(ca.crt)" file.



"Generate client tls certificates":
------------------------------------------------------------------------------------------------------------------------------->
"admins(we)" --> we need admin.crt and admin.key to authenticate with the "kube-apiserver"

1. "generate private key for admin i.e. admin.key":
----------------------------------------------------------------------->
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl genrsa -out admin.key 2048
Generating RSA private key, 2048 bit long modulus
....................+++
............................................+++
e is 65537 (0x10001)
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ ls
admin.key       ca.crt          ca.csr          ca.key
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 

2. "Generate csr(certificate signing request) using admin.key":
----------------------------------------------------------------------->
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl req -new -key admin.key -subj "/CN=kube-admin" -out admin.csr
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ ls
admin.csr       admin.key       ca.crt          ca.csr          ca.key
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 

While creating csr we can specify groups(O=system:masters) for k8s admin privileges
like i.e.  openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr

3. "Sign the csr and create crt using with the CA private key and public key(CA keypairs generated in last step)":
-------------------------------------------------------------------------------------------------------------------->
This make this as valid certificate with in the entire cluster.

MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl x509 -req -in admin.csr -CA ca.crt -CAkey ca.key -out admin.crt
Signature ok
subject=/CN=kube-admin
Getting CA Private Key
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ ls
admin.crt       admin.csr       admin.key       ca.crt          ca.csr          ca.key          ca.srl
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 

What we can do with admin.key and admin.crt is we can authenticate kube-apiserver using this private and public keys like below

"curl https://kube-apiserver:6443/api/v1/pods --key admin.key --cert admin.crt --cacert ca.crt"




Kube-apiserver is kubernetes 
-------------------------------------------------------->
kubernetes
kubernetes.default
kubernetes.default.svc
kubernetes.default.svc.cluster.local


1. "generate private key":
------------------------------------------------------------->
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl genrsa -out apiserver.key 2048
Generating RSA private key, 2048 bit long modulus
..................................................................................................................................+++
.....+++
e is 65537 (0x10001)
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ ls
admin.crt       admin.csr       admin.key       apiserver.key   ca.crt          ca.csr          ca.key          ca.srl
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 


2. "generate csr with lot of alternative names" using a file called openssl-apiserver.conf
---------------------------------------------------------------------------------------->
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl req -new -key apiserver.key -subj "/CN=kube-apiserver" -out apiserver.csr -config openssl-apiserver.conf 
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ ls
admin.crt               admin.key               apiserver.key           ca.csr                  ca.srl
admin.csr               apiserver.csr           ca.crt                  ca.key                  openssl-apiserver.conf
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 


3. "Sign the csr and create crt using with the CA private key and public key(CA keypairs generated in last step)":
--------------------------------------------------------------------------------------------------------------------------->
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl x509 -req -in apiserver.csr -CA ca.crt -CAkey ca.key -out apiserver.crt
Signature ok
subject=/CN=kube-apiserver
Getting CA Private Key
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ ls
admin.crt               admin.key               apiserver.csr           ca.crt                  ca.key                  openssl-apiserver.conf
admin.csr               apiserver.crt           apiserver.key           ca.csr                  ca.srl
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 

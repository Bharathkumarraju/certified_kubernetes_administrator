"Server Certificates":  Serving certificates
-------------------------------------------------->
"private_key": my-bank.key(my-bank-key.pem) 
"public_key": mybank.pem(mybank.crt)



"Certificate Authority": Root certificates
----------------------------------------------->
CA has its own set of private and public_keys
CA public keys already available in all browsers to validate its signed by correct CA


"Client Certificates":
-------------------------------------------------->
client.key(client-key.pem)  --> "private key"
client.pem(client.crt)  --> "public key"

In kubernetes communication between all the k8s components needs to be secured.
i.e. kube-apiserver to kube-scheduler....kubelet to kube-apiserver ...kube-apiserver to kube-controllermanager etc...


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

The server components also talks to themseves as well...lets say "kube-apiserver" talks to "etcd-server" ..
so at that time kube-apiserver is client for the etcd-server...kube-apiserver can use same server certificates (or) we can generate another certs for this purpose only.
8."apisever-etcd client" --> apiserver-etcd-client.crt  and apiserver-etcd-client.key

and also kube-apiserver talks to the kubelet server, so at that time kube-apiserver is client for kubelet 
kube-apiserver can use same server certificates (or) we can generate another certs for this purpose only.
9."apiserver-kubelet client" --> apiserver-kubelet-client.crt and apiserver-kubelet-client.key 


Of course we need Certificate Authority(CA) to sign abd validate above all 9 certificates.
CA has its own certs i.e. 10. "CA certs" --> ca.crt and ca.key 






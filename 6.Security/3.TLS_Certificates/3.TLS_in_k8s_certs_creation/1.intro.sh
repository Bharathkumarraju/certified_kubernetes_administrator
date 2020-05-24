How to generate the certificates for the kubernetes cluster:
------------------------------------------------------------------->
To generate certificates there are different tools available such as
1. easyrsa
2. openssl
3. cfssl   etc and many others.

Certificates in kubernetes cluster:
------------------------------------------------------------------------------>
Certifictae Authority(CA)
----------------------------->
1.CA --> ca.crt and ca.key

Client certificates for clients:
---------------------------------------------------------------------------------->
1. ADMINS            --> admin.crt and admin.key
2. KUBE-SCHEDULER    --> scheduler.crt and scheduler.key
3. KUBE-CONTROLLER-MANAGER --> controller-manager.crt and controller-manager.key
4. KUBE-PROXY   --> kube-proxy.crt and kube-proxy.key
apiserver client certificates:
------------------------------->
5. KUBE-APISERVER --> apiserver-kubelet-client.crt and apiserver-kubelet-client.key
6. KUBE-APISERVER --> apiserver-etcd-client.crt and apiserver-etcd-client.key
7. KUBELET-SERVER --> kubelet-client.crt and kubelet-client.key

Server certificates for servers:
--------------------------------->
1. ETCD SERVER  --> etcdserver.crt  and etcdserver.key
2. KUBE-APISERVER --> apiserver.crt and apiserver.key
3. KUBELET-SERVER --> kubelet.crt and kubelet.key


openssl:
------------------------------------------------------------------------->
How to create the CA certificates





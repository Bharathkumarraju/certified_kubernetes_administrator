K8S cluster consist of master and worker nodes.

Ofcourse all communication between these nodes need to be secured and must be encrypted.

All interactions between all services and their clients need to be secure as well.

For example an administrator interacting with the kuberbetes cluster through the kubectl utility
or via accessing the kuberbetes API directly must establish secure TLS connection.

Communication between all the components with in the kuberbetes cluster also need to be secured.

So the two primary requirements are to have
1. All the various services within the cluster to use server certificates.
2. All clients to use client certificates to verify they are who they say they are.

Server certificates for servers:
------------------------------------------------------------------------------------------->
1. Kube-apiserver: apiserver.crt and apiserver.key
--------------------------------------------------->
The APIserver exposes an HTTPS service that other components as well as external users use to manage the k8s cluster.
So it is the server and it requires certificates to secure all communication with its clients.

So we generate a certificate and keypair called APIserver.crt and APIserver.key
i.e. anything with a .crt extension is the certificate and .key extension is the private key.

Another server in the cluster is ETCD Server.

2.ETCD Server: etcdserver.crt and etcdserver.key
---------------------------------------------------->
The ETCD server stores all information about the cluster so it requires a pair of certificate and key for itself.
we call it as ETCDserver.crt and ETCDserver.key

The other server component on the cluster is on the worker nodes i.e. KUBELET Server

3.KUBELET Server: kubelet.crt and kubelet.key
--------------------------------------------------->
kubelet services also exposes an HTTPs API endoints that the kube-apiserver talks to interact with the worker nodes.

Again that requires a certificate(kubelet.crt) and keypair(kubelet.key)


Client certificates for Clients:
-------------------------------------------------------------------------------------------------------------------->
The clients who access the kube-apisever

1. us the administrators through kubectl or through the rest API(admin.crt and admin.key)
------------------------------------------------------------------------------------------>
i.e. the admin user requires a certificate and a key pair to authenticate the kube-apiserver.
we call it as the  admin.crt and admin.key

2.Kube-scheduler: scheduler.crt and scheduler.key
------------------------------------------------------------------------------------------->
The scheduler talks to the kube-apiserver to look for pods that require scheduling and then
get the apiserevr to schedule the pods on the right worker nodes.

The scheduler is a client that accesses the kube-apiserver.
As for as the kube-apiserver is concerned, the scheduler is just another client like the admin user.
so the scheduler need to validate its identity using a client TLS certificate.

so scheduler needs its own pair of certificate and keys.
we will call it as scheduler.crt and scheduler.key

3.Kube-Controller Manager: controller-manager.crt and controller-manager.key
-------------------------------------------------------------------------------------------------------------->
The Kube-Controller Manager is another client that accesses the kube-apiserver.

So it also requires a certificate authentication to the kube-apiserver.
So we create certificate pair for it we call it as controller-manager.crt and controller-manager.key

4.Kube-proxy: kube-proxy.crt and kube-proxy.key
-------------------------------------------------------------------------------------------------------------->
The kube-proxy requires a client certificate to authenticate to the kube-apiserver
and so it requires its own pair of certificate and keys.

We call them as kube-proxy.crt and kube-proxy.key



The servers communicate among themselves also needs TLS certificates.
For example, the kube-apiserver communicates with ETCD server.

Infact of all the components the kube-apiserver is the only server that talks to the ETCD server.

so as far as the ETCD server is concerned the kube-apiserver is a client.so it needs to authenticate.
The kube-apiserver can use the same keys that it used earlier for serving its own API service.
i.e. apiserver.crt and apiserver.key files.  or generate new ones specifically
for this purpose.

kube-apiserver also talks to the kubelet server on each of the individual nodes.Thats how it monitors the worker nodes.
For this again it can use the original certificates(apiserver.crt and apiserver.key) or generate new ones specifically
for this purpose.


-------------------------------------------------------------------------------------------------------------------------->

There are a set of client certificates mostly used by clients to connect to the kube-apiserver.
And there are set of server certificates used by the kube-apiserver, etcd-server and kubelet-server to authenticate their clients.


Now how to generate all these client and server side certificates:
=================================================================================>
as we already knew we need a certificate authority(CA) to sign all these certificates.

kuberbetes requires you to have one certificate authority(CA) for your cluster.
infact you can have more than one certificate authorities(CAs).

lets say 1. one CA for all the components in the cluster.
         2. and another one specifically for the ETCD.

In this case the ETCDservers serever certificates and ETCDservers client certificates which in this case
is the apiservers client certificates will be all signed by the ETCDServers CA.

For now we will stick to just one CA for our cluster.
The CA as we know has its own pair of certificate and key. we call it as "ca.crt" and "ca.key"


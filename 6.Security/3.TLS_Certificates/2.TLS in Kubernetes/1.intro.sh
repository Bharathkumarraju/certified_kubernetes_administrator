Securing kubernets cluster with TLS certificates:
---------------------------------------------------->

How a server uses public and private keys to secure connectivity.
We will call them as serving certificates.

We know what is Certificate Authority(CA) is.

CA has its own set of public and private key pairs that it uses to sign server certificates.
We will call them as root certificates.
We also saw how a server can request a client to verify themselves using client certificates.

So 3 types of certificates.
Server certificates configured on the servers.
Root certificates configured on the CA servers.
Client certificates configured on the clients.

And quick note on naming

publickeys:         privatekeys:
----------->        ------------>
server.crt          server.key
server.pem          server-key.pem
client.crt          client.key
client.pem          client-key.pem




We knew why we want to encrypt messages being sent over a network.

To encrypt messages we use asymmetric encryption with a pair of public and private keys.
And admin uses a pair of keys to secure SSH connectivity to the servers.

The server uses a pair of keys to secure HTTPS traffic. But for this
1. The server first sends a certificate signing request(CSR) to a CA.
2. Ths CA uses its private key to sign the CSR.
3. Remember all users around the world have a copy of the CAs public key.
4. The signed certificate is then sent back to the server. the server configures the web application with  the signed certificate.

5. So whenever a user accesses the web application the server first sends the certificate with its public key.
6. The user (or) rather users browser reads the certificate and uses the CAs public key to validate and retrives the servers public key.

7. Then the browser generates a symmetric key that it wishes to use going forward for all communication.
8. The symmetric key is encrypted using the servers public key and send back to the server.
9. The server uses its private key to decrypt the message and retrieve the symmetric key.
10. The symmetric key is used for communication going forward.

11. So the administrator generates a key pair for securing SSH.
12. The web server generates a key pair for securing the website with HTTPS.
14. The Certificate Authority generates its own set of key pairs to sign certificates.
15. The enduser(browser) though only generates a single symmetric key when he access web application first time.
16. Once he establishes trust with the website he uses his username/password to authenticate to the web server.

17. With the servers key pairs, the client is able to validate that the server is who they say they are.
    but the server does not for sure know if the client is who they say they are.

18. It could be a hacker impersonatig a user by somehow gaining access to his credentials not over the network for sure.
    as we have secured it already with TLS. May be by some other means.

Anyway What can the server do to validate the client is who they say they are
--------------------------------------------------------------------------------------->
For this as part of the initial trust building excercise

1.The server can request a certificate from the client and so the client must generate a pair of keys and a signed certificate from a valid CA.
2. The client then sends the certificate to the server for it to verify the client is who they say they are.

Now you must be thinking you have never generated a clients certificate to access a website.

Well thats becasue TLS client certificates are not generally implemented on webservers, even if they are its all implemented under the hood.
So in normal user dont have to generate and manage certificates manually.


So this whole infrastructure ...i.e.
---------------------------------------->
including the CA, the servers, the people and the process of generating distributing and maintaining digital certificates is known as
Pulic Key Infrastructure(PKI).


As we are using the analogy of a key and lock for private and public keys.

Public Key and Private Keys are infact two related and paired keys.
You can encrypt data with any one of them and only decrypt data with other.
you can not encrypt data with one and decrypt with the same.

So you must be careful what you encrypt your data with.
If you encrypt your data with your private key then remember anyone with your public key which could really be
anyone out there will be able to decrypt and read your message.


Naming Conventions:
---------------------------------->

Usaully certificates with public key are named ".crt" or ".pem"
server.crt
server.pem
client.crt
client.pem

usually certificates with privates are name ".key" or "-key.pem"
server.key
server-key.pem
client.key
client-key.pem
































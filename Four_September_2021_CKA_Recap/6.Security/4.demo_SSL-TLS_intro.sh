Sender --------> Reciever

"symmetric encryption": Same key is used to encrypt and decrypt both at sender-end and reciever-end 

"asymmetric encryption":  This encryption uses pair of keys, a private key and a public key



ssh-key example:
--------------------->

in the users system:
----------------------------------------------->
ssh-keygen generates both private and public keys
id_rsa
id_rsa.pub

in the servers ~/.ssh/Authorizedkeys:
-------------------------------------------------------------------------------------------------------------------------->
copy users public key(id_rsa.pub) to servers Authorizedkeys file to securely access the server(using asymmetric encryption)



Web servers example:
---------------------------------------------------------->
as we did it in ssh-keygen(which creates private and public keys) we can do same for webserver TLS encryption also 
to generate private and public key pair can use "openssl"

private key(my-bank.key) creation:
--------------------------------------->
openssl genrsa -out my-bank.key 1024

public key(mybank.pem) creation:
-------------------------------------------------->
openssl rsa -in my-bank.key -pubout > mybank.pem


MacBook-Pro:6.Security bharathdasaraju$ mkdir generate_tls_public-private_keys
MacBook-Pro:6.Security bharathdasaraju$ cd generate_tls_public-private_keys
MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ openssl genrsa -out my-bank.key 1024
Generating RSA private key, 1024 bit long modulus
.++++++
................................................................++++++
e is 65537 (0x10001)
MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ ls -rtlh
total 8
-rw-r--r--  1 bharathdasaraju  staff   887B 22 Sep 16:47 my-bank.key
MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ 


MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ openssl rsa -in my-bank.key -pubout > mybank.pem
writing RSA key
MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ ls -rlth
total 16
-rw-r--r--  1 bharathdasaraju  staff   887B 22 Sep 16:47 my-bank.key
-rw-r--r--  1 bharathdasaraju  staff   272B 22 Sep 16:48 mybank.pem
MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ 


How to sign certificates with certificate authority:
---------------------------------------------------------->
popular CAs are symantec, global sign, digicert etc..

Certificate Signing Request(CSR)
-------------------------------------------------------------->
We need to generate a Certificate Signing Request(CSR) by using the private key(my-bank.key) we generated earlier

openssl req -new -key my-bank.key -out my-bank.csr -subj "/C=SG/ST=SG/O=my-bank, Inc./CN=my-bank.com"

MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ openssl req -new -key my-bank.key -out my-bank.csr -subj "/C=SG/ST=SG/O=my-bank, Inc./CN=my-bank.com"
MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ ls -rtlh
total 24
-rw-r--r--  1 bharathdasaraju  staff   887B 22 Sep 16:47 my-bank.key
-rw-r--r--  1 bharathdasaraju  staff   272B 22 Sep 16:48 mybank.pem
-rw-r--r--  1 bharathdasaraju  staff   607B 22 Sep 17:11 my-bank.csr
MacBook-Pro:generate_tls_public-private_keys bharathdasaraju$ 

the certificate authorities check our csr file and sign and send the certificates to us.

how to make sure that the certificate is signed by legitimate CA....
like CA is a valid CA and that the certificate is infact signed by Symantec and not by some fake CA names semantech.

The CAs themselves have set of public and private keypairs.
The CA is use their private keys to sign the certificates,  the public keys of all the CAs are built in to the browsers as shown in the image CAs_pulbic_certs_in_browser.png


The public keys of all the CAs are built in to the browsers.

The browser uses the public key of the CA to validate that the certificate is actually signed by the CA themselves.
Now these are the public CAs that help us ensure the public websites we visit, like our banks, email etc are legitimate.


However they dont help you to validate sites hosted privately say within your organization.
For example, for accessing your payroll or internal email applications.For that you can host your own private CAs.


Most of the companies like Symantec,Comodo,GlobalSign,digicert have a private offering of their services.
A CA server that you can deploy internally with in your company.
You can then have the public key of your internal CA server installed on all your employees browsers and establish secure connectivity
within your organization.



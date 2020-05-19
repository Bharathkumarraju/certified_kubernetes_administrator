How to create a legitimate certificate for your web servers that teh web browsers will trust.

CERTIFICTAE AUTHORITY(CA):
------------------------------------------------------------------>
How do you get your certificates signed by someone with authority.
Thats where the Certificate Authorities (or) CAs comes in.
They are well known organizations that can sign and validate your certificates for you.

Some of the popular certs are Symantec, Digicert, Comodo, GlobalSign etc...

How CA works:
------------------------------------------------------------------------->
The way it works is, you generate a Certificate Signing Request(CSR) using the key you generated.
and the domain name(my-bank.com) of your website.
private key "openssl genrsa -out my-bank.key 1024"

Generate the CSR from above key, the below command generates a my-bank.csr file which is the certificate signing request
that should be sent to the CA for signing.

openssl req -new -key my-bank.key -out my-bank.csr -subj "/C=SG/ST=SG/O=my-bank, Inc./CN=my-bank.com"

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl req -new -key my-bank.key -out my-bank.csr -subj "/C=SG/ST=SG/O=my-bank, Inc./CN=my-bank.com"
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -rtlh
total 24
-rw-r--r--  1 bharathdasaraju  staff   887B May 17 08:22 my-bank.key
-rw-r--r--  1 bharathdasaraju  staff   272B May 17 08:27 my-bank.pem
-rw-r--r--  1 bharathdasaraju  staff   607B May 19 10:55 my-bank.csr
bharathdasaraju@MacBook-Pro TLSCERTS $

So the certificate Authorities verify your details and once they checks out they sign the certificate and send it back to you.
You now have a certificate signed by a CA that the process trust.

If hacker tried to get his certificate signed the same way he would fail during the validation phase and his certificate would be rejectedby the CA.
So the website that he is hosting wont have a valid certificate.

The CAs use different techniques to make sure that you are the actual owner of that domain.

You now have a certificate signed by CA that the browser can trust.
But how do the browsers know that the CA itself is legitimate, For example what if the certificate is signed by fake CA.

Lets say in this case our certificate is signed by Symantec.
how would the browser know Symantec is valid CA and that the certificate is infact signed by Symantec and not by some fake CA names semantech...
The CAs themselves have set of public and private keypairs.
The CA is use their private keys to sign the certificates the public keys of all the CAs are built in to the browsers.

The public keys of all the CAs are built in to the browsers.
In chrome --> goto settings, click Show advanced settings...under HTTPS/SSL click Manage certificates to view all installed certificates.

The browser uses the public key of the CA to validate that the certificate is actually signed by the CA themselves.
We can actual see them in the settings of your web browser, under certificates..they are under "trusted root certification authorities"..

Now these are the public CAs that help us ensure the public websites we visit, like our banks, email etc are legitimate.

However they dont help you to validate sites hosted privately say within your organization.
For example, for accessing your payroll or internal email applications.
For that you can host your own private CAs.

Most of the companies like Symantec,Comodo,GlobalSign,digicert have a private offering of their services.
A CA server that you can deploy internally with in your company.
You can then have the public key of your internal CA server installed on all your employees browsers and establish secure connectivity
within your organization.



















































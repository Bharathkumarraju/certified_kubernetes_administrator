How to manage certificates in kubernetes and what is certificate API.

As an k8s admin - in the process of setting up the whole k8s cluster have set up a CA server and bunch of certificates for various components.

we then started the services using the right certificates and its all up and working.

And the only administrator and user of the k8s cluster and i have my own admin certificate and the key.
and the new admin comes into my team, he needs access to the cluster, we need to get his a pair of certificate and key pair for him to access the k8s cluster.

So for that, he creates his own private key, generates a certificate signing request and sends it to me.
Since Iam the only admin i then takes the certificate signing request(CSR) to my CA server, gets it signed by the CA server using the
CA servers private key and root certificates(public key), there by generating a certificate and then sends the certificate back to him.

He has  now his own valid pair of certificate and key the he can use to access the cluster.
The certificates have a validated period it ends after a period of time.
Everytime it expires we follow the same process of generating a new CSR and getting it signed by the CA.

So we keep rotating the certificate files. So we keep talking about the CA server.
What is the CA server and where it is located in the kubernetes setup?

The CA is really just a pair of key and certificate files we have generated.
whoever gains access to these pair of files, can sign any certifiate for the kubernetes environment.
They can create as many users as they want and whatever privileges they want.

So these files need to be protected and stored in a safe environment.
Say we place them on a server that is fully secure. Now that server is called CA server. The certificate key file safely stored in that server
and only on that server everytime you want to sign a certificate you can only do it by logging into that server.

As of now we have the certificates placed on the kubernetes master node itself.
So the master node is also our CA server.

The kubeadm tool does the same thing. It creates a CA pair of files and stores that on the master node itself.

So far we have been signing requests manually but as and when users increase and team grows we need better automated way to manage
the certificates signing requests as well as to rotate certificates when they expire.

Kubernetes has a built-in Certificates API that can do this for you.
With the certificates API, we now send a CertificateSigningRequest directly to kubernetes through an API call.
This time when the administrator recieves a certificate signing request instead of logging onto the master node and signing the certificate by himself.
He creates a Kubernetes API object called "CertificateSigningRequest"

Once the "CertificateSigningRequest" object is created all certificates and requests can be seen by administrators of the cluster.
The requests can be reviewed and approved easily using kubectl commands.

This certificate can then be extracted and shared with the user.

How to do this?

Example:
------------>
1. A user first creates a key. and then generates a certificate signing request with his name on it.

bharathdasaraju@MacBook-Pro certAPI $ openssl genrsa -out bharath.key 2048
Generating RSA private key, 2048 bit long modulus
............+++
...............................+++
e is 65537 (0x10001)
bharathdasaraju@MacBook-Pro certAPI $

bharathdasaraju@MacBook-Pro certAPI $ openssl req -new -key bharath.key -subj "/CN=bharath" -out bharath.csr
bharathdasaraju@MacBook-Pro certAPI $ ls -rtlh
total 16
-rw-r--r--  1 bharathdasaraju  staff   1.6K May 25 08:32 bharath.key
-rw-r--r--  1 bharathdasaraju  staff   887B May 25 08:34 bharath.csr
bharathdasaraju@MacBook-Pro certAPI $


2. Then sends the request to the administrator. the administrator takes the key and creates a "CertificateSigningRequest" object.

The "CertificateSigningRequest" is created like any other kubernetes object using a manifest file with the usual fields.
The kind is "CertificateSigningRequest" under the spec section,
specify the groups the user should be part of and list the usages of the account as list of strings.

the request filed is where you specify the certificate signing request sent by the user.
But you wont specify as plain text, instead it must be encoded using the base64 command(as below) then move the encoded text into the requeast field.
and then submit the request.

bharathdasaraju@MacBook-Pro certAPI $ cat bharath.csr | base64
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1Z6Q0NBVDhDQVFBd0VqRVFNQTRHQTFVRUF3d0hZbWhoY21GMGFEQ0NBU0l3RFFZSktvWklodmNOQVFFQgpCUUFEZ2dFUEFEQ0NBUW9DZ2dFQkFMbGZ0WVJVNlRlZEhnYU5yZFNZK1l6eE9qS3dWSWVHQjlSOTdlQllFSzZMCnp6RlQrZE0xdzZhczFEN0RCenYvL3BlWm91aWNacU93bDhCOUhNTVlrMWV5enVRMGVVRENMSk1UVTI4aVU0cmoKcEE5ZXV4UXFSVTVGYUFwaU9JcDkwV01UZDNGR2djSGhBWDBzSlVMc2VaZXNxYnVRaW9nV01CQS9NM3VmSUw4RgpmWHBVVmVHYW1vMVFjRExpMkUvL1h2aHhIbXVOaFhRMTJOa1cveUpYRDVzdG1ISWxsZ2hFakJhVzlJZFRSTE1YCjh6eHBud0V0RFpKSzhUL0hvQWhYbnprL2V3NGF6aHVPNTBRb0twOHZGYlk3TmFvSFFOYm5iVDZVbk1DMzV0NkEKSFB2Zi9UL050TDROZFpPWlVScVZLRXpTUUVmN1REc0dXbkMwMHp6UFJnc0NBd0VBQWFBQU1BMEdDU3FHU0liMwpEUUVCQ3dVQUE0SUJBUUJDSWl2cUg3OCtBNHNwY0U0Z1RXckVDTHlMSGlLT2tkcUhURUFCK1BhRTJ6NUhVTDl3Cm9id3RUcnNxNjg4dzQ5L3RVaXpTK2N4VjFLOVNwNndhVzBGaDlJcEJhSkR0WWNtV3VhREZLVUxDU05KWk9GL3oKSUZ6N3pNZjJLQTNGQzJhRmF0ZUwvTUlvUXBPV3UxTDlsVGJPN1lBWEkvaWd0bXRNOWk2WEZDT0dVK0RmVm5HcwppZFRESXg2MVpRSEgrQWVaTS9ZWmlQU3RtSkF5dW5qSjUydmQ2YmRqbXlybnpTYkpDVW41R1lwc2dkNjRldmhVCjZtakdYOGJyMmVnMEI3dVJRSzYxVGplRUlFVEMrTUJLamJEUk43Q3RDaUpkblZiNEg0YmtKWE9McnpQVmRaNWYKY1YrZnZYcjRJN3BWYk9Sdmt4VDhsWDhwZ2tsczNFaHpIQmJsCi0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
bharathdasaraju@MacBook-Pro certAPI $



Once the object created, all certificate signing requests can be seen by administrators by running the command "kubectl get csr"

Identify the new request and approve the request by running the command "kubectl certificate approve bharath"
kubernetes signs the certificate using the CA key pairs and generates a certificate for the user.

This certificate can then be extracted and shared with the user.
View the certificate by viewing it in an YAML format.The generated certificate is part of the output.
but as before it is in a base64 encoded format. to decrypt the cert use below command(echo "LSO0jskjsldjl..........." | base64 --decode)

$ kubectl get csr bharath -o yaml

decryt the cert:
------------------>
echo "LSO0jskjsldjl..........." | base64 --decode

Once you decrypt, it gives you the certificate in a plain text format.
This can then be shared with the end user.

So, who does all of this for us. means which of the control plane components is actually responsible for all the certificate related operations.
All the certificate related operations are carried out by the Controller-Manager.

In the Controller-Manager we have controllers called 1.CSR-APPROVING and 2.CSR-SIGNING
these are responsible for carrying out these specific tasks.

We know that if any one has to sign the certificates, they need the CA servers root certificate(ca.crt) and private key(ca.key)


cat /etc/kubernetes/manifests/kube-controller-manager.yaml
-------------------------------------------------------------->
spec:
  containers:
  - command:
    - kube-controller-manager
    ...
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
    ...
    - --root-ca-file=/etc/kubernetes/pki/ca.crt
    ...
    - --service-account-private-key-file=/etc/kubernetes/pki/sa.key
    - --use-service-account-credentials=true









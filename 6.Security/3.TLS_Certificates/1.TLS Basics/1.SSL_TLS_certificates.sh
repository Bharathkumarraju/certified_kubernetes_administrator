A certificate is used to guarantee trust between two parties during a transaction.

For example:
-------------->
A user tries to access a web server, TLS certificates ensures that the communication
between the user and the server is encrypted and the server is who it says it is.

For example without secure connectivity:
----------------------------------------->
Without secure connectivity if a user access his online banking application the credentials he types in
would be sent in plain text format.

so the hackers sniffing network traffic could easily retrive the credentials and use it hack into the
users bank account.

So you must encrypt the data being transferred using encryption keys.
The data encrypted using a key which is basically a set of random numbers ans alphabets,
you add a random number to your data and you encrypted into a format that can not be recognized.
The data is then sent to the server.

The hacker sniffing the network gets the data but can not do anything with it.

However the same is the case with the server recieving the data it can not decrypt that data without the key.
So a copy of the key must also be sent to the server so that the server can decrypt and read the message.

Since the key also sent over the same network, the attacker can sniff that as well decrypt the data with it.
This is known as SYMMETRIC ENCRYPTION

SYMMETRIC ENCRYPTION:
------------------------>
It is a secure way of encryption but since it uses the same key to encrypt and decrypt the data, and since the
key has to be exchanged between the sender and the reciever there is a risk of a hacker gaining access to the key and
decrypting the data.

And thats were  ASYMMETRIC ENCRYPTION comes in.

ASYMMETRIC ENCRYPTION:
----------------------------->
Instead of using a single key to encrypt and decrypt data asymmetric encryption uses a pair of keys,
i.e. 1. A Private Key and 2. A public key

Well they are Private and Public keys but for our understanding for this example we will call it as
1. private key and
2. public lock
Think of it as a key and a lock

A Key(Private key) is only with me, so its private.
A Lock(Publick key) that anyone can access so its public.

The trick here is if you encrypt or lock the data with your lock you can only open it with the associated key.
So your key must always be secure with you and not be shared with anyone else, its private.

But the lock is public and may be shared with others they can only lock something with it.
No matter what is locked using the public lock, it can only be unlocked by your private key.


Before we go back to our web server example lets look at even simpler usecase

securing SSH access to the servers through keypairs:
--------------------------------------------------------->
lets say you have a server in your environment that you need to access to,
and you do not want to use passwords as they are too risky.

So you decide to use key pairs, you generate a public and private key pair.
we can do this by running the "ssh-keygen" command.
it created two files.
1. id_rsa --> is the private key
2. id_rsa.pub --> is the public key( In our example it is called as public lock)

Now we secure our server by locking down all access to it. except through a door that is locked using public lock.
It is usually done by adding an entry with your public key into the servers .ssh authorized_keys file.(~/.ssh/authorized_keys)

So you see the lock is pulic and anyone can attempt to break through.
But as long as on one gets their hands on your private key which is safe with you on your laptop,
No one can gain access to the server.
When you try to SSH you specify the location of your private key in your SSH command.
$ ssh -i id_rsa user1@server1

bharathdasaraju@MacBook-Pro ~ $ ssh -i ~/.ssh/id_rsa bharath@3.228.19.245
Last login: Sat May 16 06:32:46 2020 from bb119-74-194-59.singnet.com.sg
[bharath@ip-172-16-1-144 ~]$

What if you have other servers in your environment?
How do you secure more than one server with your keypair?

Well you can create copies of your public lock and place them on as many servers as you want.
You can use same private key to SSH into all of your severs securely.

What if other users need access to your servers well they can do samething as well,
They can generate their own public and private keypairs as the only person who has access to those servers,
you can create an additional door for them and lock it with their public locks and copy their public locks to all the servers.
And now other users can access the servers using their private keys.

Lets go back to web server example:
--------------------------------------->
You see the problem we had earlier with symmetric encryption was that the key used to encrypt data had to be sent to the server
over the network along with the encrypted data.

And hence there is a risk of the hacker getting the key to decrypt the data.

What if we could somehow get the key to the server safely.Once the key is safely made available to the server, the server and
client can safely continue communication with each other using symmetric encryption.

To securely transfer the symmetric key from the client to the server, We use Asymmetric Encryption.

So, we generate a public and private key pairs on the server. In order to do this,
We use the "openssl" command to generate a private and public key pair.
private key "openssl genrsa -out my-bank.key 1024"
public key "openssl rsa -in my-bank.key -pubout > my-bank.pem"
------------------------------------------------------------------------------------------------------------------------------------------->

So, When the user first accesses the web server using https, he gets the public key from the server.

Since the hacker is sniffing all traffic that is assumed he too gets a copy of the public key.

The user, Infact the users browser then encrypts the symmetric key using the public key provided by the server.
The symmetric key is now secure the user then sends this to the server.

The hacker also gets a copy.

The server uses the private key to decrypt the message and retrieves the symmetric key from it.

However the hacker doest not have the private key to decrypt and retrieve the symmetric key from the message it recieved.
The hacker only has the public key with which he can only lock or encrypt a message and not decrypt the message.

The symmetric key is now safely available only to the user and the server.They can now use the symmetric key to encrypt data
and send to each other, the reciever can use the same symmetric key to decrypt data and retrieve information.

The hacker left with the encrypted messages and public keys with which he can not decrypt any data.

With Asymmetric encryption we have successfully transferred the symmetric keys form the user to the server and
with symmetric encryption we have secured all future communication between them.

But now the hacker looks for new ways to hack into your bank account, and so he relaizes that the only way he can get your
credentials is by getting you to type it into a form he presents. So he creates a website that exactly like your banks website.

The hacker hosts replica of banks website in his own server, he wants you to think it secure too.
The hacker generates his own set of public and private keypairs and configure them on his web server.

And finally hacker somwhow manages to tweak your environment or your network to route your requests going to your banks website to his servers.

When you open up your browser and type the website address in you see "https://my-bank.com" a very similar page as the same of your bank.
so you go ahead and type in username and password. you made sure you typed in HTTPS in the URL to make sure that the communication is secure
and encrypted.

Now your browser recieves the key(public key from the server) and you send encrypted symmetric key and then you send your credentials encrypted with
the symmetric key and the reciever(server) decrypt the credentials with the same symmetric key, that you have been communicating securely
in an encrypted manner but with the hackers server.
As soon as you send in your credentials, you see a dashboard that does not look very much like your backs dashboard.

So What if you could look at the key you recieved from the server and see if it is a legitimate key from the real bank server:
-------------------------------------------------------------------------------------------------------------------------------->
When the server sends the key it does not send the key alone, It sends the certificate that has the key in it.

If you take a closer look at the certificate you will see that it is like an actual certificate but in a digital format.
It has the information about
1. who the certificate is issued to.
2. The Public key of that server.
3. The location of that server etc...

The certificate is look like in the file: "GlobalSign_cert(public_key).pem"
Every certificate has
1. a Name on it the person or subject to whom the certificate is issued to.
This is very important as that is the field that helps you to validate their identity.

If this is for a web server this name must match what the user types in the URL on his browser.

If the bank is known by any other names and if they like their users to access their application with the other names as well.
then all those names should be specified in the certificate under the subject alternative name section.

But you see anyone can generate a certificate like this.
You could generate one for yourself saying you are Google and thats what the hacker did in this case.

Hackers deeds:
----------------->
Hacker generated a certificate saying he is your banks website.
So how do you look at a certificate and verify if it is legit or not.

Check who signed and issued the certificate.
------------------------------------------------>
If you generate the certificate then you will have to sign it by yourself. That is known as a self signed certificate.
Anyone looking at the certificate you generated will immediately know that it is not a safe certificate because you have signed.

If you looked at the certificate you recieved from the hacker closely you would have noticed that it was a fake certificate that was
signed by the hacker himself. As a matter of fact your browser does that for you.

All of the web browsers are built in with a Certificate validation mechanism, wherein the browser checks the certificate recieved from the server
and validates it to make sure it is legitimate.

If it identifies to be a fake certificate then it actually warns you.































































































































































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
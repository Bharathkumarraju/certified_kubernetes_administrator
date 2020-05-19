In the AWS server:
------------------------------------->
[bharath@ip-172-16-1-144 ~]$ pwd
/home/bharath
[bharath@ip-172-16-1-144 ~]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/bharath/.ssh/id_rsa):
Created directory '/home/bharath/.ssh'.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/bharath/.ssh/id_rsa.
Your public key has been saved in /home/bharath/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:aKMG6NSPcZk135IrAp0cS9H+MQ2Mt0P13y3DLi4dWQI bharath@ip-172-16-1-144.ec2.internal
The keys randoma rt image is:
+---[RSA 2048]----+
|     .. o ..     |
|      .o =E .    |
|     o.oo +. .   |
| .. + Boo=o...o o|
|...+ O+ S++. ++.o|
|o  .*o . .o o. o |
| . .oo . . ....  |
|   .  . . ....   |
|           ..    |
+----[SHA256]-----+
[bharath@ip-172-16-1-144 ~]$


[bharath@ip-172-16-1-144 ~]$ cd .ssh
[bharath@ip-172-16-1-144 .ssh]$ ls -rtlh
total 8.0K
-rw-------. 1 bharath bharath 1.7K May 16 05:43 id_rsa
-rw-r--r--. 1 bharath bharath  418 May 16 05:43 id_rsa.pub
[bharath@ip-172-16-1-144 .ssh]$

[bharath@ip-172-16-1-144 .ssh]$ cat authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWxbYYi/mGidrVN0zVSzwJ16RU0WtxA360KTVpUoGqkGxZaAsjEA76MBcUyKpFl3vaoVZI91n5jVO9i8aZCAf0GHwX5DbvZZ65FUZA1MZJXzv2HHU27Ym/api108rKzZr2A87SzSlQrdO8ILUcVbAn5JrzQEEFMMjPdGY8G8e9CsvIPPfwpkyAlCW908BCK1aU9YVqpFbh+Q0Kgcaf2ArKqwl8uO28NB9O6kmvdZcjmlJ962+Vku5CMyNIk697V1wMpEYcyGSHZQ2Q0tF3ElY7X10pEwUbU60jJqFuDn6BvTCcBHx9l8S2YN/eWaLHIhn48eGR2iy0LeHxcBhxW+yR bharathdasaraju@Bharaths-MacBook-Pro.local
[bharath@ip-172-16-1-144 .ssh]$ ls -rlh
total 12K
-rw-r--r--. 1 bharath bharath  418 May 16 05:43 id_rsa.pub
-rw-------. 1 bharath bharath 1.7K May 16 05:43 id_rsa
-rw-rw-r--. 1 bharath bharath  424 May 16 05:45 authorized_keys
[bharath@ip-172-16-1-144 .ssh]$ chmod  640 authorized_keys
[bharath@ip-172-16-1-144 .ssh]$

[bharath@ip-172-16-1-144 .ssh]$ ls -lrth
total 12K
-rw-------. 1 bharath bharath 1.7K May 16 05:43 id_rsa
-rw-r--r--. 1 bharath bharath  418 May 16 05:43 id_rsa.pub
-rw-r-----. 1 bharath bharath  424 May 16 05:45 authorized_keys
[bharath@ip-172-16-1-144 .ssh]$

Now from the local laptop
------------------------------>

bharathdasaraju@MacBook-Pro ~ $ ssh -i ~/.ssh/id_rsa bharath@3.228.19.245 -v
OpenSSH_8.1p1, LibreSSL 2.7.3
debug1: Reading configuration data /Users/bharathdasaraju/.ssh/config
debug1: /Users/bharathdasaraju/.ssh/config line 1: Applying options for *
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: /etc/ssh/ssh_config line 47: Applying options for *
debug1: Connecting to 3.228.19.245 [3.228.19.245] port 22.
debug1: Connection established.
debug1: identity file /Users/bharathdasaraju/.ssh/id_rsa type 0
debug1: identity file /Users/bharathdasaraju/.ssh/id_rsa-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_8.1
debug1: Remote protocol version 2.0, remote software version OpenSSH_7.4
debug1: match: OpenSSH_7.4 pat OpenSSH_7.0*,OpenSSH_7.1*,OpenSSH_7.2*,OpenSSH_7.3*,OpenSSH_7.4*,OpenSSH_7.5*,OpenSSH_7.6*,OpenSSH_7.7* compat 0x04000002
debug1: Authenticating to 3.228.19.245:22 as 'bharath'
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: algorithm: curve25519-sha256
debug1: kex: host key algorithm: ecdsa-sha2-nistp256
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug1: Server host key: ecdsa-sha2-nistp256 SHA256:Tl/CdVpvQg7A5ZU58WQ1ViNWL77AsxJzaYVR/Q3MzZY
debug1: Host '3.228.19.245' is known and matches the ECDSA host key.
debug1: Found key in /Users/bharathdasaraju/.ssh/known_hosts:61
debug1: rekey out after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: rekey in after 134217728 blocks
debug1: Will attempt key: /Users/bharathdasaraju/.ssh/id_rsa RSA SHA256:jqmymvhoN6l+40SOEhHcPhmS0O6KDo/WZKXF5AiDncQ explicit
debug1: SSH2_MSG_EXT_INFO received
debug1: kex_input_ext_info: server-sig-algs=<rsa-sha2-256,rsa-sha2-512>
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic
debug1: Next authentication method: publickey
debug1: Offering public key: /Users/bharathdasaraju/.ssh/id_rsa RSA SHA256:jqmymvhoN6l+40SOEhHcPhmS0O6KDo/WZKXF5AiDncQ explicit
debug1: Server accepts key: /Users/bharathdasaraju/.ssh/id_rsa RSA SHA256:jqmymvhoN6l+40SOEhHcPhmS0O6KDo/WZKXF5AiDncQ explicit
debug1: Authentication succeeded (publickey).
Authenticated to 3.228.19.245 ([3.228.19.245]:22).
debug1: channel 0: new [client-session]
debug1: Requesting no-more-sessions@openssh.com
debug1: Entering interactive session.
debug1: pledge: network
debug1: client_input_global_request: rtype hostkeys-00@openssh.com want_reply 0
debug1: Requesting authentication agent forwarding.
debug1: Sending environment.
debug1: Sending env LC_ALL = en_US.UTF-8
debug1: Sending env LANG = en_US.UTF-8
debug1: Sending env LC_CTYPE = UTF-8
Last login: Sat May 16 06:33:04 2020 from bb119-74-194-59.singnet.com.sg
[bharath@ip-172-16-1-144 ~]$





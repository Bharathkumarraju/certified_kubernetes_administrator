Domain Name Resolution:
-------------------------------------------------------------------------------------------------------------------------------------------->

We have two hosts --> hostA and hostB ...both are part of same network.

hostA (eth0) --------------------------192.168.1.0------------------- (eth0) hostB
(192.168.1.10)                                                        (192.168.1.11)
ping 192.168.1.11
reply from 192.168.1.11: bytes=32 time=4ms TTL=117
reply from 192.168.1.11: bytes=32 time=4ms TTL=117


and we know that hostB has dabase services running on them. so instead of having to remember the IP Address of hostB, we decided to give it a name "DB"
Going forward we would like to ping hostB with the name "DB" instead of its IP Address.

to do that add an entry in "/etc/hosts" file of "hostA"
echo "192.168.1.11  db" >> /etc/hosts

so here, we told hostA that IP at 192.168.1.11 is a host named "db"

there is a catch here: hostA does not check to make sure if hostBs actual name is DB.
For example running a `hostname` command on hostB  reveals that it is named "host-2" but hostA doesnot care.It goes by whats in the /etc/hosts file.

we can even put "192.168.1.11  www.google.com"
then "ping db" and "ping www.google.com" we will get response from hostB. We have two names pointing to the same system.

"ping db"
"ssh db"
"curl http://www.google.com"

above three domain-names points to hostB.

any ping/ssh/curl to the name, first it looks into the /etc/hosts file to findout the IP address of that host.
Translating hostname to IP Address this way is known as Name Resolution.


Within a small network of few systems, we can easily get away with the entries in the /etc/hosts file.
In each system we specify which are the other systems in the environment.


if systems(1000 or mnore) grows many, if any system changes its IP need to change all other systems "/etc/hosts" file.
So to overcome this we move all those entries to one central server called DNS server.

And then we point all hosts to look up that server, if they need to resolve the hostname to an IP address instead of its own /etc/hosts files.

How do we point our host to DNS server:
------------------------------------------------------------------------>
DNS_Server_IP: 192.168.1.100

Every host has DNS resolution configuration file at /etc/resolv.conf, We can add an entry into it by adding the IPAddress of DNS server.

cat /etc/resolv.conf
nameserver 192.168.1.100

so if the same entry found at both "/etc/hosts" and DNSserver then priority goes to local lookup only i.e. "/etc/hosts".
but we can change this order of lookup by adding an entry in the file "/etc/nsswitch.conf" file.

cat /etc/nsswitch.conf
...
hosts: files dns 
...

what if we "ping www.apple.com" it will fail cause we dont have any emntry for "www.apple.com" in both "/etc/hosts" file and in "DNS Server"
we can add another entry in "/etc/resolv.conf" file like below "nameserver 8.8.8.8" is a common well-known public name server available on the internet.
cat >> /etc/resolv.conf
nameserver 192.168.1.100
nameserver 8.8.8.8


for example if you want to map "web" to "web.mycompany.com" internally in your organization:
------------------------------------------------------------------------------------------------>
add an entry in "/etc/resolv.conf" as "search   mycompany.com"

cat >> /etc/resolv.conf
nameserver   192.168.1.100
search       mycompany.com 


A --> IP to Domain name mapping
CNAME --> Name to Name mapping


"nslookup" does not consider the entries in the local "/etc/hosts" file. "nslookup" only queries the DNS server.

MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ nslookup www.google.com
Server:         8.8.8.8
Address:        8.8.8.8#53

Non-authoritative answer:
Name:   www.google.com
Address: 74.125.24.106
Name:   www.google.com
Address: 74.125.24.147
Name:   www.google.com
Address: 74.125.24.103
Name:   www.google.com
Address: 74.125.24.105
Name:   www.google.com
Address: 74.125.24.104
Name:   www.google.com
Address: 74.125.24.99

MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ 



MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ dig www.google.com

; <<>> DiG 9.10.6 <<>> www.google.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 60793
;; flags: qr rd ra; QUERY: 1, ANSWER: 6, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 512
;; QUESTION SECTION:
;www.google.com.                        IN      A

;; ANSWER SECTION:
www.google.com.         253     IN      A       142.251.10.147
www.google.com.         253     IN      A       142.251.10.105
www.google.com.         253     IN      A       142.251.10.99
www.google.com.         253     IN      A       142.251.10.103
www.google.com.         253     IN      A       142.251.10.104
www.google.com.         253     IN      A       142.251.10.106

;; Query time: 120 msec
;; SERVER: 8.8.8.8#53(8.8.8.8)
;; WHEN: Mon Sep 27 05:42:46 +08 2021
;; MSG SIZE  rcvd: 139

MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ 












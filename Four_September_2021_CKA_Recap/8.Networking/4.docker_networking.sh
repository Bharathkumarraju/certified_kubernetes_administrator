"docker run  --network none nginx" 

"docker run --network host nginx"


"docker run --network bridge nginx"


bharath@bkubuntu:~$ docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
f2db6773d503   bridge    bridge    local
a1ce19f62cfa   host      host      local
a1d8d71f1d61   none      null      local
bharath@bkubuntu:~$ 

bharath@bkubuntu:~$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 42:01:0a:b4:10:06 brd ff:ff:ff:ff:ff:ff
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:48:99:09:93 brd ff:ff:ff:ff:ff:ff
5: veth3b4f54b@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP mode DEFAULT group default 
    link/ether ee:bb:07:7c:1f:71 brd ff:ff:ff:ff:ff:ff link-netnsid 0
bharath@bkubuntu:~$ 


bharath@bkubuntu:~$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP group default qlen 1000
    link/ether 42:01:0a:b4:10:06 brd ff:ff:ff:ff:ff:ff
    inet 10.180.16.6/32 scope global dynamic ens4
       valid_lft 3302sec preferred_lft 3302sec
    inet6 fe80::4001:aff:feb4:1006/64 scope link 
       valid_lft forever preferred_lft forever
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:48:99:09:93 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:48ff:fe99:993/64 scope link 
       valid_lft forever preferred_lft forever
5: veth3b4f54b@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
    link/ether ee:bb:07:7c:1f:71 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet6 fe80::ecbb:7ff:fe7c:1f71/64 scope link 
       valid_lft forever preferred_lft forever
bharath@bkubuntu:~$ 

root@bkubuntu:/home/bharath# ip netns list
1cf9ddf0126e (id: 0)
root@bkubuntu:/home/bharath# 

root@bkubuntu:/home/bharath# ip netns list
1cf9ddf0126e (id: 0)
root@bkubuntu:/home/bharath#
root@bkubuntu:/home/bharath# docker inspect 0afdc5e4383f | grep -iA5 "Bridge"
            "Bridge": "",
            "SandboxID": "1cf9ddf0126e70b3bafcbd6348145a4094b4a342b82e9090a0bdd064222af4cb",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
--
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "f2db6773d503c3eaa5aea03d99e6c3033b6aa768b3920303f31a80bc4fd8a3f7",
                    "EndpointID": "59e8399966f71306b79f3e1d5fbd3804378ff63008b3509a18c2e22998bd36ec",
root@bkubuntu:/home/bharath# 


root@bkubuntu:/home/bharath# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether 42:01:0a:b4:10:06 brd ff:ff:ff:ff:ff:ff
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:48:99:09:93 brd ff:ff:ff:ff:ff:ff
5: veth3b4f54b@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP mode DEFAULT group default 
    link/ether ee:bb:07:7c:1f:71 brd ff:ff:ff:ff:ff:ff link-netnsid 0
root@bkubuntu:/home/bharath#


root@bkubuntu:/home/bharath# ip netns list
1cf9ddf0126e (id: 0)
root@bkubuntu:/home/bharath# 

root@bkubuntu:/home/bharath# ip -n 1cf9ddf0126e link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
4: eth0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
root@bkubuntu:/home/bharath# 


network namespace also gets an IPAddress.
root@bkubuntu:/home/bharath# ip -n 1cf9ddf0126e addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
4: eth0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
root@bkubuntu:/home/bharath# 



root@bkubuntu:/home/bharath# ip netns
1cf9ddf0126e (id: 0)
root@bkubuntu:/home/bharath# ip -n 1cf9ddf0126e addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
4: eth0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
root@bkubuntu:/home/bharath# curl http://172.17.0.2:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
root@bkubuntu:/home/bharath# 




root@bkubuntu:/home/bharath# docker run -d -p 8080:80 nginx
bfc28c29eb3ebb88a56ea8f11cee0d44219cb3e0073922699828162f6702218b
root@bkubuntu:/home/bharath# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                   NAMES
bfc28c29eb3e   nginx     "/docker-entrypoint.…"   3 seconds ago    Up 2 seconds    0.0.0.0:8080->80/tcp, :::8080->80/tcp   gracious_snyder
0afdc5e4383f   nginx     "/docker-entrypoint.…"   21 minutes ago   Up 21 minutes   80/tcp                                  agitated_mestorf
root@bkubuntu:/home/bharath# 


MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ curl -k http://35.247.149.114:8080/
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ 


How does the docker forwards port from 8080 to 80.
Docker uses "iptables"

"iptables -t nat -A PREROUTING -j DNAT --dport 8080 --to-destination 80"
"iptables -t nat -A DOCKER -j DNAT --dport 8080 --to-destination 172.17.0.2:80"


root@bkubuntu:/home/bharath# ip netns
802602f4ba1e (id: 1)
1cf9ddf0126e (id: 0)
root@bkubuntu:/home/bharath# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                   NAMES
bfc28c29eb3e   nginx     "/docker-entrypoint.…"   22 minutes ago   Up 22 minutes   0.0.0.0:8080->80/tcp, :::8080->80/tcp   gracious_snyder
0afdc5e4383f   nginx     "/docker-entrypoint.…"   43 minutes ago   Up 43 minutes   80/tcp                                  agitated_mestorf
root@bkubuntu:/home/bharath# 




root@bkubuntu:/home/bharath# iptables -nvL -t nat
Chain PREROUTING (policy ACCEPT 204 packets, 9466 bytes)
 pkts bytes target     prot opt in     out     source               destination         
  371 18908 DOCKER     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ADDRTYPE match dst-type LOCAL

Chain INPUT (policy ACCEPT 204 packets, 9466 bytes)
 pkts bytes target     prot opt in     out     source               destination         

Chain OUTPUT (policy ACCEPT 38 packets, 3115 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 DOCKER     all  --  *      *       0.0.0.0/0           !127.0.0.0/8          ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT 40 packets, 3243 bytes)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 MASQUERADE  all  --  *      !docker0  172.17.0.0/16        0.0.0.0/0           
    0     0 MASQUERADE  tcp  --  *      *       172.17.0.3           172.17.0.3           tcp dpt:80

Chain DOCKER (2 references)
 pkts bytes target     prot opt in     out     source               destination         
    0     0 RETURN     all  --  docker0 *       0.0.0.0/0            0.0.0.0/0           
    2   128 DNAT       tcp  --  !docker0 *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8080 to:172.17.0.3:80
root@bkubuntu:/home/bharath# 

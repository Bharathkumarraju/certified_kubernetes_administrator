Containers are separated from underlying host using namespaces

Our host has its own interfaces that connect to the local area network.
our host has its own routing and ARP tables with information about the rest of the network.

We want to see all of those details from the container.
when the container is created, we create network namespace for it, that way it has no visibility to any network-related information on the host.

within its namespace, the container can have its own virtual interfaces routing and ARP tables.
the container has its own interface.

Create network namespace:
--------------------------------------------------------------->
lets create two network namespaces("red" and "blue")
1. "ip netns add red"
2. "ip netns add blue"

list namespaces  run "ip netns"


root@testvm:/home/bharath# ip netns add red
root@testvm:/home/bharath# ip netns add blue
root@testvm:/home/bharath# ip netns
blue
red
root@testvm:/home/bharath# 


"To list interfaces in the host":
-------------------------------------->
root@testvm:/home/bharath# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 42:01:0a:b4:10:04 brd ff:ff:ff:ff:ff:ff
root@testvm:/home/bharath# 

"how can we view the same interfaces(of course cant see hosts eth0) with in the network namespaces9(red, blue) created":
--------------------------------------------------------------------------------------------------------------------------->
root@testvm:/home/bharath# ip netns exec red ip link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
root@testvm:/home/bharath# ip netns exec blue ip link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
root@testvm:/home/bharath# 


root@testvm:/home/bharath# ip -n red link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
root@testvm:/home/bharath# ip -n blue link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
root@testvm:/home/bharath# 

So with namespaces we have successfully prevented the container from seeing the hosts interface.

"The same is true with the ARP tables. i.e. can see ARP tables in host but not inside namespace i.e. inside container":
---------------------------------------------------------------------------------------------------------------------------->

root@testvm:/home/bharath# arp
Address                  HWtype  HWaddress           Flags Mask            Iface
10.180.16.1              ether   42:01:0a:b4:10:01   C                     ens4
root@testvm:/home/bharath# 

root@testvm:/home/bharath# ip netns exec red arp
root@testvm:/home/bharath# 

"The same is true with the routing tables . i.e. can see route tables in host but not inside namespace i.e. inside container":
------------------------------------------------------------------------------------------------------------------------------->
root@testvm:/home/bharath# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         10.180.16.1     0.0.0.0         UG    0      0        0 ens4
10.180.16.1     0.0.0.0         255.255.255.255 UH    0      0        0 ens4
root@testvm:/home/bharath# ip netns exec red route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
root@testvm:/home/bharath# 

so as of now these namespaces have no network connectivity.
they have no interfaces of their own and they can not see the underlying host network.

"first establish the connectivity between the namespaces(red, blue) themselves:"
------------------------------------------------------------------------------------->
just like how we would connect two physical machines together using a cable to an ethernet interface on each machine.
we can connect two namespaces togethetr using a virtual ethernet pair (or) virtual cable. its often referred to as pipe.
its a virtual cable with two interfaces in either ends.

"to create a virtual cable(veth):"
------------------------------------>
root@testvm:/home/bharath# ip link add veth-red type veth peer name veth-blue
root@testvm:/home/bharath# 

"the next step is to attach each interface to the appropriate namespace":
------------------------------------------------------------------------------->

root@testvm:/home/bharath# ip link set veth-red netns red
root@testvm:/home/bharath# ip link set veth-blue netns blue
root@testvm:/home/bharath# 

root@testvm:/home/bharath# ip -n red link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
4: veth-red@if3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 26:33:7c:ba:ed:3e brd ff:ff:ff:ff:ff:ff link-netns blue
root@testvm:/home/bharath# ip -n blue link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
3: veth-blue@if4: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether a2:09:2b:8d:6b:b6 brd ff:ff:ff:ff:ff:ff link-netns red
root@testvm:/home/bharath# 


"We can then assign IP addresses to each of these namespaces":
----------------------------------------------------------------------------------->
we can use the usual "ip addr" command to assign the IPAddress but within each namespace.

root@testvm:/home/bharath# ip -n red addr add 10.180.16.5 dev veth-red
root@testvm:/home/bharath# ip -n blue addr add 10.180.16.6 dev veth-blue
root@testvm:/home/bharath# 

"we then bring up the interface using the "ip link"":
---------------------------------------------------------------->

root@testvm:/home/bharath# ip -n red link set veth-red up
root@testvm:/home/bharath# ip -n blue link set veth-blue up
root@testvm:/home/bharath# 

"now links are up...try a ping from the red namespace to reach the IP of the blue":
--------------------------------------------------------------------------------------->
root@testvm:/home/bharath# ip netns exec red ping 10.180.16.6
PING 10.180.16.6 (10.180.16.6)  56(84) bytes of data.
64 bytes from 10.180.16.6: icmp_seq=1 ttl=64 time=0.023 ms
root@testvm:/home/bharath# 


root@testvm:/home/bharath# ip netns exec red arp
Address                  HWtype  HWaddress           Flags Mask            Iface
10.180.16.6              ether   21:01:0a:9b:10:1d   C                     veth-red
root@testvm:/home/bharath# 

root@testvm:/home/bharath# ip netns exec blue arp
Address                  HWtype  HWaddress           Flags Mask            Iface
10.180.16.5              ether   09:18:d8:9b:6c:7b   C                     veth-red
root@testvm:/home/bharath# 

"but host doesnt know about these virtual namespace interfaces at all"

"how to connect multiple namespaces"
---------------------------------------->
Just like physical world you create a virtual network inside your host. to create network you need a switch.
so to create a virtual network you need a virtual switch. 

you create a virtual switch witin per host and connect the namespaces with it. 

"how to create a virtual switch within a host":
-------------------------------------------------->
there are multiple options
1. Linux Bridge
2. OpenvSwitch(OvS)

"Linux Bridge:"
--------------------->
to create internal bridge we add a new interface to the host using the "ip link add v-net-o type bridge"

root@testvm:/home/bharath# ip link add v-net-o type bridge
root@testvm:/home/bharath# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 42:01:0a:b4:10:04 brd ff:ff:ff:ff:ff:ff
5: v-net-o: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether d6:f7:70:0b:c7:93 brd ff:ff:ff:ff:ff:ff
root@testvm:/home/bharath# 

"bring v-net-0 interface up"

root@testvm:/home/bharath# ip link set dev v-net-o up
root@testvm:/home/bharath# ip linlk
Object "linlk" is unknown, try "ip help".
root@testvm:/home/bharath# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 42:01:0a:b4:10:04 brd ff:ff:ff:ff:ff:ff
5: v-net-o: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/ether d6:f7:70:0b:c7:93 brd ff:ff:ff:ff:ff:ff
root@testvm:/home/bharath# 

"v-net-0" --> network interface for the host, network switch for the namespaces.

"next step is to connect namespaces with this virtual network switch"
we need to connect all the namespace with the new bridge network, so we need new virtual cable for that purpose.

root@testvm:/home/bharath# ip -n red link del veth-red (when we delete this veth-blue automatically gets deleted also since they were pair.)
root@testvm:/home/bharath# ip -n blue link del veth-blue
Cannot find device "veth-blue"
root@testvm:/home/bharath# 

"Create new virtual cable to connect to new bridge network"
root@testvm:/home/bharath# ip link add veth-red type veth peer name veth-red-br
root@testvm:/home/bharath# ip link add veth-blue type veth peer name veth-blue-br
root@testvm:/home/bharath# 

"now the brides ready ... and connect them with namespaces"

root@testvm:/home/bharath# ip link set veth-red netns red
root@testvm:/home/bharath# ip link set veth-red-br master v-net-o
root@testvm:/home/bharath# ip link set veth-blue netns blue
root@testvm:/home/bharath# ip link set veth-blue-br master v-net-o
root@testvm:/home/bharath# 

"set IP addresses for these links and turn them up"

root@testvm:/home/bharath# ip -n red addr add 10.180.16.10 dev veth-red
root@testvm:/home/bharath# ip -n blue addr add 10.180.16.11 dev veth-blue
root@testvm:/home/bharath# ip -n red link set veth-red up
root@testvm:/home/bharath# ip -n blue link set veth-blue up
root@testvm:/home/bharath# 

root@testvm:/home/bharath# ip addr add 10.180.16.0/24 dev v-net-o
root@testvm:/home/bharath# ping 10.180.16.10
PING 10.180.16.10 (10.180.16.10) 56(84) bytes of data.
64 bytes from 10.180.16.10: icmp_seq=1 ttl=4 time=0.023 ms


"We can even connect other LAN networks from namespace by adding gateway entry in the namespace routetable "

and also we need to add "Natting" rule in the host with below

"iptables -t nat -A POSTROUTING -s 10.180.16.0/24 -j MASQUERADE"

"how to reach the internet from namespace":
------------------------------------------------------------------------------->
root@testvm:/home/bharath# ip netns exec blue ping 8.8.8.8
connect: Network is unreachable
root@testvm:/home/bharath# 



if outside network want to reach the namespace there are two options
1. Add gateway entry in route table to reach namespaces host 
2. add an "iptables entry" i.e. "iptables -t nat -A PREROUTING --dport 80 --to-destination 10.180.16.11:80 -j DNAT"

Switching, Routing, Gateways CNI in kubernetes.


Switching:
-------------------->


system-A(interface)          switch(network-192.168.1.0)         system-B(interface)
(192.168.1.10)                                                      (192.168.1.11)
systemA connects to systemB via switch(switch creates network) using interfaces("eth0").


to see list of interfaces in linux boxes use command "ip link":
------------------------------------------------------------------->

bharath@testvm:~$ sudo su
root@testvm:/home/bharath# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1460 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 42:01:0a:b4:10:03 brd ff:ff:ff:ff:ff:ff
root@testvm:/home/bharath# 



Lets assume network IPAddress is "192.168.1.0"

We then assign the systems with IP address on the same network.

"On systemA:"
---------------------------------------------->
ip addr add 192.168.1.10/24 dev eth0

"on SystemB:"
------------------------------------------------>
ip addr add 192.168.1.11/24 dev eth0


once the links are UP and IP addresses are assigned, the computers can now communicate with eachother through the switch.

the switch can only enable communication within a network which means it can recieve packets 
from a host on the network and deliver it to the other systems within the same network.

"from systemA(192.168.1.10)":
-------------------------------------------------->
ping 192.168.1.11
Reply from 192.168.1.11: bytes=32 time=4ms TTL=117
Reply from 192.168.1.11: bytes=32 time=4ms TTL=117

------------------------------------------------------------------------------------------------------------------------------------------------->

Now lets assume we have another network("192.168.2.0") and another two systems on the network("SystemC-192.168.2.10 and SystemD-192.168.2.11")

"Routing:"
=================================================================================================================>

How does a system in one network reach system in the other network.i.e.
How does  the "sytemB(192.168.1.11)"in one netwrok reach "systemC(192.168.2.10" on the other network.

Thats where the "Router" comes in. "A Router helps connect two networks together"

"Router" is an intelligent device, so think of it as another server with many network ports.
Since it connects to the two separate networks it gets two IPs assigned. One on each network.

In the 1st network we assign "router an IP address 192.168.1.1" and
In the 2nd network we assign "router an IP aadress 192.168.2.1" 
Now we have a router connected to the two networks that can enable communication between them.

Now, when systemB tries to send a packet to systemC, how does it know where the router is on the network to send the packet through?
the router is just another device on the network. There could be many other such devices.

Thats where we configure the systems with "a gateway" or "a route".
If the network is a room, the gateway is a door to the outside world or to the other networks or to the Internet.

The systems need to know where that door is to go through that.

to see the existing routing configuration on the system run the "route" command.
"route" command displays the kernel routing table and within that, as you can see there are no routing configurations as of now.

root@systemB:/home/bharath# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
root@systemB:/home/bharath# 

so in this condtion our "SystemB" will not be able to reach "SystemC", it can only reach other systems in same network in the rane "192.168.1.0"
To configure gateway on "SystemB" to reach the networks on "192.168.2.0", run the "ip route add 192.168.2.0" 
and specify that you can reach the "192.168.2.0" network through the door or gateway at "192.168.1.1" 

the command is -> "ip route add 192.168.2.0/24 via 192.168.1.1"

Run the "route" command again

root@systemB:/home/bharath# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.2.0     192.168.1.1     255.255.255.0   UG    0      0      0   eth0
root@systemB:/home/bharath# 

this route has to configure on all the systems i.e. if "SystemC" is to send back packet to "SystemB" then you need to add route on "SystemC's" routing table as well.
--> "ip route add 192.168.1.0/24 via 192.168.2.1" 

root@systemC:/home/bharath# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     192.168.2.1     255.255.255.0   UG    0      0      0   eth0
root@systemC:/home/bharath# 

----------------------------------------------------------------------------------------------------------------------------------------->

Now lets say these systems needs access to the internet. Say they need access to google at 172.217.194.0 network on the inernet.

so you connect the router to inernet and then add "ip route add 172.217.194.0/24" new route in your routing table to route all traffic to the network 172.217.194.0 through your router.

root@systemC:/home/bharath# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     192.168.2.1     255.255.255.0   UG    0      0      0   eth0
172.217.194.0   192.168.2.1     255.255.255.0   UG    0      0      0   eth0
root@systemC:/home/bharath# 

there are so many different sites on different netwroks on the internet.
instead of adding a routing table entry for the same routers IP address for each of those networks.
you can simply say for any network that you dont know a route to, use this router as the default gateway.
This way any request to any network outside of your exisitng network goes to this particular router.

--> "ip route add default via 192.168.2.1"

root@systemC:/home/bharath# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     192.168.2.1     255.255.255.0   UG    0      0      0   eth0
172.217.194.0   192.168.2.1     255.255.255.0   UG    0      0      0   eth0
default         192.168.2.1     255.255.255.0   UG    0      0      0   eth0
root@systemC:/home/bharath# 

So in a simple setup like this, all you need is a single routing table entry with a default gateway set to the routers IP Address.
Instead of the word "default" we can also say "0.0.0.0/0" it means any IP destination, both are same actually

"ip route add 0.0.0.0/0 via 192.168.2.1"

root@systemC:/home/bharath# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     192.168.2.1     255.255.255.0   UG    0      0      0   eth0
172.217.194.0   192.168.2.1     255.255.255.0   UG    0      0      0   eth0
default         192.168.2.1     255.255.255.0   UG    0      0      0   eth0
0.0.0.0/0       192.168.2.1     255.255.255.0   UG    0      0      0   eth0
root@systemC:/home/bharath# 

A 0.0.0.0/0 entry in the Gateway field indicates that you dont need a Gateway.

for example in this case for "SystemC" to access any devices in the 192.168.2.0 network it doesnt need a Gateway becuae it is in its own network.
But say if we have multiple routers in our network  one for the internet and another for the internal priavte network,
then we will need to have two separate route table entries for each network.

i.e. one entry for the internal priavte network and another entry with the default gateway for all other networks including public networks.
"ip route add 192.168.1.0/24 via 192.168.2.2"
"ip route add default via 192.168.2.1"

root@systemC:/home/bharath# route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.1.0     192.168.2.2     255.255.255.0   UG    0      0      0   eth0
default         192.168.2.1     255.255.255.0   UG    0      0      0   eth0
root@systemC:/home/bharath# 

so if you are having issues reaching internet from your systems need to check this routing table and default gateway configuration.


How to setup linux host a router:
------------------------------------------>

hostA (eth0)------192.168.1.0 -----(eth0) hostB (eth1) ------ 192.168.2.0 ---------(eth0) hostC
(192.168.1.5)               (192.168.1.6)   (192.168.2.6)                           (192.168.2.5)

ping from hostA to hostC:
-------------------------------->
ping 192.168.2.5
Connect: Network is unreachable

We need to tell hostA the door (or) gateway to network(192.168.2.0) is through host B, And we do that by adding routing table entry.

"ip route add 192.168.2.0/24 via 192.168.1.6"

if the packets were get through to hostC, hostC will have to send back responses to hostA.
when hostC tries to reach hostA at 192.168.1.0 netwotk, it would face the same issue.
so we need to let know the hostC to reach hostA through hostB ... here hostB acting as a router.

so we need to add an entry in hostCs routing table as below.
"ip route add 192.168.1.0/24 via 192.168.2.6"

Eventhough we added route table entry in both the hosts..still we are getting network unreachable error thats because

in Linux, packets are not forwarded from one interface to the next ...
i.e. for example packets recieved on eth0 on hostB are not forwarded to elsewhere through eth1, this is this way for security reasons.

for example if you had eth0 connected to your private network and eth1 to a public network,
We dont want anyone from the public network to easily send messages to the private network unless we explicitly allow that.


but in the above example we know that both are private networks and it is safe to enable communication between the two interfaces(eth0 and eth1).
we can allow hostB to forward packets from one network to thee other.

whether a host can forward packets between interfaces is governed by a setting in the system at file "/proc/sys/net/ipv4/ip_forward"
cat /proc/sys/net/ipv4/ip_forward 
0
by default the value in this file is set to 0 --> meaning no forward. set this to 1 and you should see the pings go through.
echo 1 > /proc/sys/net/ipv4/ip_forward
1
after reboot the setting may change..in order to make this change permanent update the same value in the "/etc/sysctl.conf" file
...
net.ipv4.ip_forward = 1
...


list of commands:
----------------------------------------------------------------------------------------->
"ip link"  --> list and modify the interfaces on the host.
"ip addr"  --> this command is to see the ip addresses assigned to those interfaces.
"ip addr add 192.168.1.10/24 dev eth0"   --> used to set IP addresses on the interfaces

changes with above commands only persists until you reboot the system ...if you want to make it permanent we need to set in the file "/etc/network/interfaces" file.

"ip route (or) route" --> used to view the routing table.
"ip route add 192.168.1.0/24 via 192.168.2.1" --> is used to add entry in the routing table.

"cat /etc/sys/net/ipv4/ip_forward"
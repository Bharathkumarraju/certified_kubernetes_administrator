Requirements for POD networking:
-------------------------------------------->
There is no proper networking solution available in kubernetes as of now.

1. Every pod should have an unique IP address.
2. Every pod should be able to communicate with every other pod in the same node.
3. Every pod should be able to communicate with every other pod in other nodes without NAT.

There are Mnay networking solutions available to achieve this pod networking model. like
weaveworks, flannel, ciliumm, calico, vmwareNSX etc...

 Manually solving the networking problem using network-namespaces we already used below commands:
 ------------------------------------------------------------------------------------------------------>
 "1. ip link add v-net-0 type bridge"
 "2. ip link set dev v-net-0 up"
 "3. ip addr add 192.168.15.5/24 dev v-net-0"
 "4. ip link add veth-red type veth peer name veth-red-br"
 "5. ip link set veth-red netns red"
 "6. ip -n red addr add 192.168.15.1 dev veth-red"
 "7. ip -n red link set veth-red up" 
 "8. ip link set veth-red-br master v-net-0"
 "9. ip netns exec blue ip route add 192.168.1.0/24 via 192.168.25.5"
 "10. iptables -t nat -A POSTROUTING -s 192.168.15.0/24 -j MASQUERADE"


 Those are the commands we used in plain network namespace...where as in kubernetes to solve same problem we have CNI...i.e. 
 we have third party networking solutions like weaveworks, flannel, calico which meets CNI standards.


pass the CNI scripts to kubelet ...
in kubelet.service file:
-------------------------------->
--cni-conf-dir=/etc/cni/net.d
--cni-bin-dir=/etc/cni/bin

each time a container is created in the pod the CNI sctipt executes ./net-scripts.sh add <container> <namespace>

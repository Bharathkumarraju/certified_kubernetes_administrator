Container networking interface

CNI is a program with set of standards which creates all those network namespaces...VirtualEthernets 

example: bridge add <cicd> <namespace>

CNI comes with set of supported plugins like:
1.Bridge
2.VLAN 
3.IPVLAN
4.MACVLAN
5.WINDOWS
IPAM plugins:
--------------->
1.DHCP
2..host-local

some other plugins available from thirdparty organizations  as well...
like Weave, flannel, cilium, calico, vmware nsx etc...

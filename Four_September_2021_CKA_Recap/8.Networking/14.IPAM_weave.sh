IPAM  = IP Address Management(IPAM)

how are the virtual bridge networks and nodes assgined an IP Subnet and how are the pods assigned an IP. Where is this information stored.
who is responsible to make sure there are no duplicate IPs assigned.

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=10.50.0.0/16"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=10.50.0.0/16"

to manage IP addresses locally CNI plugin uses two methods 
"1.DHCP" 
"2.host-local"




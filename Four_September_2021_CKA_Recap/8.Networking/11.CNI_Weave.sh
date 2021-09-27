Weave CNI Plugin:
--------------------->

Weave creates its own bridge on the nodes and names it weave.
Then assigns IP address to each network. 

Weaves can be deployed as services(or)daemonsets in each node.


kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

MacBook-Pro:8.Networking bharathdasaraju$ kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
serviceaccount/weave-net created
clusterrole.rbac.authorization.k8s.io/weave-net created
clusterrolebinding.rbac.authorization.k8s.io/weave-net created
role.rbac.authorization.k8s.io/weave-net created
rolebinding.rbac.authorization.k8s.io/weave-net created
daemonset.apps/weave-net created
MacBook-Pro:8.Networking bharathdasaraju$ 

network security:

Ingress and Egress rules for ... webpods <--> appication pods <--> Database pods


Web-Pod <----> API-Pod <----> DB-Pod 


by default all pods can communicate with eachother in k8s cluster.

and we want to restrict Web-Pods only be able to talk to API-Pods and only API-Pods be able to talk to DB-Pods.
for this we need to implement network policy.

NetworkPolicy is another kubernetes object.
how to attach network policy to pods...hmmm we use labels and selectors :) 


Solutions that support network policies are:
1.Kube-router
2.Calico
3.Weave-net
4.Romana
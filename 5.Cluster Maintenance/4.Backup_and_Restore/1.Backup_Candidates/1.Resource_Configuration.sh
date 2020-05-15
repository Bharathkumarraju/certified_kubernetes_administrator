Imperative:
------------->
Some people might have created the resources imperatively using the "kubectl command" without documenting anywere

Declarative:
-------------->
should be maintained in the Source control system.

How to fix imperatively created resources:
------------------------------------------->
Query the Kube-apiserver.

So first query the kube-apiserver using kubectl command (or)
by accessing kube-apiserver directly and save all resource configurations for all objects created on the cluster has a copy.

like
kubectl get all --all-namespaces -o yaml > all-deploy-services.yaml

So the above commad gives you only specific resources only inorder to backup configmaps,secrets or hpa
you need to specify all the resources objects it would be tedious right....
but to save us there are readymade solutions/tools made by companies like Heption...

There are tools like "ARK" or now called "Velero" by Heptio.








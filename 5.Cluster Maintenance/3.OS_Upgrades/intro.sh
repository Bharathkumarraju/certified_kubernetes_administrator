kube-apiserver - V1.10
then
Controller-manager and kube-scheduler should be V1.9 (or) V1.10
and then
kube-let and kube-proxy should be at V1.8 (or) V1.9 (or) V1.10
and finally
kubectl can be V1.11 (or) V1.10 (or) V1.9

If all those versions match we can upgrade the cluster lively...


So when should you upgrade:
---------------------------->
Lets say we were at V1.10  and kubernetes releases the minor versions V1.11 and V1.12.
So at any time kubernetes supports upto recent three minor versions.

The recommended approch is to upgrade one minor version at a time.





1. have to use multiple masters

Master node hosts the control plane components

Multiple masters in Active-Active mode. And configure the Loadbalancer to route traffic to both the masters

master1: https://master1:6443  -- Active
master2: https://master2:6443  -- Active

 LB  --> https://load-balancer:6443

but Active-Active some issues in scheduling pods

if we go Active-Standby mode we need to use leader-elect which controller manager is leader
kube-controller-manager \
 --leader-elect true [other options] \
 --leader-elect-lease-duration 15s \
 --leader-elect-renew-deadline 10s \
 --leader-elect-retry-period 2s

master1: https://master1:6443  -- Active
master2: https://master2:6443  -- Standby





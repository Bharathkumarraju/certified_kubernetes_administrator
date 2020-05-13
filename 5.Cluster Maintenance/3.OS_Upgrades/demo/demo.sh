Question1:

What is the latest stable version available for upgrade?
Use kubeadm tool

master $ kubeadm upgrade plan
[upgrade/config] Making sure the configuration is correct:
[upgrade/config] Reading configuration from the cluster...
[upgrade/config] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[preflight] Running pre-flight checks.
[upgrade] Making sure the cluster is healthy:
[upgrade] Fetching available versions to upgrade to
[upgrade/versions] Cluster version: v1.16.0
[upgrade/versions] kubeadm version: v1.17.0
I0513 00:25:09.497205   11276 version.go:251] remote version is much newer: v1.18.2; falling back to: stable-1.17
[upgrade/versions] Latest stable version: v1.17.5
[upgrade/versions] Latest version in the v1.16 series: v1.16.9

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   CURRENT       AVAILABLE
Kubelet     2 x v1.16.0   v1.16.9

Upgrade to the latest version in the v1.16 series:

COMPONENT            CURRENT   AVAILABLE
API Server           v1.16.0   v1.16.9
Controller Manager   v1.16.0   v1.16.9
Scheduler            v1.16.0   v1.16.9
Kube Proxy           v1.16.0   v1.16.9
CoreDNS              1.6.2     1.6.5
Etcd                 3.3.15    3.3.17-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.16.9

_____________________________________________________________________

Components that must be upgraded manually after you have upgraded the control plane with 'kubeadm upgrade apply':
COMPONENT   CURRENT       AVAILABLE
Kubelet     2 x v1.16.0   v1.17.5

Upgrade to the latest stable version:

COMPONENT            CURRENT   AVAILABLE
API Server           v1.16.0   v1.17.5
Controller Manager   v1.16.0   v1.17.5
Scheduler            v1.16.0   v1.17.5
Kube Proxy           v1.16.0   v1.17.5
CoreDNS              1.6.2     1.6.5
Etcd                 3.3.15    3.4.3-0

You can now apply the upgrade by executing the following command:

        kubeadm upgrade apply v1.17.5

Note: Before you can perform this upgrade, you have to update kubeadm to v1.17.5.

_____________________________________________________________________

master $

Network Plugin in Kubernetes:
-------------------------------------------->

Kubernetes uses CNI plugins to setup network. The kubelet is responsible for executing plugins as we mention the following parameters in kubelet configuration.

– cni-bin-dir:  Kubelet probes this directory for plugins on startup

– network-plugin: The network plugin to use from cni-bin-dir. It must match the name reported by a plugin probed from the plugin directory.


DNS:
---------->

If you find CoreDNS pods in pending state first check network plugin is installed.

2. coredns pods have CrashLoopBackOff or Error state

If you have nodes that are running SELinux with an older version of Docker 
you might experience a scenario where the coredns pods are not starting. \
To solve that you can try one of the following options:

a)Upgrade to a newer version of Docker.

b)Disable SELinux.


c)Modify the coredns deployment to set "allowPrivilegeEscalation to true":

kubectl -n kube-system get deployment coredns -o yaml | \
  sed 's/allowPrivilegeEscalation: false/allowPrivilegeEscalation: true/g' | \
  kubectl apply -f -

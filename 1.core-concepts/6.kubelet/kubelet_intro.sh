Kubelet:
 1. Its a process runs on all k8s worker nodes
 2. kubelet in the k8s worker nodes registers the node with the kubernetes cluster
 3. When kubelet recieves instructions to load a container (or) a pod on the node,
    kubelet requests the container runtime engine i.e. docker to pull the required image and run an instance(container)
 4. After that kubelet continues to monitors state of the Pod and the container and reports to the kube-apiserver

installing kubelet:
----------------------->
dowbload from the kubernetes official download page.

kubelet.service:
---------------->
ExecStart=/usr/local/bin/kubelet \\
         --config=/var/lib/kubelet/kubelet-config.yaml \\
         --container-runtime=remote \\
         --register-node=true \\



ps -aux | grep kubelet
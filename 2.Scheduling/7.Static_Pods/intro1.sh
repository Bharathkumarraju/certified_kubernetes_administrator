Kubelet independently can create a pod without the instructions from the kube api-server(ETCD).

only thing kubelet needs is a POD-Definition file.
but how do we provide pod-definition file to the kubelet without a kube-api server.

We can configure the kubelet to read the pod definition filed from a directory on the server designated to store information about pods.
on the server:
--------------------->
/etc/kubernetes/manifests
place the pod definition files(pod1.yaml/pod2.yaml) on the above directory and the kubelet periodically checks this directory for files,
reads these files and create pods on the host.
Not only does it create the pod, it can ensure that the pod stays alive all the times as well.
that means, if the application crashes, the kubelet attempts to restart it.

And if you make change to any of the file within this directory, the kubelet recreates the pod for those changes to take effect.
If you remove a file from this direcory the pod is gets deleted automatically.

So these pods that are created by the kubelet on its own without the intervention from the API server( or rest of the k8s components)
are known as Static PODs.

We can only create pods by placing the pod-definition file inside a directory.
We can not create replicasets or deployments or services by placing a definition file in the designated directory.

How to configure this directory were the pod manifest file can be kept:
------------------------------------------------------------------------->
configure the "--pod-manifest-path" as shown below.
option-1:
--------->
kubelet.service:
---------------------->
ExecStart=/usr/local/bin/kubelet \\
  --container-runtime=remote \\
  --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \\
  --pod-manifest-path=/etc/Kubernetes/manifests \\
  --kubeconfig=/var/lib/kubelet/kubeconfig \\
  --network-plugin=cni \\
  --register-node=true \\
  --v=2


option-2:
--------->
kubelet.service:
---------------------->
ExecStart=/usr/local/bin/kubelet \\
  --container-runtime=remote \\
  --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \\
  --config=kubeconfig.yaml
  --kubeconfig=/var/lib/kubelet/kubeconfig \\
  --network-plugin=cni \\
  --register-node=true \\
  --v=2



static pods we can create without any k8s master

In standalone node(with out any master) in kubelet config we can specify a statuc path to look for pod specification files
We can only create pods with this static path we can not create replicaset (or) deployments (or) daemonsets etc...

kubelet service(kubelet.service) config specify like
--pod-manifest-path=/etc/kubernetes/manifests

another way  in kubelet.service file specify like
--config=kubeconfig.yaml

in kubeconfig.yaml file we can specify the pod specification files path like below
staticPodPath: /etc/kubernetes/manifests 




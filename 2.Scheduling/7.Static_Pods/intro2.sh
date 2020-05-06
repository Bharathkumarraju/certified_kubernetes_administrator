Once the staticPods are gets created,
You can view them by running the docker ps command.

why not the kubectl command:
------------------------------->
because kubectl utility works with the kube-api server... since we donot have kube-apiserver we can not use kubectl utility.

kubelet create both kinds of PODs.
1. the staticPods
2. the pods from the kube-apiserver at the sametime.
we can even see the staticPods with "kubectl get pods"... how is it even possible?

Kube-APIserver is aware of the staticPods created by the kubelet.
If you run "kubectl get pods" command on the master node, the staticPods will also gets listed...how is it possible?

Answer:
------->
When the kubelet creates a staticPods, if kubelet is part of a cluster then kubelet also creates
a mirror object in the kubeapi-server.
what you see from the kube-apiserver is a just read only mirror of the pod.

Name of the staticPods appends with node name.

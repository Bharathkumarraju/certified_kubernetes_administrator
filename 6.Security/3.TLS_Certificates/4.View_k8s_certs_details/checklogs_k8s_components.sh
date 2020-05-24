if you setup k8s in VMs manually check each component logs as below:
------------------------------------------------------------------------>
$ journalctl -u etcd.service -l

if you setup k8s cluster using kubeadm:
-------------------------------------------->
$ kubectl logs  etcd-master

if any issue kube-apiserver and etcd then check the docker container logs for those apiserver and etcd etc...
--------------------------------------------------------------------------------------------------------------->
$ docker ps -a
$ docker logs container_name

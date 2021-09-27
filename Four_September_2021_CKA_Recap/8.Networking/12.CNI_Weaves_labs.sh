 kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')" 


 Inspect the kubelet service and identify the network plugin configured for Kubernetes.

 root@controlplane:/etc/kubernetes/manifests# ps -eaf | grep -i "kubelet "
root      4791     1  0 07:20 ?        00:00:17 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.2
root     10360  9757  0 07:26 pts/0    00:00:00 grep --color=auto -i kubelet 
root@controlplane:/etc/kubernetes/manifests# 


root@controlplane:/etc/kubernetes/manifests# ps -eaf | grep -i "kubelet " | grep --color "network-plugin"
root      4791     1  0 07:20 ?        00:00:19 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --network-plugin=cni --pod-infra-container-image=k8s.gcr.io/pause:3.2
root@controlplane:/etc/kubernetes/manifests# 


/opt/cni/bin



root@controlplane:/etc/systemd/system/kubelet.service.d# cd /opt/cni/bin
root@controlplane:/opt/cni/bin# ls -rtlh 
total 69M
-rwxr-xr-x 1 root root 4.0M May 13  2020 bandwidth
-rwxr-xr-x 1 root root 5.7M May 13  2020 firewall
-rwxr-xr-x 1 root root 3.0M May 13  2020 flannel
-rwxr-xr-x 1 root root 3.3M May 13  2020 sbr
-rwxr-xr-x 1 root root 3.8M May 13  2020 portmap
-rwxr-xr-x 1 root root 3.3M May 13  2020 tuning
-rwxr-xr-x 1 root root 4.5M May 13  2020 bridge
-rwxr-xr-x 1 root root 4.0M May 13  2020 host-device
-rwxr-xr-x 1 root root 4.2M May 13  2020 ipvlan
-rwxr-xr-x 1 root root 3.1M May 13  2020 loopback
-rwxr-xr-x 1 root root 4.2M May 13  2020 macvlan
-rwxr-xr-x 1 root root 4.4M May 13  2020 ptp
-rwxr-xr-x 1 root root 4.2M May 13  2020 vlan
-rwxr-xr-x 1 root root  12M May 13  2020 dhcp
-rwxr-xr-x 1 root root 2.8M May 13  2020 static
-rwxr-xr-x 1 root root 3.5M May 13  2020 host-local
root@controlplane:/opt/cni/bin# 



root@controlplane:/etc/cni/net.d# pwd  
/etc/cni/net.d
root@controlplane:/etc/cni/net.d# cat 10-flannel.conflist 
{
  "name": "cbr0",
  "cniVersion": "0.3.1",
  "plugins": [
    {
      "type": "flannel",
      "delegate": {
        "hairpinMode": true,
        "isDefaultGateway": true
      }
    },
    {
      "type": "portmap",
      "capabilities": {
        "portMappings": true
      }
    }
  ]
}
root@controlplane:/etc/cni/net.d#

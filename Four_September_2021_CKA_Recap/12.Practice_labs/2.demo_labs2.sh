root@controlplane:/etc/kubernetes/manifests# kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo}' > /opt/outputs/nodes_os_x43kj56.txt
root@controlplane:/etc/kubernetes/manifests# 

root@controlplane:/etc/kubernetes/manifests# kubectl apply -f pv.yaml
persistentvolume/pv-analytics created
root@controlplane:/etc/kubernetes/manifests# cat pv.yaml 
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-analytics
spec:
  capacity:
    storage: 100Mi 
  accessModes:
    - ReadWriteMany
  hostPath:
     path: /pv/data-analytics

root@controlplane:/etc/kubernetes/manifests# 


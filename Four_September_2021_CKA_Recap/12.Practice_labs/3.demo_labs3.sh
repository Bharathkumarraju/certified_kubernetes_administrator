Take a backup of the etcd cluster and save it to /opt/etcd-backup.db


root@controlplane:~# ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot save /opt/etcd-backup.db
Snapshot saved at /opt/etcd-backup.db
root@controlplane:~#


root@controlplane:~# ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key snapshot status /opt/etcd-backup.db
9939d35e, 1775, 861, 2.4 MB
root@controlplane:~# 


Create a Pod called redis-storage with image: redis:alpine with a Volume of type emptyDir that lasts for the life of the Pod.
Pod named 'redis-storage' created
Pod 'redis-storage' uses Volume type of emptyDir
Pod 'redis-storage' uses volumeMount with mountPath = /data/redis



A pod definition file is created at /root/CKA/use-pv.yaml. 
Make use of this manifest file and mount the persistent volume called pv-1. 
Ensure the pod is running and the PV is bound.

mountPath: /data
persistentVolumeClaim Name: my-pvc


root@controlplane:~# kubectl get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS   REASON   AGE
pv-1   10Mi       RWO            Retain           Bound    default/my-pvc                           12m
root@controlplane:~# 

# -------------------------------------------------------------------------------------------

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  volumeName: pv-1 
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Mi

# ---------------------------------------------------------------------------------------------

root@controlplane:~# vim pvc.yaml 
root@controlplane:~# kubectl apply -f pvc.yaml 
persistentvolumeclaim/my-pvc created
root@controlplane:~# kubectl apply -f /root/CKA/use-pv.yaml 
pod/use-pv created
root@controlplane:~# kubectl get pvc 
NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
my-pvc   Bound    pv-1     10Mi       RWO                           35s
root@controlplane:~# kubectl create deployment nginx-deploy --image=nginx:1.16 --replicas=1
deployment.apps/nginx-deploy created
root@controlplane:~# kubectl set image deploy/nginx-deploy nginx=nginx:1.17 --record
deployment.apps/nginx-deploy image updated
root@controlplane:~#



Create a new user called john. Grant him access to the cluster. 
John should have permission to create, list, get, update and delete pods in the development namespace . 
The private key exists in the location: /root/CKA/john.key and csr at /root/CKA/john.csr.


Important Note: As of kubernetes 1.19, the CertificateSigningRequest object expects a signerName.




root@controlplane:~/CKA# cat john.csr | base64 -w 0
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZEQ0NBVHdDQVFBd0R6RU5NQXNHQTFVRUF3d0VhbTlvYmpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRApnZ0VQQURDQ0FRb0NnZ0VCQU1aV0t3d1EzQzF4UjhxSjFvMWZGWHIzSjlMaFozNEkxVHBUdWJIa1ozUnhrTExTCjQxaEVDZkM5WG5USTBraDlaWHhZRFMwWThTcVBkYWNsWlhXaC9YdEh2WCtCSTJISVlxRTBaekJWTVJYMFdRbmEKS2l1V2ZrbFYrN090OGpvbmZCUGJWcmJZbGNjQmdzeG43bmo5T1AxVXFkSk9zUUQrakU4Q1FVZE1nb1NGK1p5Kwp3NGQvaVJkRHRXeGwvUDVhQ0VPb2FVK1h0SnM2VWFNVDZ4cEdGejhWUHdBY0Rrc1lOS2NUaktqalFwdHBWSGZYCkJSbmlIbHRkNnp1cCtWOVViMHpHVTZHYkNoL01qbjVGUHd4WEdWTGRBYTVMOUpITGlEUk93RElmR1dNdVhjb0gKUUtpMVFWZ2M2R1dXQmhYTDhtK1dwWkNsVUxLS1RDM1R4ai94MUtjQ0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQgpDd1VBQTRJQkFRQ0s3cGJSUC9SVThhR3lHb3p2WVhFTGxxTVd5NmQzb2pKUkdVcG9qV2tTNHJqcWUxdjR6MFRLCklzZ2J5ZHJscHZ2aDF1T1hkRFhKdkVES1VaZmVLT2hacnZkOHBtUlIzaTluY1FHRnJPdFZIUThZS08yNlRjZ0IKQ2gzbVB0cUFTZkErNWxZSDZId0NOdlZ1LzRvUmFDODJ6QVN6SDZJZUd0Uno4UVpMS09pQjU5UUNNd3ZKOUJNQQo1a1BkQkt3R1ZXQXU3WDR2MXRQSEtldFdXZzhGVXJpeXQ5aE82V1BEUWkvZzVxSVdlaS95VVMwb3BJR0xRTVY0CitUZUdscTVhemFZUDNsR3dRZUUyWFVCdG4yTDZBTTBZckUveXpwcDBHVWJDa20yb1N3TlN4bENLRW9oQVE0dWQKMitYZXZOTTg3QzRGU1J2bzFPQ2tiNTE2UXlXYXVQdEcKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==root@controlplane:~/CKA# 
root@controlplane:~/CKA# 
root@controlplane:~/CKA# cd -
/root
root@controlplane:~# vim csr.yaml 
root@controlplane:~# kubectl apply -f csr.yaml 
error: error validating "csr.yaml": error validating data: ValidationError(CertificateSigningRequest.spec): unknown field "expirationSeconds" in io.k8s.api.certificates.v1.CertificateSigningRequestSpec; if you choose to ignore these errors, turn validation off with --validate=false
root@controlplane:~# vim csr.yaml 
root@controlplane:~# kubectl apply -f csr.yaml 
certificatesigningrequest.certificates.k8s.io/john created
root@controlplane:~# 


root@controlplane:~# kubectl get csr
NAME        AGE    SIGNERNAME                                    REQUESTOR                 CONDITION
csr-kmm4g   69m    kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:yfl3p0   Approved,Issued
john        115s   kubernetes.io/kube-apiserver-client           kubernetes-admin          Pending
root@controlplane:~# kubectl certificate approve john
certificatesigningrequest.certificates.k8s.io/john approved
root@controlplane:~# 




root@controlplane:~# kubectl create deployment nginx-deploy --image=nginx:1.16 --dry-run=client -o yaml > deploy.yaml
root@controlplane:~# kubectl apply -f deploy.yaml --record
deployment.apps/nginx-deploy created
root@controlplane:~# kubectl rollout history deployment nginx-deploy
deployment.apps/nginx-deploy 
REVISION  CHANGE-CAUSE
1         kubectl apply --filename=deploy.yaml --record=true

root@controlplane:~# kubectl set image deployment/nginx-deploy nginx=nginx:1.17 --record
deployment.apps/nginx-deploy image updated
root@controlplane:~# kubectl rollout history deployment nginx-deploydeployment.apps/nginx-deploy 
REVISION  CHANGE-CAUSE
1         kubectl apply --filename=deploy.yaml --record=true
2         kubectl set image deployment/nginx-deploy nginx=nginx:1.17 --record=true

root@controlplane:~# 



root@controlplane:~# kubectl apply -f cert.yaml
certificatesigningrequest.certificates.k8s.io/john-developer created
root@controlplane:~# kubectl certificate approve john-developer
certificatesigningrequest.certificates.k8s.io/john-developer approved
root@controlplane:~# kubectl get csr
NAME             AGE   SIGNERNAME                                    REQUESTOR                  CONDITION
csr-flv2p        61m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   Approved,Issued
csr-z97m2        60m   kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:ppb9qk    Approved,Issued
john             32m   kubernetes.io/kube-apiserver-client           kubernetes-admin           Approved,Issued
john-developer   40s   kubernetes.io/kube-apiserver-client           kubernetes-admin           Approved,Issued
root@controlplane:~# 


root@controlplane:~# kubectl get csr
NAME             AGE   SIGNERNAME                                    REQUESTOR                  CONDITION
csr-flv2p        61m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   Approved,Issued
csr-z97m2        60m   kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:ppb9qk    Approved,Issued
john             32m   kubernetes.io/kube-apiserver-client           kubernetes-admin           Approved,Issued
john-developer   40s   kubernetes.io/kube-apiserver-client           kubernetes-admin           Approved,Issued
root@controlplane:~# kubectl create role developer --resource=pods --verb=create,list,get,update,delete --namespace=development
role.rbac.authorization.k8s.io/developer created
root@controlplane:~# kubectl create rolebinding developer-role-binding --role=developer --user=john --namespace=development
rolebinding.rbac.authorization.k8s.io/developer-role-binding created
root@controlplane:~# kubectl auth can-i update pods --as=john --namespace=development
yes
root@controlplane:~# kubectl auth can-i delete pods --as=john -n development
yes
root@controlplane:~# 


kubectl run nginx-resolver --image=nginx
kubectl expose pod nginx-resolver --name=nginx-resolver-service --port=80 --target-port=80 --type=ClusterIP

kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-resolver-service
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-resolver-service > /root/CKA/nginx.svc


Get the IP of the nginx-resolver pod and replace the dots(.) with hyphon(-) which will be used below.

kubectl get pod nginx-resolver -o wide
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup <P-O-D-I-P.default.pod> > /root/CKA/nginx.pod


Run Static pod in node01:
----------------------------->
on node create directory "/etc/kubernetes/manifests"

Check if static pod directory is present which is /etc/kubernetes/manifests, if its not present then create it.

root@node01:~# mkdir -p /etc/kubernetes/manifests
Add that complete path to the staticPodPath field in the kubelet config.yaml file.

root@node01:~# vi /var/lib/kubelet/config.yaml
now, move/copy the static.yaml to path /etc/kubernetes/manifests/.

root@node01:~# cp /root/static.yaml /etc/kubernetes/manifests/
Go back to the controlplane node and check the status of static pod:

root@node01:~# exit
logout
root@controlplane:~# kubectl get pods 


------------------------------------------------------------------------------------------>

root@controlplane:~# kubectl create deployment nginx-deploy --image=nginx:1.16 --replicas=1 --dry-run=client -o yaml > deploy.yaml
root@controlplane:~# kubectl apply -f deploy.yaml --record
deployment.apps/nginx-deploy created
root@controlplane:~# kubectl rollout history deploy nginx-deploy 
deployment.apps/nginx-deploy 
REVISION  CHANGE-CAUSE
1         kubectl apply --filename=deploy.yaml --record=true

root@controlplane:~# 


root@controlplane:~# kubectl create deployment nginx-deploy --image=nginx:1.16 --replicas=1 --dry-run=client -o yaml > deploy.yaml
root@controlplane:~# kubectl apply -f deploy.yaml --record
deployment.apps/nginx-deploy created
root@controlplane:~# kubectl rollout history deploy nginx-deploy 
deployment.apps/nginx-deploy 
REVISION  CHANGE-CAUSE
1         kubectl apply --filename=deploy.yaml --record=true

root@controlplane:~# 


root@controlplane:~# kubectl get csr
NAME        AGE   SIGNERNAME                                    REQUESTOR                  CONDITION
csr-99qwr   35m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   Approved,Issued
csr-jdpqv   34m   kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:riyp9a    Approved,Issued
john        6s    kubernetes.io/kube-apiserver-client           kubernetes-admin           Pending
root@controlplane:~# kubectl certificate approve john
certificatesigningrequest.certificates.k8s.io/john approved
root@controlplane:~# kubectl get cstr
error: the server doesnt have a resource type "cstr"
root@controlplane:~# kubectl get csr 
NAME        AGE   SIGNERNAME                                    REQUESTOR                  CONDITION
csr-99qwr   36m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   Approved,Issued
csr-jdpqv   35m   kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:riyp9a    Approved,Issued
john        42s   kubernetes.io/kube-apiserver-client           kubernetes-admin           Approved,Issued
root@controlplane:~# kubectl create namespace --development
Error: unknown flag: --development
See 'kubectl create namespace --help' for usage.
root@controlplane:~# kubectl create namespace development
Error from server (AlreadyExists): namespaces "development" already exists
root@controlplane:~# kubectl create role dev_role  --verb=list,create,get,update,delete --resource=pods -n development 
role.rbac.authorization.k8s.io/dev_role created
root@controlplane:~# kubectl create rolebinding dev_binding --role=dev_role --user=john -n development
rolebinding.rbac.authorization.k8s.io/dev_binding created
root@controlplane:~# kubectl auth can-i delete pods  --as=john  -n development 
yes
root@controlplane:~# 



root@controlplane:~# kubectl run  testdns --image=busybox:1.28 -it --rm --restart=Never -- nslookup nginx-resolver-service
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-resolver-service
Address 1: 10.106.53.215 nginx-resolver-service.default.svc.cluster.local
pod "testdns" deleted
root@controlplane:~#

root@controlplane:~# kubectl run  testdns --image=busybox:1.28 -it --rm --restart=Never -- nslookup nginx-resolver-service > /root/CKA/nginx.svc
root@controlplane:~# 


root@controlplane:~# kubectl run  testdns --image=busybox:1.28 -it --rm --restart=Never -- nslookup 10-50-192-4.default.pod.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      10-50-192-4.default.pod.cluster.local
Address 1: 10.50.192.4 10-50-192-4.nginx-resolver-service.default.svc.cluster.local
pod "testdns" deleted
root@controlplane:~#

root@controlplane:~# kubectl run  testdns --image=busybox:1.28 -it --rm --restart=Never -- nslookup 10-50-192-4.default.pod.cluster.local > /root/CKA/nginx.pod
root@controlplane:~# 
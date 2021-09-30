# demo_lab1.sh
root@controlplane:~# kubectl get deploy -n admin2406
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
deploy1   1/1     1            1           22m
deploy2   1/1     1            1           22m
deploy3   1/1     1            1           22m
deploy4   1/1     1            1           22m
deploy5   1/1     1            1           22m
root@controlplane:~# 




kubectl -n admin2406 get deployment -o custom-columns=DEPLOYMENT:.metadata.name,CONTAINER_IMAGE:.spec.template.spec.containers[].image

kubectl get deploy -n admin2406 -o     custom-columns=DEPLOYMENT:.metadata.name,CONTAINER_IMAGE:.spec.template.spec.containers[].image


root@controlplane:~# kubectl get deploy -n admin2406 -o custom-columns=DEPLOYMENT:.metadata.name,CONTAINER_IMAGE:.spec.template.spec.containers[].image,READY_REPLICAS:.status.readyReplicas,NAMESPACE:.metadata.namespace --sort-by=.metadata.name
DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE
deploy1      nginx             1                admin2406
deploy2      nginx:alpine      1                admin2406
deploy3      nginx:1.16        1                admin2406
deploy4      nginx:1.17        1                admin2406
deploy5      nginx:latest      1                admin2406
root@controlplane:~# 



root@controlplane:~# kubectl cluster-info --kubeconfig=/root/CKA/admin.kubeconfig
Kubernetes control plane is running at https://controlplane:6443
KubeDNS is running at https://controlplane:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
root@controlplane:~# 


root@controlplane:~# kubectl create deploy nginx-deploy --image=nginx:1.16 --replicas=1
deployment.apps/nginx-deploy created
root@controlplane:~#

root@controlplane:~# kubectl set image deployment/nginx-deploy  nginx=nginx:1.17 --record
deployment.apps/nginx-deploy image updated
root@controlplane:~# 


A new deployment called alpha-mysql has been deployed in the alpha namespace. However, the pods are not running. 
Troubleshoot and fix the issue. 
The deployment should make use of the persistent volume alpha-pv to be mounted 
at /var/lib/mysql and should use the environment variable MYSQL_ALLOW_EMPTY_PASSWORD=1 to make use of an empty root password.

Important: Do not alter the persistent volume.

root@controlplane:~# cat pvc.yaml 
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-alpha-pvc
  namespace: alpha
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: slow
root@controlplane:~# 



export ETCDCTL_API=3
etcdctl snapshot save --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key --endpoints=127.0.0.1:2379 /opt/etcd-backup.db



Create a pod called secret-1401 in the admin1401 namespace using the busybox image. 
The container within the pod should be called secret-admin and should sleep for 4800 seconds.

The container should mount a read-only secret volume called secret-volume at the path /etc/secret-volume. 
The secret being mounted has already been created for you and is called dotfile-secret.



root@controlplane:~# kubectl get secrets -n admin1401
NAME                  TYPE                                  DATA   AGE
default-token-wz8x2   kubernetes.io/service-account-token   3      49m
dotfile-secret        Opaque                                1      49m
root@controlplane:~# 


root@controlplane:~# kubectl run secret-1401 --image=busybox --dry-run=client -o yaml --command -- sleep 4800
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: secret-1401
  name: secret-1401
spec:
  containers:
  - command:
    - sleep
    - "4800"
    image: busybox
    name: secret-1401
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
root@controlplane:~# 


root@controlplane:~# kubectl apply -f pod.yaml 
pod/secret-1401 created
root@controlplane:~# cat pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: secret-1401
  name: secret-1401
  namespace: admin1401
spec:
  containers:
  - command:
    - sleep
    - "4800"
    image: busybox
    name: secret-1401
    volumeMounts:
    - name: secret-volume
      readOnly: true
      mountPath: "/etc/secret-volume"
  volumes:
  - name: secret-volume
    secret:
      secretName: dotfiles-secret
root@controlplane:~# 


root@controlplane:~# kubectl get deploy -o custom-columns=DEPLOYMENT:'.metadata.name',CONTAINER_IAMGE:.spec.template.spec.containers[].image,READY_REPLICAS:'.status.readyReplicas',NAMESPACE:'.metadata.namespace' --sort-by '.metadata.name'  -n admin2406 > /opt/admin2406_data
root@controlplane:~# 

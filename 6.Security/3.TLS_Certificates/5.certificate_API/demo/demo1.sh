master $ kubectl get all --all-namespaces
NAMESPACE     NAME                                 READY   STATUS    RESTARTS   AGE
kube-system   pod/coredns-5644d7b6d9-4xp6s         1/1     Running   0          4m43s
kube-system   pod/coredns-5644d7b6d9-dkw9w         1/1     Running   0          4m44s
kube-system   pod/etcd-master                      1/1     Running   0          3m32s
kube-system   pod/kube-apiserver-master            1/1     Running   0          3m43s
kube-system   pod/kube-controller-manager-master   1/1     Running   0          3m42s
kube-system   pod/kube-proxy-cfwlg                 1/1     Running   0          4m25s
kube-system   pod/kube-proxy-fdsd6                 1/1     Running   0          4m43s
kube-system   pod/kube-scheduler-master            1/1     Running   0          3m37s
kube-system   pod/weave-net-5q9cp                  2/2     Running   1          4m25s
kube-system   pod/weave-net-7p45v                  2/2     Running   1          4m43s

NAMESPACE     NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  4m52s
kube-system   service/kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   4m50s

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                 AGE
kube-system   daemonset.apps/kube-proxy   2         2         2       2            2           beta.kubernetes.io/os=linux   4m50s
kube-system   daemonset.apps/weave-net    2         2         2       2            2           <none>                        4m49s

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns   2/2     2            2           4m50s

NAMESPACE     NAME                                 DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-5644d7b6d9   2         2         2       4m44s
master $


---------------------------------------------------------------------------------------------------------------------------------------->

master $ cat akshay.csr | base64
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQW1wd0Z3WUt3elRpd2hlRHdtZ2ltQVIrUVQvVTRYQkxEV0xWMlZqWkpvbjhKCk1yellySWIrcVlUand2TElndHM0c2VoemxVTXR0YWIrNndGZDU3aThtc2ZWeE8vMzEyWi9NaEU4U05mTXVQQk8KcCtBNklDMVhucFN4SVhTTHVVcnA4R0tCYy93WHp5UW45NVZTSXkyRGhMMWZkQXByU0M3dEZiNitySkt5dG01dAphZnF6eU16eHgwd0Z3OWFpa1NJK1kvSzJrUVdsRk5qWjZEV1FvZm85YUpISURsbURscWQrUkhrL2s3Tjc4dXR4Ckl4Q2Q0T3ZraFBlWXczM1JJUzZldENVQTJZTUhMeDMyb1Q0MUJIOUtIMUFkODBMaFRkK3h0TWVvQm84MHRVMDAKRHBJOUplK3NoL2JLbXQ4QTFhejl0aXdpNnJlOHI0RjJZd0dZOUhFY2RRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBQVpCZ1hQcEN3dEVtUitSQjRkMjVSQjBrTm5oa2Q5d3RoQTN0eEEyTVJSNkt5WExqN0g1CjUxOTNtREI2SHpYaEJJQldMMFZXNEtSU2JrL2Rucmhib1YwMWszNVRDYjVKT3A5cmtzN0JUNEkxd1MxRWIwQVkKeE01N0pET3VoY0Y5cjVIZ2wxSE5ybE1ZTkppVlNGdGRZWHE0V2lITzErL2pjMFVuaEZ6aGJpVDByMHIvam5Tcgp6RmVITzlFaHdTUlgvUENLYmFKRjFoYUxNVitzeW1yMXZMUGNiTVlJS29sczIxTUNkYy84c3BUdVRrWmpLaVhVCmErZzJiM2pMOUF1WkRhYUJMSVNrckhNOHZlVkVmRmR4OWV6TG9lSU1wSGlpU2E0dEVTVnlBMGxKeC9UTGh0QnIKODF0WnIyQnFyY1dKVWYwMndSM293RlQydXBOSkIwaEo0bWc9Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQ==
master $

master $ kubectl apply -f akshay-csr.yaml
certificatesigningrequest.certificates.k8s.io/akshay created
master $

master $ kubectl get csr
NAME        AGE   REQUESTOR                 CONDITION
akshay      42s   kubernetes-admin          Pending
csr-2k96h   19m   system:node:master        Approved,Issued
csr-cg2rn   19m   system:bootstrap:96771a   Approved,Issued
master $

master $ kubectl certificate approve  akshay
certificatesigningrequest.certificates.k8s.io/akshay approved
master $

master $ kubectl get csr
NAME        AGE     REQUESTOR                 CONDITION
akshay      3m57s   kubernetes-admin          Approved,Issued
csr-2k96h   23m     system:node:master        Approved,Issued
csr-cg2rn   23m     system:bootstrap:96771a   Approved,Issued
master $



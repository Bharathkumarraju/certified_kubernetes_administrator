root@controlplane:/# kubectl get sa
NAME      SECRETS   AGE
default   1         13m
root@controlplane:/# 

root@controlplane:/# kubectl describe sa default
Name:                default
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   default-token-xvpxp
Tokens:              default-token-xvpxp
Events:              <none>
root@controlplane:/# 


The application needs a ServiceAccount with the Right permissions to be created to authenticate to Kubernetes. 
The 'default' ServiceAccount has limited access. Create a new ServiceAccount named 'dashboard-sa'.

root@controlplane:/var/rbac# kubectl get sa
NAME           SECRETS   AGE
dashboard-sa   1         42s
default        1         23m
root@controlplane:/var/rbac# kubectl describe sa dashboard-sa 
Name:                dashboard-sa
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   dashboard-sa-token-b7qmk
Tokens:              dashboard-sa-token-b7qmk
Events:              <none>
root@controlplane:/var/rbac# 


root@controlplane:/var/rbac# pwd
/var/rbac
root@controlplane:/var/rbac#  ls -lrth
total 8.0K
-rw-rw-rw- 1 root root 191 Sep 14 01:32 pod-reader-role.yaml
-rw-rw-rw- 1 root root 399 Sep 14 01:32 dashboard-sa-role-binding.yaml
root@controlplane:/var/rbac# 


root@controlplane:/var/rbac# cat pod-reader-role.yaml 
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups:
  - ''
  resources:
  - pods
  verbs:
  - get
  - watch
  - list
root@controlplane:/var/rbac# 


root@controlplane:/var/rbac# cat dashboard-sa-role-binding.yaml 
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: ServiceAccount
  name: dashboard-sa # Name is case sensitive
  namespace: default
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
root@controlplane:/var/rbac# 




root@controlplane:/var/rbac# kubectl describe sa dashboard-sa
Name:                dashboard-sa
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   dashboard-sa-token-b7qmk
Tokens:              dashboard-sa-token-b7qmk
Events:              <none>
root@controlplane:/var/rbac# kubectl describe secrets dashboard-sa-token-b7qmk
Name:         dashboard-sa-token-b7qmk
Namespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: dashboard-sa
              kubernetes.io/service-account.uid: 52508e72-5bcb-4c89-952b-d9c9b47c9d0d

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1066 bytes
namespace:  7 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6InlDaGMxZXhicXpIMUZrQUlJR3dfTm5DTVBBaDUzYUtwTzZLWmZRdjBjUjAifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRhc2hib2FyZC1zYS10b2tlbi1iN3FtayIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkYXNoYm9hcmQtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI1MjUwOGU3Mi01YmNiLTRjODktOTUyYi1kOWM5YjQ3YzlkMGQiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkYXNoYm9hcmQtc2EifQ.GcDrsRVcSZ2O4obe-q5MkK04-AVAzZNHysk_F-gr5_eXaXcxDU2bVTD3Rulahf6bmPg5HVZ-XigVs3JbAzTSCd2dngz3I55yaQ1lqTxq6wwvVb7hidnUkI2i7sFZQNVRUW_54BuArhFDIRjGpbiTn0J8rpzbHdww3sb6YEZWyhvHRIbAO5VXTxGIfLFRCjwOUBe_g2Gd6r8ChXFT5WOac4MHJUCPRBIhIn0fgH1b2vpBzYXy_BaN_Gy1Q5702LGbyBzfiKNWph9D8Mxkgd_ynISZi79vK8UjsIK5XSduE-XpPma6GDBly0ZK9OLJI2iAAXoMxdoISSzqjjPU5ZhGew
root@controlplane:/var/rbac#



root@controlplane:~# kubectl edit deployment.apps/web-dashboard
deployment.apps/web-dashboard edited
root@controlplane:~# 
    spec:
      serviceAccountName: dashboard-sa
      containers:
      - image: gcr.io/kodekloud/customimage/my-kubernetes-dashboard
        imagePullPolicy: Always
        name: web-dashboard
        ports:
        - containerPort: 8080
          protocol: TCP 
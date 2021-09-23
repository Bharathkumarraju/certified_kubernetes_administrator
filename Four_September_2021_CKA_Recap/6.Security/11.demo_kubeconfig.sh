curl https://my-kube-playground:6443/api/v1/pods --key admin.key --cert admin.crt --cacert ca.crt

kubectl get pods --server my-kube-playground:6443/api/v1/pods \
                 --client-key admin.key \
                 --client-certificate admin.crt \
                 --certificate-authority ca.crt

Kubeconfig file:
------------------------------>
Clusters  --> cluster names(Development, Production, Google etc...)
Contexts --> defines which user account can access to which cluster... admin@Development... devuser@Google
Users  --> users(admin, devuser,produser) to get access to k8s cluster             



MacBook-Pro:6.Security bharathdasaraju$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/bharathdasaraju/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Thu, 23 Sep 2021 07:52:38 +08
        provider: minikube.sigs.k8s.io
        version: v1.20.0
      name: cluster_info
    server: https://127.0.0.1:32769
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Thu, 23 Sep 2021 07:52:38 +08
        provider: minikube.sigs.k8s.io
        version: v1.20.0
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /Users/bharathdasaraju/.minikube/profiles/minikube/client.crt
    client-key: /Users/bharathdasaraju/.minikube/profiles/minikube/client.key
MacBook-Pro:6.Security bharathdasaraju$ 



MacBook-Pro:~ bharathdasaraju$ kubectl config view --kubeconfig=bkr-config
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/bharathdasaraju/.minikube/ca.crt
    extensions:
    - extension:
        last-update: Thu, 23 Sep 2021 07:52:38 +08
        provider: minikube.sigs.k8s.io
        version: v1.20.0
      name: cluster_info
    server: https://127.0.0.1:32769
  name: minikube
contexts:
- context:
    cluster: minikube
    extensions:
    - extension:
        last-update: Thu, 23 Sep 2021 07:52:38 +08
        provider: minikube.sigs.k8s.io
        version: v1.20.0
      name: context_info
    namespace: default
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /Users/bharathdasaraju/.minikube/profiles/minikube/client.crt
    client-key: /Users/bharathdasaraju/.minikube/profiles/minikube/client.key
MacBook-Pro:~ bharathdasaraju$ 

MacBook-Pro:~ bharathdasaraju$ kubectl config current-context --kubeconfig=bkr-config
minikube
MacBook-Pro:~ bharathdasaraju$ 


MacBook-Pro:~ bharathdasaraju$ kubectl config use-context prod-user@production
MacBook-Pro:~ bharathdasaraju$ 

- cluster:
    certificate-authority: /Users/bharathdasaraju/.minikube/ca.crt
we can also pass certificate-authority-data: the contents of cert in base64 format.


How to switch namespaces permanently without specifying the -n option to kubectl command

In order to do that....we have to use "kubectl config" command to set the namespace in the current context

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl config current-context
minikube
bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/bharathdasaraju/.minikube/ca.crt
    server: https://192.168.64.2:8443
  name: minikube
contexts:
- context:
    cluster: minikube
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
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

echo "Setting the context to specific namespace"

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl config set-context $(kubectl config current-context) --namespace=bharath
Context "minikube" modified.
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/bharathdasaraju/.minikube/ca.crt
    server: https://192.168.64.2:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    namespace: bharath
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
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

echo "Now we do not need to specify --namespace to see specific namespace resources"

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get pods
NAME                                   READY   STATUS    RESTARTS   AGE
bharaths-deployment-7fdb746c4d-26xdw   1/1     Running   0          9m54s
bharaths-deployment-7fdb746c4d-2xqv8   1/1     Running   0          9m54s
bharaths-deployment-7fdb746c4d-7vhz7   1/1     Running   0          9m54s
bharaths-deployment-7fdb746c4d-fkwlg   1/1     Running   0          9m54s
bharaths-deployment-7fdb746c4d-h2kjc   1/1     Running   0          9m54s
bhrath-nginx                           1/1     Running   0          13m
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get all
NAME                                       READY   STATUS    RESTARTS   AGE
pod/bharaths-deployment-7fdb746c4d-26xdw   1/1     Running   0          9m57s
pod/bharaths-deployment-7fdb746c4d-2xqv8   1/1     Running   0          9m57s
pod/bharaths-deployment-7fdb746c4d-7vhz7   1/1     Running   0          9m57s
pod/bharaths-deployment-7fdb746c4d-fkwlg   1/1     Running   0          9m57s
pod/bharaths-deployment-7fdb746c4d-h2kjc   1/1     Running   0          9m57s
pod/bhrath-nginx                           1/1     Running   0          13m

NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/bharaths-deployment   5/5     5            5           9m57s

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/bharaths-deployment-7fdb746c4d   5         5         5       9m57s

bharathdasaraju@MacBook-Pro 12.Deployments (master) $
pods in kube-system namespace:
------------------------------->
bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get pods -n kube-system
NAME                               READY   STATUS    RESTARTS   AGE
coredns-66bff467f8-js6rv           1/1     Running   3          32d
coredns-66bff467f8-pcnwb           1/1     Running   3          32d
etcd-minikube                      1/1     Running   2          32d
kube-apiserver-minikube            1/1     Running   2          32d
kube-controller-manager-minikube   1/1     Running   58         32d
kube-proxy-gbxft                   1/1     Running   2          32d
kube-scheduler-minikube            1/1     Running   58         32d
storage-provisioner                1/1     Running   3          32d
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

bharathdasaraju@MacBook-Pro 13.Namespaces (master) $ kubectl apply -f pod-definition-namespace.yaml
namespace/bharath created
pod/bhrath-nginx created
bharathdasaraju@MacBook-Pro 13.Namespaces (master) $

echo "Add namespace creation, pod creation and the deployment creation in the same api manifest file"

bharathdasaraju@MacBook-Pro 13.Namespaces (master) $ kubectl apply -f pod-definition-namespace.yaml
namespace/bharath unchanged
pod/bhrath-nginx unchanged
deployment.apps/bharaths-deployment created
bharathdasaraju@MacBook-Pro 13.Namespaces (master) $

bharathdasaraju@MacBook-Pro 13.Namespaces (master) $ kubectl get all -n bharath
NAME                                       READY   STATUS    RESTARTS   AGE
pod/bharaths-deployment-7fdb746c4d-26xdw   1/1     Running   0          38s
pod/bharaths-deployment-7fdb746c4d-2xqv8   1/1     Running   0          38s
pod/bharaths-deployment-7fdb746c4d-7vhz7   1/1     Running   0          38s
pod/bharaths-deployment-7fdb746c4d-fkwlg   1/1     Running   0          38s
pod/bharaths-deployment-7fdb746c4d-h2kjc   1/1     Running   0          38s
pod/bhrath-nginx                           1/1     Running   0          4m22s

NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/bharaths-deployment   5/5     5            5           38s

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/bharaths-deployment-7fdb746c4d   5         5         5       38s

bharathdasaraju@MacBook-Pro 13.Namespaces (master) $

root@controlplane:~# kubectl get all -n alpha
NAME                                READY   STATUS    RESTARTS   AGE
pod/mysql                           1/1     Running   0          2m14s
pod/webapp-mysql-75dfdf859f-g6c69   1/1     Running   0          2m13s

NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/mysql         ClusterIP   10.101.228.242   <none>        3306/TCP         2m14s
service/web-service   NodePort    10.105.190.144   <none>        8080:30081/TCP   2m13s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           2m13s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-75dfdf859f   1         1         1       2m13s
root@controlplane:~#


root@controlplane:~# kubectl get svc -n alpha
NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
mysql         ClusterIP   10.101.228.242   <none>        3306/TCP         5m11s
web-service   NodePort    10.105.190.144   <none>        8080:30081/TCP   5m10s
root@controlplane:~# kubectl edit svc mysql -n alpha
A copy of your changes has been stored to "/tmp/kubectl-edit-5wbl3.yaml"
error: At least one of apiVersion, kind and name was changed
root@controlplane:~#
root@controlplane:~# kubectl delete svc mysql -n alpha
service "mysql" deleted
root@controlplane:~# kubectl apply -f /tmp/kubectl-edit-5wbl3.yaml -n alpha
service/mysql-service created
root@controlplane:~# kubectl get svc -n alpha
NAME            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
mysql-service   ClusterIP   10.101.228.242   <none>        3306/TCP         9s
web-service     NodePort    10.105.190.144   <none>        8080:30081/TCP   7m18s
root@controlplane:~# 



root@controlplane:~# kubectl get all -n beta
NAME                                READY   STATUS    RESTARTS   AGE
pod/mysql                           1/1     Running   0          2m21s
pod/webapp-mysql-75dfdf859f-cnjvc   1/1     Running   0          2m21s

NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.105.137.114   <none>        3306/TCP         2m21s
service/web-service     NodePort    10.98.182.217    <none>        8080:30081/TCP   2m20s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           2m21s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-75dfdf859f   1         1         1       2m22s
root@controlplane:~# 




root@controlplane:~# kubectl get all -n delta
NAME                                READY   STATUS    RESTARTS   AGE
pod/mysql                           1/1     Running   0          32s
pod/webapp-mysql-67cfc57cbc-s2t4r   1/1     Running   0          32s

NAME                    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.105.81.242    <none>        3306/TCP         32s
service/web-service     NodePort    10.103.208.202   <none>        8080:30081/TCP   32s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           32s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-67cfc57cbc   1         1         1       32s
root@controlplane:~# 



root@controlplane:~# kubectl get all -n epsilon
NAME                                READY   STATUS    RESTARTS   AGE
pod/mysql                           1/1     Running   0          3m32s
pod/webapp-mysql-75dfdf859f-8zfkr   1/1     Running   0          2m14s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.101.73.160   <none>        3306/TCP         3m33s
service/web-service     NodePort    10.111.193.14   <none>        8080:30081/TCP   3m32s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           3m32s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-67cfc57cbc   0         0         0       3m32s
replicaset.apps/webapp-mysql-75dfdf859f   1         1         1       2m14s
root@controlplane:~# kubectl edit pod/webapp-mysql-75dfdf859f-8zfkr -n epsilon
Edit cancelled, no changes made.
root@controlplane:~# kubectl edit pod/mysql -n epsilon
error: pods "mysql" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-8brmz.yaml"
error: Edit cancelled, no valid changes were saved.
root@controlplane:~# kubectl delete pod mysql -n epsilon
pod "mysql" deleted
kubectl apply -f /tmp/kubectl-edit-8brmz.yaml -n epsilon



root@controlplane:~# kubectl get all -n zeta
NAME                                READY   STATUS    RESTARTS   AGE
pod/mysql                           1/1     Running   0          26s
pod/webapp-mysql-67cfc57cbc-mbcsj   1/1     Running   0          26s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.103.164.30   <none>        3306/TCP         27s
service/web-service     NodePort    10.102.1.35     <none>        8080:30088/TCP   26s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           26s

NAME                                      DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-67cfc57cbc   1         1         1       26s
root@controlplane:~# kubectl edit service/web-service -n zeta
Edit cancelled, no changes made.
root@controlplane:~# kubectl edit service/mysql-service -n zeta
Edit cancelled, no changes made.
root@controlplane:~# kubectl edit pod/mysql -n zeta
A copy of your changes has been stored to "/tmp/kubectl-edit-b9kox.yaml"
error: Edit cancelled, no valid changes were saved.
root@controlplane:~# kubectl delete pod mysql -n zeta
pod "mysql" deleted
root@controlplane:~# 
root@controlplane:~# kubectl apply -f /tmp/kubectl-edit-b9kox.yaml -n zeta
pod/mysql created
root@controlplane:~#



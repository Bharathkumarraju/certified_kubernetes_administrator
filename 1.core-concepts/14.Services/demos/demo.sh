master $ kubectl get service kubernetes -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: 2020-05-01T22:58:42Z
  labels:
    component: apiserver
    provider: kubernetes
  name: kubernetes
  namespace: default
  resourceVersion: "30"
  selfLink: /api/v1/namespaces/default/services/kubernetes
  uid: 4dba4222-8bff-11ea-b8ed-0242ac110023
spec:
  clusterIP: 10.96.0.1
  ports:
  - name: https
    port: 443
    protocol: TCP
    targetPort: 6443
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
master $

master $ kubectl get all
NAME                                           READY     STATUS    RESTARTS   AGE
pod/simple-webapp-deployment-5d5b98455-767td   1/1       Running   0          8m
pod/simple-webapp-deployment-5d5b98455-mskvp   1/1       Running   0          8m
pod/simple-webapp-deployment-5d5b98455-msx6z   1/1       Running   0          8m
pod/simple-webapp-deployment-5d5b98455-xf5vg   1/1       Running   0          8m

NAME                     TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.96.0.1       <none>        443/TCP          1h
service/webapp-service   NodePort    10.101.102.19   <none>        8080:30080/TCP   2m

NAME                                       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/simple-webapp-deployment   4         4         4            4           8m

NAME                                                 DESIRED   CURRENT   READY     AGE
replicaset.apps/simple-webapp-deployment-5d5b98455   4         4         4         8m
master $
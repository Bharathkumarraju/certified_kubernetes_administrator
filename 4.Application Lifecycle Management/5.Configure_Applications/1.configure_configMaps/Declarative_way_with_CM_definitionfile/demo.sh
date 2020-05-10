bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f configmap-definition-file.yaml
configmap/application-config created
bharathdasaraju@MacBook-Pro (master) $ kubectl describe cm application-config
Name:         application-config
Namespace:    bharath
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","data":{"APP_COLOR":"red","APP_ENV":"prod","APP_NAME":"web"},"kind":"ConfigMap","metadata":{"annotations":{},"name":"ap...

Data
====
APP_COLOR:
----
red
APP_ENV:
----
prod
APP_NAME:
----
web
Events:  <none>
bharathdasaraju@MacBook-Pro (master) $
bharathdasaraju@MacBook-Pro ~ $ kubectl create configmap \
> app-config --from-literal=APP_COLOR=blue \
> --from-literal=APP_ENV=prod
configmap/app-config created
bharathdasaraju@MacBook-Pro ~ $

bharathdasaraju@MacBook-Pro ~ $ kubectl describe configmap app-config
Name:         app-config
Namespace:    bharath
Labels:       <none>
Annotations:  <none>

Data
====
APP_COLOR:
----
blue
APP_ENV:
----
prod
Events:  <none>
bharathdasaraju@MacBook-Pro ~ $

bharathdasaraju@MacBook-Pro ~ $ vim app_config.properties
bharathdasaraju@MacBook-Pro ~ $ kubectl create configmap app-config-2 --from-file app_config.properties
configmap/app-config-2 created
bharathdasaraju@MacBook-Pro ~ $

bharathdasaraju@MacBook-Pro ~ $ kubectl describe configmap app-config-2
Name:         app-config-2
Namespace:    bharath
Labels:       <none>
Annotations:  <none>

Data
====
app_config.properties:
----
APP_COLOR=blue
APP_MOD=dev
APP_NAME=webapp

Events:  <none>
bharathdasaraju@MacBook-Pro ~ $
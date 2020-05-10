$ kubectl create secret generic

bharathdasaraju@MacBook-Pro (master) $ kubectl create secret generic \
 app-secret1 \
 --from-literal=DB_HOST=mysql \
 --from-literal=DB_USER=mysql_user \
 --from-literal=DB_NAME=mysql_db \
 --from-literal=DB_PASSWORD=mysql12345

secret/app-secret created
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl describe secret app-secret1
Name:         app-secret1
Namespace:    bharath
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
------
DB_NAME:      8 bytes
DB_PASSWORD:  10 bytes
DB_USER:      10 bytes
DB_HOST:      5 bytes
bharathdasaraju@MacBook-Pro (master) $

---------------------------------------------------------------->
create secret from a file.

bharathdasaraju@MacBook-Pro (master) $ kubectl create secret generic \
>  app-secret2 --from-file app_secret.properties
secret/app-secret2 created
bharathdasaraju@MacBook-Pro (master) $ kubectl describe secrets app-secret2
Name:         app-secret2
Namespace:    bharath
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
------
app_config.properties:  66 bytes
bharathdasaraju@MacBook-Pro (master) $

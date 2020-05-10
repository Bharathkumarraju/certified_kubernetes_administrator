bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f secret_data.yaml
Error from server (BadRequest): error when creating "secret_data.yaml": Secret in version "v1"
cannot be handled as a Secret: v1.Secret.Data: decode base64: illegal base64 data at input byte 4,
error found in #10 byte of ...|T":"mysql","DB_NAME"|...,
 bigger context ...|{"apiVersion":"v1","
 data":{
"DB_HOST":"mysql",
"DB_NAME":"mysql1",
"DB_PASS":"mysql123",
"DB_USER"|...

bharathdasaraju@MacBook-Pro (master) $

echo "when you apply secrets with declarative form you have to encode the values using base64"

bharathdasaraju@MacBook-Pro (master) $ echo -n 'mysql' | base64
bXlzcWw=
bharathdasaraju@MacBook-Pro (master) $ echo -n 'mysql1' | base64
bXlzcWwx
bharathdasaraju@MacBook-Pro (master) $ echo -n 'mysql12' | base64
bXlzcWwxMg==
bharathdasaraju@MacBook-Pro (master) $ echo -n 'mysql123' | base64
bXlzcWwxMjM=
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f secret_data.yaml
secret/app-secret3 created
bharathdasaraju@MacBook-Pro (master) $


bharathdasaraju@MacBook-Pro (master) $ kubectl describe secret app-secret3
Name:         app-secret3
Namespace:    bharath
Labels:       <none>
Annotations:
Type:         Opaque

Data
----
DB_HOST:  5 bytes
DB_NAME:  6 bytes
DB_PASS:  8 bytes
DB_USER:  7 bytes
bharathdasaraju@MacBook-Pro (master) $

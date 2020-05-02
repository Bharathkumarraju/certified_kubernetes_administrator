master $ kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
nginx-pod   1/1     Running   0          5m58s
redis       1/1     Running   0          60s
master $

master $ kubectl expose pod redis --name redis-service --port=6379
service/redis-service exposed
master $ kubectl edit service redis-service

master $ kubectl get service/redis-service -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2020-05-02T01:41:48Z"
  labels:
    run: redis
    tier: db
  name: redis-service
  namespace: default
  resourceVersion: "1345"
  selfLink: /api/v1/namespaces/default/services/redis-service
  uid: ea28f568-1d27-4303-be39-aeffb8e232b1
spec:
  clusterIP: 10.103.26.255
  ports:
  - port: 6379
    protocol: TCP
    targetPort: 6379
  selector:
    run: redis
    tier: db
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}
master $


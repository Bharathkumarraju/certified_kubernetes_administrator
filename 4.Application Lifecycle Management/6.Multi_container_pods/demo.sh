master $ kubectl get all -n elastic-stack
NAME                 READY   STATUS    RESTARTS   AGE
pod/app              1/1     Running   0          9m18s
pod/elastic-search   1/1     Running   0          9m18s
pod/kibana           1/1     Running   0          9m18s

NAME                    TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.110.96.92    <none>        9200:30200/TCP,9300:30300/TCP   9m18s
service/kibana          NodePort   10.101.195.21   <none>        5601:30601/TCP                  9m18s
master $


Question:
---------->
Edit the app pod to add a sidecar container to send logs to ElasticSearch.
Mount the log volume to the sidecar container.

Only add a new container. Do not modify anything else. Use the spec on the right.

Name: app
Container Name: sidecar
Container Image: kodekloud/filebeat-configured
Volume Mount: log-volume
Mount Path: /var/log/event-simulator/
Existing Container Name: app
Existing Container Image: kodekloud/event-simulator

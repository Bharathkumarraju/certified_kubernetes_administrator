root@controlplane:~# kubectl get pods
NAME        READY   STATUS              RESTARTS   AGE
app         0/1     ContainerCreating   0          44s
blue        0/2     ContainerCreating   0          5s
fluent-ui   1/1     Running             0          45s
red         0/3     ContainerCreating   0          34s
root@controlplane:~# kubectl describe pod blue
Name:         blue
Namespace:    default
Priority:     0
Node:         controlplane/10.6.30.8
Start Time:   Tue, 21 Sep 2021 04:34:53 +0000
Labels:       <none>
Annotations:  <none>
Status:       Pending
IP:           
IPs:          <none>
Containers:
  teal:
    Container ID:  
    Image:         busybox
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      4500
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-9gh8c (ro)
  navy:
    Container ID:  
    Image:         busybox
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      4500
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-9gh8c (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  default-token-9gh8c:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-9gh8c
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  23s   default-scheduler  Successfully assigned default/blue to controlplane
  Normal  Pulling    20s   kubelet            Pulling image "busybox"
root@controlplane:~# 


Create a multi-container pod with 2 containers.

Name: yellow
Container 1 Name: lemon
Container 1 Image: busybox
Container 2 Name: gold
Container 2 Image: redi

If the pod goes into the crashloopbackoff then add sleep 1000 in the lemon container.

root@controlplane:~# cat multi_contianer.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: yellow
  name: yellow
spec:
  containers:
  - image: busybox
    name: lemon 
    command:
     - "sleep"
     - "1000"
  - image: redis
    name: gold
root@controlplane:~# 


root@controlplane:~# kubectl apply -f multi_contianer.yaml
pod/yellow created
root@controlplane:~# 


root@controlplane:~# kubectl describe pod yellow
Name:         yellow
Namespace:    default
Priority:     0
Node:         controlplane/10.6.30.8
Start Time:   Tue, 21 Sep 2021 04:46:45 +0000
Labels:       run=yellow
Annotations:  <none>
Status:       Running
IP:           10.244.0.11
IPs:
  IP:  10.244.0.11
Containers:
  lemon:
    Container ID:  docker://d2ac7da68aeeddc4a7661576c0d776ad4ae8506e78ae757a1243d90d1eab1bc9
    Image:         busybox
    Image ID:      docker-pullable://busybox@sha256:52f73a0a43a16cf37cd0720c90887ce972fe60ee06a687ee71fb93a7ca601df7
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      1000
    State:          Running
      Started:      Tue, 21 Sep 2021 04:46:49 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-9gh8c (ro)
  gold:
    Container ID:   docker://57bec715dc98f4bd723f17b0170f4467ca10a7496d0d518ec79781c9e29b7555
    Image:          redis
    Image ID:       docker-pullable://redis@sha256:e595e79c05c7690f50ef0136acc9d932d65d8b2ce7915d26a68ca3fb41a7db61
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 21 Sep 2021 04:47:01 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-9gh8c (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  default-token-9gh8c:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-9gh8c
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  28s   default-scheduler  Successfully assigned default/yellow to controlplane
  Normal  Pulling    25s   kubelet            Pulling image "busybox"
  Normal  Pulled     25s   kubelet            Successfully pulled image "busybox" in 264.575064ms
  Normal  Created    25s   kubelet            Created container lemon
  Normal  Started    24s   kubelet            Started container lemon
  Normal  Pulling    24s   kubelet            Pulling image "redis"
  Normal  Pulled     13s   kubelet            Successfully pulled image "redis" in 11.216716468s
  Normal  Created    12s   kubelet            Created container gold
  Normal  Started    12s   kubelet            Started container gold
root@controlplane:~# 


root@controlplane:~# kubectl get all -n elastic-stack
NAME                 READY   STATUS    RESTARTS   AGE
pod/app              1/1     Running   0          14m
pod/elastic-search   1/1     Running   0          14m
pod/kibana           1/1     Running   0          14m

NAME                    TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
service/elasticsearch   NodePort   10.102.56.7      <none>        9200:30200/TCP,9300:30300/TCP   14m
service/kibana          NodePort   10.109.206.204   <none>        5601:30601/TCP                  14m
root@controlplane:~# 


root@controlplane:~# kubectl logs kibana -n elastic-stack | tail
{"type":"log","@timestamp":"2021-09-21T04:37:42Z","tags":["status","plugin:logstash@6.4.2","info"],"pid":1,"state":"green","message":"Status changed from red to green - Ready","prevState":"red","prevMsg":"Request Timeout after 3000ms"}
{"type":"log","@timestamp":"2021-09-21T04:37:42Z","tags":["status","plugin:reporting@6.4.2","info"],"pid":1,"state":"green","message":"Status changed from red to green - Ready","prevState":"red","prevMsg":"Request Timeout after 3000ms"}
{"type":"log","@timestamp":"2021-09-21T04:37:42Z","tags":["info","monitoring-ui","kibana-monitoring"],"pid":1,"message":"Starting monitoring stats collection"}
{"type":"log","@timestamp":"2021-09-21T04:37:42Z","tags":["status","plugin:security@6.4.2","info"],"pid":1,"state":"green","message":"Status changed from red to green - Ready","prevState":"red","prevMsg":"Request Timeout after 3000ms"}
{"type":"log","@timestamp":"2021-09-21T04:37:43Z","tags":["license","info","xpack"],"pid":1,"message":"Imported license information from Elasticsearch for the [monitoring] cluster: mode: basic | status: active"}
{"type":"log","@timestamp":"2021-09-21T04:37:45Z","tags":["status","plugin:elasticsearch@6.4.2","info"],"pid":1,"state":"green","message":"Status changed from red to green - Ready","prevState":"red","prevMsg":"Request Timeout after 3000ms"}
{"type":"log","@timestamp":"2021-09-21T04:37:56Z","tags":["info","http","server","listening"],"pid":1,"message":"Server running at http://0:5601"}
{"type":"response","@timestamp":"2021-09-21T04:37:57Z","tags":[],"pid":1,"method":"head","statusCode":200,"req":{"url":"/","method":"head","headers":{"host":"0.0.0.0:30601","user-agent":"curl/7.58.0","accept":"*/*"},"remoteAddress":"10.244.0.1","userAgent":"10.244.0.1"},"res":{"statusCode":200,"responseTime":37,"contentLength":9},"message":"HEAD / 200 37ms - 9.0B"}
{"type":"response","@timestamp":"2021-09-21T04:38:07Z","tags":[],"pid":1,"method":"post","statusCode":200,"req":{"url":"/api/saved_objects/index-pattern/filebeat-*?overwrite=false","method":"post","headers":{"host":"0.0.0.0:30601","user-agent":"curl/7.58.0","accept":"*/*","content-type":"application/json","kbn-xsrf":"athing","content-length":"66"},"remoteAddress":"10.244.0.1","userAgent":"10.244.0.1"},"res":{"statusCode":200,"responseTime":1425,"contentLength":9},"message":"POST /api/saved_objects/index-pattern/filebeat-*?overwrite=false 200 1425ms - 9.0B"}
{"type":"response","@timestamp":"2021-09-21T04:38:08Z","tags":[],"pid":1,"method":"post","statusCode":200,"req":{"url":"/api/kibana/settings/defaultIndex","method":"post","headers":{"host":"0.0.0.0:30601","user-agent":"curl/7.58.0","accept":"*/*","content-type":"application/json","kbn-xsrf":"anytng","content-length":"22"},"remoteAddress":"10.244.0.1","userAgent":"10.244.0.1"},"res":{"statusCode":200,"responseTime":2068,"contentLength":9},"message":"POST /api/kibana/settings/defaultIndex 200 2068ms - 9.0B"}
root@controlplane:~# 


root@controlplane:~# kubectl logs elastic-search -n elastic-stack | tail
[2021-09-21T04:38:07,531][INFO ][o.e.c.m.MetaDataCreateIndexService] [gTtv6_7] [.kibana] creating index, cause [auto(bulk api)], templates [kibana_index_template:.kibana], shards [1]/[1], mappings [doc]
[2021-09-21T04:38:07,541][INFO ][o.e.c.r.a.AllocationService] [gTtv6_7] updating number_of_replicas to [0] for indices [.kibana]
[2021-09-21T04:38:08,123][INFO ][o.e.c.r.a.AllocationService] [gTtv6_7] Cluster health status changed from [YELLOW] to [GREEN] (reason: [shards started [[.kibana][0]] ...]).
[2021-09-21T04:38:08,844][WARN ][o.e.d.a.a.i.t.p.PutIndexTemplateRequest] Deprecated field [template] used, replaced by [index_patterns]
[2021-09-21T04:38:08,920][INFO ][o.e.c.m.MetaDataIndexTemplateService] [gTtv6_7] adding template [kibana_index_template:.kibana] for index patterns [.kibana]
[2021-09-21T04:38:09,119][WARN ][o.e.d.a.a.i.t.p.PutIndexTemplateRequest] Deprecated field [template] used, replaced by [index_patterns]
[2021-09-21T04:38:09,127][INFO ][o.e.c.m.MetaDataIndexTemplateService] [gTtv6_7] adding template [kibana_index_template:.kibana] for index patterns [.kibana]
[2021-09-21T04:38:09,836][WARN ][o.e.d.a.a.i.t.p.PutIndexTemplateRequest] Deprecated field [template] used, replaced by [index_patterns]
[2021-09-21T04:38:09,845][INFO ][o.e.c.m.MetaDataIndexTemplateService] [gTtv6_7] adding template [kibana_index_template:.kibana] for index patterns [.kibana]
[2021-09-21T04:38:09,923][INFO ][o.e.c.m.MetaDataMappingService] [gTtv6_7] [.kibana/3bcSc1d9S1CcqH-FLhLPaw] update_mapping [doc]
root@controlplane:~# 



Edit the pod to add a sidecar container to send logs to Elastic Search. Mount the log volume to the sidecar container.
Only add a new container.


Name: app
Container Name: sidecar
Container Image: kodekloud/filebeat-configured
Volume Mount: log-volume
Mount Path: /var/log/event-simulator/
Existing Container Name: app
Existing Container Image: kodekloud/event-simulator


spec:
  containers:
  - image: kodekloud/filebeat-configured
    name: sidecar
    volumeMounts:
    - mountPath: /var/log/event-simulator/
      name: log-volume
  - image: kodekloud/event-simulator
    imagePullPolicy: Always
    name: app
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /log
      name: log-volume
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: default-token-9tt4w
      readOnly: true




root@controlplane:~# kubectl edit pod app -n elastic-stack
error: pods "app" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-cao9c.yaml"
error: Edit cancelled, no valid changes were saved.
root@controlplane:~# kubectl edit pod app -n elastic-stack
Edit cancelled, no changes made.
root@controlplane:~# kubectl delete pod app -n elastic-stack
pod "app" deleted
kubectl apply -f /tmp/kubectl-edit-cao9c.yaml
root@controlplane:~# kubectl apply -f /tmp/kubectl-edit-cao9c.yaml
pod/app created
root@controlplane:~# 


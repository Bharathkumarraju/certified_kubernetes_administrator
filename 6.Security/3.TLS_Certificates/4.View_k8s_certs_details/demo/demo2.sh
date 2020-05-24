master $ kubectl get pod etcd-master -n kube-system
NAME          READY   STATUS    RESTARTS   AGE
etcd-master   1/1     Running   0          90m

master $ kubectl get pod etcd-master -n kube-system -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubernetes.io/config.hash: 3eb8fec805b4b57315e321411d30b489
    kubernetes.io/config.mirror: 3eb8fec805b4b57315e321411d30b489
    kubernetes.io/config.seen: "2020-05-24T00:33:31.118053404Z"
    kubernetes.io/config.source: file
  creationTimestamp: "2020-05-24T00:35:02Z"
  labels:
    component: etcd
    tier: control-plane
  name: etcd-master
  namespace: kube-system  resourceVersion: "580"
  selfLink: /api/v1/namespaces/kube-system/pods/etcd-master
  uid: 2ab94e4a-92c8-4b7b-9b95-b7dc6ded5599
spec:
  containers:
  - command:
    - etcd
    - --advertise-client-urls=https://172.17.0.17:2379
    - --cert-file=/etc/kubernetes/pki/etcd/server.crt
    - --client-cert-auth=true
    - --data-dir=/var/lib/etcd
    - --initial-advertise-peer-urls=https://172.17.0.17:2380
    - --initial-cluster=master=https://172.17.0.17:2380
    - --key-file=/etc/kubernetes/pki/etcd/server.key
    - --listen-client-urls=https://127.0.0.1:2379,https://172.17.0.17:2379
    - --listen-metrics-urls=http://127.0.0.1:2381
    - --listen-peer-urls=https://172.17.0.17:2380
    - --name=master
    - --peer-cert-file=/etc/kubernetes/pki/etcd/peer.crt
    - --peer-client-cert-auth=true
    - --peer-key-file=/etc/kubernetes/pki/etcd/peer.key
    - --peer-trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    - --snapshot-count=10000
    - --trusted-ca-file=/etc/kubernetes/pki/etcd/ca.crt
    image: k8s.gcr.io/etcd:3.3.15-0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /health
        port: 2381
        scheme: HTTP
      initialDelaySeconds: 15
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 15
    name: etcd
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/lib/etcd
      name: etcd-data
    - mountPath: /etc/kubernetes/pki/etcd
      name: etcd-certs
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  hostNetwork: true
  nodeName: master
  priority: 2000000000
  priorityClassName: system-cluster-critical
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    operator: Exists
  volumes:
  - hostPath:
      path: /etc/kubernetes/pki/etcd
      type: DirectoryOrCreate
    name: etcd-certs
  - hostPath:
      path: /var/lib/etcd
      type: DirectoryOrCreate
    name: etcd-data
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2020-05-24T00:33:34Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2020-05-24T00:33:36Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2020-05-24T00:33:36Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2020-05-24T00:33:34Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: docker://81dfcebec8869cc744409948d4bbe331d2cd51737ef011a591cd939ab5105a34
    image: k8s.gcr.io/etcd:3.3.15-0
    imageID: docker-pullable://k8s.gcr.io/etcd@sha256:12c2c5e5731c3bcd56e6f1c05c0f9198b6f06793fa7fca2fb43aab9622dc4afa
    lastState: {}
    name: etcd
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2020-05-24T00:33:35Z"
  hostIP: 172.17.0.17
  phase: Running
  podIP: 172.17.0.17
  podIPs:
  - ip: 172.17.0.17
  qosClass: BestEffort
  startTime: "2020-05-24T00:33:34Z"
master $

master $ openssl x509 -in /etc/kubernetes/pki/etcd/server.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 5365032554761187138 (0x4a746caef2f26f42)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=etcd-ca
        Validity
            Not Before: May 24 00:33:19 2020 GMT
            Not After : May 24 00:33:19 2021 GMT
        Subject: CN=master
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:ce:03:e3:15:08:24:99:2e:e6:7f:7e:e3:76:54:
                    55:95:0c:0c:85:af:d0:1c:f5:37:47:22:a6:48:5d:
                    ef:63:ea:57:95:95:02:e9:6d:3e:6c:fd:06:7f:d6:
                    5a:93:e7:7e:ba:03:cc:03:6c:ed:9b:a8:c6:1a:a0:
                    1d:3a:db:4f:34:b9:5a:94:7a:12:dc:46:df:47:4c:
                    36:53:65:34:93:bb:e0:15:73:50:4b:bf:68:d4:88:
                    c5:f9:96:8f:93:59:16:d9:18:f8:52:bc:55:b1:a1:
                    cc:ad:60:44:b7:5d:9b:e4:62:a7:62:de:8d:c0:33:
                    ea:11:86:e0:23:f4:a4:4e:30:fd:9a:b8:87:b3:5c:
                    26:8c:2e:f9:56:c8:26:a9:9d:62:20:7c:a9:85:6e:
                    53:2c:2f:a8:5c:4b:c8:e4:c6:17:82:b4:b1:c3:a0:
                    92:25:1c:e4:8e:6e:e9:db:37:36:17:72:27:c8:20:
                    6f:0a:d0:08:02:1a:bf:6f:f4:20:bd:77:1f:e1:6f:
                    57:7f:fb:e7:55:3b:bb:15:b3:45:ad:55:9a:54:14:
                    90:80:c5:76:3a:76:d2:a8:35:a5:68:28:ab:2b:52:
                    07:3d:41:d4:bb:24:b3:5b:ef:3d:f5:95:15:94:28:
                    d5:3c:bd:e6:4c:02:27:51:f7:a7:4f:89:ea:fa:14:
                    2d:8f
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage:
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Subject Alternative Name:
                DNS:master, DNS:localhost, IP Address:172.17.0.17, IP Address:127.0.0.1, IP Address:0:0:0:0:0:0:0:1
    Signature Algorithm: sha256WithRSAEncryption
         19:20:39:57:cb:9b:cc:45:73:bb:d1:a8:bc:aa:81:fd:92:91:
         01:a5:b3:8b:4b:d5:3e:d7:30:67:bc:6a:6c:c0:fd:57:79:d1:
         fd:b8:a7:4c:70:4a:2a:cf:df:f7:d5:cb:82:6e:94:57:0a:19:
         89:af:46:4d:7a:86:71:26:f5:a4:fb:43:6e:d4:07:51:22:73:
         d2:36:93:fa:1d:00:15:f5:fd:ce:d4:2c:30:f6:8c:e7:85:b2:
         22:ef:e1:88:12:03:83:1a:1b:4a:e9:77:2a:94:63:f9:10:3c:
         e2:06:78:e1:cf:48:96:b3:7a:68:5a:a2:cf:c2:9c:85:54:e2:
         e0:f8:5a:c9:ca:3a:14:cc:37:6f:91:cd:0e:c4:ae:7c:d3:05:
         ed:e6:ba:d5:81:2e:c5:2f:0d:1a:69:68:ff:f3:7a:15:6d:94:
         db:72:21:fa:16:bf:f8:8a:96:e3:90:fc:cd:f4:3a:d7:78:0e:
         a3:93:a2:74:73:d3:5d:a4:48:2f:50:27:e8:34:d8:40:71:67:
         ff:07:5d:6d:c7:9c:28:a5:7b:8e:61:a8:7c:18:28:05:1e:46:
         8b:55:b1:c9:d0:4b:2c:a2:c7:40:c2:4e:ae:e4:8c:cd:6d:59:
         a0:ef:f6:a3:60:3f:f0:21:06:0b:09:f0:24:2b:60:19:a2:78:
         bf:ad:ee:90
master $
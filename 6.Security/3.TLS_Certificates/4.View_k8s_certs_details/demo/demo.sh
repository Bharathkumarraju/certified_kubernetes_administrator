master $ kubectl get pods
No resources found in default namespace.
master $ kubectl get pods --all-namespaces
NAMESPACE     NAME                             READY   STATUS    RESTARTS   AGE
kube-system   coredns-5644d7b6d9-5c2wc         1/1     Running   0          85m
kube-system   coredns-5644d7b6d9-rqjct         1/1     Running   0          85m
kube-system   etcd-master                      1/1     Running   0          84m
kube-system   kube-apiserver-master            1/1     Running   0          84m
kube-system   kube-controller-manager-master   1/1     Running   0          84m
kube-system   kube-proxy-dw9xr                 1/1     Running   0          85m
kube-system   kube-proxy-qfbw7                 1/1     Running   0          85m
kube-system   kube-scheduler-master            1/1     Running   0          84m
kube-system   weave-net-cmzkg                  2/2     Running   0          85m
kube-system   weave-net-xzrfz                  2/2     Running   1          85m
master $


master $ kubectl get pod kube-apiserver-master -n kube-system -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubernetes.io/config.hash: 0cb9fec08d0cea5cd2cb747e8c60d0d6
    kubernetes.io/config.mirror: 0cb9fec08d0cea5cd2cb747e8c60d0d6
    kubernetes.io/config.seen: "2020-05-24T00:33:31.118054967Z"
    kubernetes.io/config.source: file
  creationTimestamp: "2020-05-24T00:34:58Z"
  labels:
    component: kube-apiserver
    tier: control-plane
  name: kube-apiserver-master
  namespace: kube-system
  resourceVersion: "581"
  selfLink: /api/v1/namespaces/kube-system/pods/kube-apiserver-master
  uid: ddce7937-836a-4d4a-ba04-0aeb656eca1d
spec:
  containers:
  - command:
    - kube-apiserver
    - --advertise-address=172.17.0.17
    - --allow-privileged=true
    - --authorization-mode=Node,RBAC
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --enable-admission-plugins=NodeRestriction
    - --enable-bootstrap-token-auth=true
    - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --etcd-keyfile=/etc/kubernetes/pki/apiserver-etcd-client.key
    - --etcd-servers=https://127.0.0.1:2379
    - --insecure-port=0
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
    - --kubelet-client-key=/etc/kubernetes/pki/apiserver-kubelet-client.key
    - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
    - --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
    - --proxy-client-key-file=/etc/kubernetes/pki/front-proxy-client.key
    - --requestheader-allowed-names=front-proxy-client
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --requestheader-extra-headers-prefix=X-Remote-Extra-
    - --requestheader-group-headers=X-Remote-Group
    - --requestheader-username-headers=X-Remote-User
    - --secure-port=6443
    - --service-account-key-file=/etc/kubernetes/pki/sa.pub
    - --service-cluster-ip-range=10.96.0.0/12
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt
    - --tls-private-key-file=/etc/kubernetes/pki/apiserver.key
    image: k8s.gcr.io/kube-apiserver:v1.16.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 172.17.0.17
        path: /healthz
        port: 6443
        scheme: HTTPS
      initialDelaySeconds: 15
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 15
    name: kube-apiserver
    resources:
      requests:
        cpu: 250m
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /etc/pki
      name: etc-pki
      readOnly: true
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
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
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /etc/pki
      type: DirectoryOrCreate
    name: etc-pki
  - hostPath:
      path: /etc/kubernetes/pki
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
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
  - containerID: docker://c04cebf452d7ed779ebc7cefa6e3e6ff3c8f7eacf635b5a472afae53872e8357
    image: k8s.gcr.io/kube-apiserver:v1.16.0
    imageID: docker-pullable://k8s.gcr.io/kube-apiserver@sha256:f4168527c91289da2708f62ae729fdde5fb484167dd05ffbb7ab666f60de96cd
    lastState: {}
    name: kube-apiserver
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
  qosClass: Burstable
  startTime: "2020-05-24T00:33:34Z"
master $


master $ openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 8205990816354696687 (0x71e1892b96f07def)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=kubernetes
        Validity
            Not Before: May 24 00:33:18 2020 GMT
            Not After : May 24 00:33:18 2021 GMT
        Subject: CN=kube-apiserver
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:d0:b5:f6:37:0d:03:7f:a9:e7:26:ba:c5:49:7c:
                    1f:e4:4c:10:10:08:7a:32:33:54:95:d1:51:70:8e:
                    9a:e0:32:b4:34:ba:b6:58:9d:9c:2c:2f:30:e7:06:
                    bd:f3:b9:81:76:65:44:7e:8a:99:d8:ad:39:d1:35:
                    ae:12:e2:d9:ae:66:1c:cd:26:82:0c:8f:80:3d:72:
                    33:87:b2:89:7c:ce:4a:46:39:8c:bb:86:f2:89:a5:
                    6d:3f:47:36:ab:d7:c1:f7:66:c9:c2:ce:0e:39:59:
                    4e:f5:27:ac:6f:87:3a:bb:43:8a:bc:34:e0:44:97:
                    fe:23:25:12:5a:30:65:2a:33:27:dd:51:51:fd:47:
                    28:98:4d:5c:e8:e2:76:f8:3c:6d:4c:d8:ea:3b:53:
                    e9:21:cc:fe:8e:4d:38:fe:93:a1:20:be:d4:0e:43:
                    04:18:96:93:30:10:f4:8d:82:dc:13:ce:da:08:86:
                    96:be:48:0b:a3:1f:2e:65:58:78:c8:09:1d:80:31:
                    77:fd:43:79:9a:f6:31:54:c2:ad:e5:0a:b7:ae:ec:
                    13:a5:3e:df:46:33:cc:d8:1e:69:b6:f3:05:2c:17:
                    03:a6:bf:af:ed:00:27:e2:61:12:67:62:83:93:f1:
                    53:cf:c6:85:9b:a6:d5:24:42:43:a2:9c:76:d4:d2:
                    62:7f
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage:
                TLS Web Server Authentication
            X509v3 Subject Alternative Name:
                DNS:master, DNS:kubernetes, DNS:kubernetes.default, DNS:kubernetes.default.svc, DNS:kubernetes.default.svc.cluster.local, IP Address:10.96.0.1, IP Address:172.17.0.17
    Signature Algorithm: sha256WithRSAEncryption
         c0:b5:72:01:69:68:cf:97:14:66:4a:8b:6c:d5:8d:d0:df:7b:
         fe:ac:c6:c5:a0:62:d4:c2:2f:97:30:d3:cd:69:36:37:98:5b:
         ee:68:c8:09:62:f4:8c:3e:36:54:70:2b:4d:32:bd:fd:9d:58:
         10:57:c7:53:44:01:80:5b:0e:73:4c:4d:c6:c7:90:9c:66:cd:
         4c:96:2e:54:33:35:df:56:a7:c8:9e:0c:8a:63:d6:79:91:e3:
         36:a6:79:eb:c9:1f:5a:e6:70:24:ee:04:67:e6:44:49:98:6a:
         7a:59:e5:9d:9c:63:28:e3:61:ab:66:2b:7f:da:cf:f5:a7:e4:
         80:00:c3:76:1b:7a:2d:ac:95:a4:91:94:70:bc:1f:eb:c9:50:
         b5:ae:5e:4e:b3:c1:6e:ce:4e:9a:69:9f:21:21:03:87:4b:5c:
         e4:e0:b6:b9:09:9e:82:89:97:b9:05:d0:88:06:0b:1f:ea:4d:
         63:44:4e:a1:4d:7e:c4:17:d1:72:b3:33:6e:17:70:09:87:55:
         1e:23:37:ce:a1:fc:7f:30:03:28:90:39:39:09:a6:f1:6b:c6:
         52:d3:43:83:f7:48:06:4f:27:b7:e5:5b:6c:7a:d6:3e:ea:f5:
         86:f1:1a:09:ae:ae:d4:c8:66:18:6c:f8:06:9e:1c:d7:76:e4:
         3a:5c:7a:7e
master $

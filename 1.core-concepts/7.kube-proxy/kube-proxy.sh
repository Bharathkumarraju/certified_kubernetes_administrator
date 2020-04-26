With in the kubernetes cluster every pod can reach every other pod irresepective of the namespaces they are in.

This is accomplished by deploying a POD networking solution to the cluster.
A pod network is a internal virtual network that spwans across all the nodes in the cluster to which all the pods connect to.

Through this network pods able to communicate with each other.

There are many solutions available to deploy the pod networking.

Let say i have a
Web application deployed first node.
and the Database application depoyed on second node.

The web app can reach the database simply by using the IP of the pod. but there is no guaranty that the
IP of the database pod is always remain the same.

So better way to web app to access the database is using the service.
So we create the service to expose the database application across the cluster.

So now web application access the database using the name of the service(db).
The service also gets an IP Address assigned to it,
whenever a pod tries to reach the service using its IP (or) name,it forwards the traffic to the backend pod in this case its the database.

But what is this service and how doest it gets an IP, does the service join the same pod network?

The Service can not join the pod network, because the service is not an actual thing,it is not a container like pods.
Sevices does not have any interfaces (or) an actively listening processes.
Service is a virtual component that only lives in the kubernetes memory.
but then we also said that the service should be accessible across the cluster from any nodes.so how is that achieved.

That is were "kube-proxy" comes into picture.

kube-proxy is a process that runs each worker node in the kubernetes cluster.
Its job is to look for new services and every time a new service is created,
kube-proxy will create appropriate rules on each node to forward traffic to those services to the backend pods.

One way it does this is using iptables rules. In this case kube-proxy creates an iptables rules on each node in the cluster,
to forward traffic heading to the IP of the service to the IP of the actual backend database pod.


Since I am using minikube in my mac ... i can view iptables rule using pfctl command as below.

bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ sudo pfctl -sa
No ALTQ support in kernel
ALTQ related functions disabled
TRANSLATION RULES:
nat-anchor "com.apple/*" all
nat-anchor "com.apple.internet-sharing" all
rdr-anchor "com.apple/*" all
rdr-anchor "com.apple.internet-sharing" all

FILTER RULES:
scrub-anchor "com.apple/*" all fragment reassemble
scrub-anchor "com.apple.internet-sharing" all fragment reassemble
anchor "com.apple/*" all
anchor "com.apple.internet-sharing" all

DUMMYNET RULES:
dummynet-anchor "com.apple/*" all

STATES:
ALL tcp 192.168.1.17:56993 -> 17.57.145.5:5223       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:57020 -> 23.66.108.27:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58516 -> 74.125.200.188:5228       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58520 -> 18.136.186.65:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58545 -> 104.16.91.52:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58565 -> 34.237.73.95:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58642 -> 104.16.246.29:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58651 -> 54.192.151.129:443       ESTABLISHED:FIN_WAIT_2
ALL tcp 192.168.1.17:58652 -> 54.192.151.88:443       TIME_WAIT:TIME_WAIT
ALL tcp 192.168.1.17:58654 -> 151.101.193.69:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58656 -> 104.16.3.35:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58658 -> 23.35.90.36:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58659 -> 54.192.151.55:443       TIME_WAIT:TIME_WAIT
ALL tcp 192.168.1.17:58668 -> 198.252.206.25:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58672 -> 35.186.220.184:443       ESTABLISHED:ESTABLISHED
ALL udp 224.0.0.251:5353 <- 192.168.1.13:5353       NO_TRAFFIC:SINGLE
ALL udp ff02::fb[5353] <- fe80::106f:1056:148d:9939[5353]       NO_TRAFFIC:SINGLE
ALL tcp 192.168.1.17:58673 -> 208.123.73.73:443       ESTABLISHED:FIN_WAIT_2
ALL tcp 192.168.1.17:58674 -> 208.123.73.73:443       ESTABLISHED:FIN_WAIT_2
ALL tcp 192.168.1.17:58675 -> 208.123.73.73:443       ESTABLISHED:FIN_WAIT_2
ALL tcp 192.168.1.17:58676 -> 208.123.73.73:443       ESTABLISHED:FIN_WAIT_2
ALL tcp 192.168.1.17:58677 -> 208.123.73.73:443       ESTABLISHED:FIN_WAIT_2
ALL tcp 192.168.1.17:58678 -> 128.100.17.244:443       ESTABLISHED:FIN_WAIT_2
ALL tcp 192.168.1.17:58679 -> 128.100.17.244:443       ESTABLISHED:FIN_WAIT_2
ALL tcp 192.168.1.17:58681 -> 104.17.186.73:443       ESTABLISHED:ESTABLISHED
ALL tcp 192.168.1.17:58682 -> 104.16.86.5:443       ESTABLISHED:ESTABLISHED
ALL udp 192.168.1.17:64173 -> 74.125.68.95:443       MULTIPLE:MULTIPLE
ALL udp 192.168.1.17:60732 -> 172.217.194.94:443       MULTIPLE:MULTIPLE
ALL udp 192.168.1.17:51730 -> 172.217.194.99:443       MULTIPLE:MULTIPLE
ALL udp ff02::fb[5353] <- fe80::c031:61ea:f3b2:217c[5353]       NO_TRAFFIC:SINGLE
ALL udp 192.168.1.17:54203 -> 74.125.24.102:443       MULTIPLE:MULTIPLE
ALL igmp 224.0.0.2 <- 192.168.1.14       NO_TRAFFIC:SINGLE
ALL udp 192.168.1.17:56981 -> 172.217.194.99:443       MULTIPLE:MULTIPLE
ALL igmp 224.0.0.1 <- 192.168.1.254       NO_TRAFFIC:SINGLE
ALL igmp 224.0.0.251 <- 192.168.1.3       NO_TRAFFIC:SINGLE
ALL igmp 224.0.0.252 <- 192.168.1.3       NO_TRAFFIC:SINGLE
ALL igmp 239.255.255.250 <- 192.168.1.3       NO_TRAFFIC:SINGLE
ALL icmp ff02::1:ff54:c6cd[0] <- ::[0]       0:0
ALL udp 255.255.255.255:67 <- 0.0.0.0:68       NO_TRAFFIC:SINGLE
ALL icmp ff02::16[0] <- ::[0]       0:0

INFO:
Status: Enabled for 8 days 03:22:04           Debug: Urgent

State Table                          Total             Rate
  current entries                       40
  searches                        21967266           31.2/s
  inserts                           128013            0.2/s
  removals                          127973            0.2/s
Counters
  match                             988220            1.4/s
  bad-offset                             0            0.0/s
  fragment                               0            0.0/s
  short                                  0            0.0/s
  normalize                              0            0.0/s
  memory                                 0            0.0/s
  bad-timestamp                          0            0.0/s
  congestion                             0            0.0/s
  ip-option                           9618            0.0/s
  proto-cksum                            0            0.0/s
  state-mismatch                       753            0.0/s
  state-insert                           0            0.0/s
  state-limit                            0            0.0/s
  src-limit                              0            0.0/s
  synproxy                               0            0.0/s
  dummynet                               0            0.0/s

TIMEOUTS:
tcp.first                   120s
tcp.opening                  30s
tcp.established           86400s
tcp.closing                 900s
tcp.finwait                  45s
tcp.closed                   90s
tcp.tsdiff                   60s
udp.first                    60s
udp.single                   30s
udp.multiple                120s
icmp.first                   20s
icmp.error                   10s
grev1.first                 120s
grev1.initiating             30s
grev1.estblished           1800s
esp.first                   120s
esp.estblished              900s
other.first                  60s
other.single                 30s
other.multiple              120s
frag                         30s
interval                     10s
adaptive.start             6000 states
adaptive.end              12000 states
src.track                     0s

LIMITS:
states        hard limit    10000
app-states    hard limit    10000
src-nodes     hard limit    10000
frags         hard limit     5000
tables        hard limit     1000
table-entries hard limit   200000

TABLES:

OS FINGERPRINTS:
696 fingerprints loaded
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $


installing kube-proxy:
------------------------>
download a binary k8s official page
kube-proxy deployed as a daemonset

bharathdasaraju@MacBook-Pro $ kubectl get ds/kube-proxy -n kube-system -o wide
NAME         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS   IMAGES                          SELECTOR
kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   27d   kube-proxy   k8s.gcr.io/kube-proxy:v1.18.0   k8s-app=kube-proxy
bharathdasaraju@MacBook-Pro $


bharathdasaraju@MacBook-Pro $ kubectl get pod/kube-proxy-gbxft -n kube-system -o wide
NAME               READY   STATUS    RESTARTS   AGE   IP             NODE       NOMINATED NODE   READINESS GATES
kube-proxy-gbxft   1/1     Running   2          27d   192.168.64.2   minikube   <none>           <none>
bharathdasaraju@MacBook-Pro $



















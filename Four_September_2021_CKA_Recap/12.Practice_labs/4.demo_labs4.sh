root@controlplane:~# kubectl taint nodes node01 env_type=production:NoSchedule
node/node01 tainted
root@controlplane:~# 


root@controlplane:~# kubectl create sa pvviewer
serviceaccount/pvviewer created
root@controlplane:~#

root@controlplane:~# kubectl create clusterrole pvviewer-role --resource=persistentvolumes --verb=list
clusterrole.rbac.authorization.k8s.io/pvviewer-role created
root@controlplane:~#

root@controlplane:~# kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=default:pvviewer
clusterrolebinding.rbac.authorization.k8s.io/pvviewer-role-binding created
root@controlplane:~# 

root@controlplane:~# kubectl describe clusterrolebinding pvviewer-role-binding
Name:         pvviewer-role-binding
Labels:       <none>
Annotations:  <none>
Role:
  Kind:  ClusterRole
  Name:  pvviewer-role
Subjects:
  Kind            Name      Namespace
  ----            ----      ---------
  ServiceAccount  pvviewer  default
root@controlplane:~# 


apiVersion: v1
kind: Pod
metadata:
  labels:
    run: pvviewer
  name: pvviewer
spec:
  containers:
  - image: redis
    name: pvviewer
  # Add service account name
  serviceAccountName: pvviewer


  ----------------------------------------------------------------------------->


List the InternalIP of all nodes of the cluster. Save the result to a file /root/CKA/node_ips.
Answer should be in the format: InternalIP of controlplane<space>InternalIP of node01 (in a single line)

root@controlplane:~# kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'
10.31.48.3 10.31.48.6
root@controlplane:~# 


root@controlplane:~# kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")]}'
{"address":"10.31.48.3","type":"InternalIP"} {"address":"10.31.48.6","type":"InternalIP"}
root@controlp)].address}':~# kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")
10.31.48.3 10.31.48.6
root@controlplane:~# 
root@controlplane:~# 
root@controlplane:~# kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips
root@controlplane:~# 




Create a pod called multi-pod with two containers.
Container 1, name: alpha, image: nginx
Container 2: name: beta, image: busybox, command: sleep 4800

Environment Variables:
container 1:
name: alpha
Container 2:
name: beta

apiVersion: v1
kind: Pod
metadata:
  name: multi-pod
spec:
  containers:
  - image: nginx
    name: alpha
    env:
    - name: name
      value: alpha
  - image: busybox
    name: beta
    command: ["sleep", "4800"]
    env:
    - name: name
      value: beta



Create a Pod called non-root-pod , image: redis:alpine
runAsUser: 1000
fsGroup: 2000

---
apiVersion: v1
kind: Pod
metadata:
  name: non-root-pod
spec:
  securityContext:
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: non-root-pod
    image: redis:alpine





We have deployed a new pod called np-test-1 and a service called np-test-service. 
Incoming connections to this service are not working. Troubleshoot and fix it.
Create NetworkPolicy, by the name ingress-to-nptest that allows incoming connections to the service over port 80.

Important: Dont delete any current objects deployed.

Solution manifest file to create a network policy ingress-to-nptest as follows:

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-to-nptest
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: np-test-1
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - protocol: TCP
      port: 80




--------------------------------------------------------->

apiVersion: v1
kind: Pod
metadata:
  name: multi-pod
spec:
  containers:
  - image: nginx
    name: alpha
    env:
    - name: name
      value: alpha
  - image: busybox
    name: beta
    command: ["sleep", "4800"]
    env:
    - name: name
      value: beta

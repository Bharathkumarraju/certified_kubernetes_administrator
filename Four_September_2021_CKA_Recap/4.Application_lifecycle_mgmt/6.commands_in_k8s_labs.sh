root@controlplane:~# kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          2m25s
root@controlplane:~# 

root@controlplane:~# cat ubuntu-sleeper-2.yaml 
apiVersion: v1 
kind: Pod 
metadata:
  name: ubuntu-sleeper-2 
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command:
    - "sleep"
    - "5000"
root@controlplane:~# 

root@controlplane:~# vim ubuntu-sleeper-2.yaml 
root@controlplane:~# kubectl apply -f ubuntu-sleeper-2.yaml
pod/ubuntu-sleeper-2 created
root@controlplane:~#


root@controlplane:~# cat ubuntu-sleeper-2.yaml 
apiVersion: v1 
kind: Pod 
metadata:
  name: ubuntu-sleeper-2 
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command:
    - "sleep"
    - "5000"
root@controlplane:~# 



root@controlplane:~# kubectl edit pod ubuntu-sleeper-3
error: pods "ubuntu-sleeper-3" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-wyzn1.yaml"
error: Edit cancelled, no valid changes were saved.
root@controlplane:~# kubectl delete pod ubuntu-sleeper-3
pod "ubuntu-sleeper-3" deleted
kubectl apply -f /tmp/kubectl-edit-wyzn1.yaml
root@controlplane:~# kubectl apply -f /tmp/kubectl-edit-wyzn1.yaml
pod/ubuntu-sleeper-3 created
root@controlplane:~# 



root@controlplane:~/webapp-color# kubectl run webapp-green --image=kodekloud/webapp-color --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: webapp-green
  name: webapp-green
spec:
  containers:
  - image: kodekloud/webapp-color
    name: webapp-green
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}


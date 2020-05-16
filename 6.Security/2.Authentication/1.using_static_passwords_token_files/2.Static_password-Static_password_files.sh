Static_password_file:
---------------------->
We can create the list of users and passwords in a csv file and use that as the source for user information.
The file has 3 columns password, username and userID(user-details.csv)

We then pass the filename as an option to the kube-apiserver
--basic-auth-file=user-details.csv

kube-apiserver.service:
------------------------>
ExecStart=/usr/local/bin/kube-apiserver \\
   --advertise-address=${INTERNAL_IP} \\
   --authorization-mode=Node,RBAC \\
   --enable-swagger-ui=true \\
   ...
   ...
   --basic-auth-file=user-details.csv

If you setup the kube-apiserver using the kubeadm tool then we must use the kube-apiserver pod spec to change this

apiVersion: v1
kind: Pod
metadata:
  name: kube-apiserver-minikube
  namespace: kube-system
spec:
  containers:
    - command:
        - kube-apiserver
        - --advertise-address=192.168.64.2
        - --allow-privileged=true
        - --authorization-mode=Node,RBAC
        - --basic-auth-file=user-details.csv
      image: k8s.gcr.io/kube-apiserver:v1.18.0
      name: kube-apiserver

---------------------------------------------------------------------------------------->
How to authenticate with username and password now
Use the curl command

curl -v -k https://master-node-ip:6443/api/v1/pods -u "user1:password123"


root@controlplane:~# kubectl get nodes -o=jsonpath='{.items[*].metadata.name}'     
controlplane node01
root@controlplane:~# 


root@controlplane:~# kubectl get nodes -o=jsonpath='{.items[*].metadata.name}' > /opt/outputs/node_names.txt
root@controlplane:~# cat /opt/outputs/node_names.txt
controlplane node01
root@controlplane:~# 



root@controlplane:~# kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.osImage}' > /opt/outputs/nodes_os.txt
root@controlplane:~#  kubectl get nodes -o jsonpath='{.items[*].status.nodeInfo.osImage}'
Ubuntu 18.04.5 LTS Ubuntu 18.04.5 LTS
root@controlplane:~# 


root@controlplane:~# kubectl config view --kubeconfig=/root/my-kube-config 
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: KUBE_ADDRESS
  name: development
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: KUBE_ADDRESS
  name: kubernetes-on-aws
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: KUBE_ADDRESS
  name: production
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: KUBE_ADDRESS
  name: test-cluster-1
contexts:
- context:
    cluster: kubernetes-on-aws
    user: aws-user
  name: aws-user@kubernetes-on-aws
- context:
    cluster: test-cluster-1
    user: dev-user
  name: research
- context:
    cluster: development
    user: test-user
  name: test-user@development
- context:
    cluster: production
    user: test-user
  name: test-user@production
current-context: test-user@development
kind: Config
preferences: {}
users:
- name: aws-user
  user:
    client-certificate: /etc/kubernetes/pki/users/aws-user/aws-user.crt
    client-key: /etc/kubernetes/pki/users/aws-user/aws-user.key
- name: dev-user
  user:
    client-certificate: /etc/kubernetes/pki/users/dev-user/developer-user.crt
    client-key: /etc/kubernetes/pki/users/dev-user/dev-user.key
- name: test-user
  user:
    client-certificate: /etc/kubernetes/pki/users/test-user/test-user.crt
    client-key: /etc/kubernetes/pki/users/test-user/test-user.key
root@controlplane:~# 


root@controlplane:~# kubectl config view --kubeconfig=/root/my-kube-config -o jsonpath="{.users[*].name}"
aws-user dev-user test-user
root@controlplane:~#


root@controlplane:~# kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv-log-1   100Mi      RWX            Retain           Available                                   15m
pv-log-2   200Mi      RWX            Retain           Available                                   15m
pv-log-3   300Mi      RWX            Retain           Available                                   15m
pv-log-4   40Mi       RWX            Retain           Available                                   15m
root@controlplane:~# 

root@controlplane:~# kubectl get pv --sort-by=.spec.capacity.storage
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv-log-4   40Mi       RWX            Retain           Available                                   18m
pv-log-1   100Mi      RWX            Retain           Available                                   18m
pv-log-2   200Mi      RWX            Retain           Available                                   18m
pv-log-3   300Mi      RWX            Retain           Available                                   18m
root@controlplane:~# 


kubectl get pv --sort-by=.spec.capacity.storage -o=custom-columns=NAME:.metadata.name,CAPACITY:.spec.capacity.storage



root@controlplane:~# kubectl get pv --sort-by=.spec.capacity.storage -o=custom-columns=NAME:.metadata.name,CAPACITY:.spec.capacity.storage
NAME       CAPACITY
pv-log-4   40Mi
pv-log-1   100Mi
pv-log-2   200Mi
pv-log-3   300Mi
root@controlplane:~# 


root@controlplane:~# kubectl config view --kubeconfig=my-kube-config -o jsonpath="{.contexts[?(@.context.user=='aws-user')].name}"
aws-user@kubernetes-on-aws
root@controlplane:~# 





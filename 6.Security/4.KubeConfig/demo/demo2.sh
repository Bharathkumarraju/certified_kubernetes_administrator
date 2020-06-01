master $ kubectl config view --kubeconfig=my-kube-config
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://172.17.0.87:6443
  name: development
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://172.17.0.87:6443
  name: kubernetes-on-aws
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://172.17.0.87:6443
  name: production
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://172.17.0.87:6443
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
master $


master $ kubectl config current-context --kubeconfig=my-kube-config
test-user@development
master $

master $ kubectl config use-context research --kubeconfig=my-kube-config
Switched to context "research".
master $

master $ kubectl config current-context --kubeconfig=my-kube-config
research
master $
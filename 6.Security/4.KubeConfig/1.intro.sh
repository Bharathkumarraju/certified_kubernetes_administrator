
We have seen how a client uses the certificate file and key to query a kubernetes REST API for list of pods etc...

$ curl https://my-kube-playground:6443/api/v1/pods \
    --key admin.key \
    --cert admin.crt \
    --cacert ca.cert

How can we do the above same certs authentication with kubectl command.
Well you can pass client-key. client-certificate and certificate authority as below.

$ kubectl get pods \
    --server my-kube-playground:6443 \
    --client-key admin.key \
    --client-certificate admin.crt \
    --certificate-authority ca.crt

Obviously typing all those certs everytime is a tedious task. So we move all these(servers/certs) info to a configuration file called KubeConfig.
And then specify this file as the kubeconfig option in your command.

By default the kubectl tool looks for the file named "config" under "$HOME/.kube/config"

The KubeConfig file($HOME/.kube/config) is in specific format.
----------------------------------------------------------------------->
The config file has three sections
1. Clusters
2. Users
3. Contexts

Clusters are various kubernetes clusters that you need to access to.
You have multiple clusters for development,testing and production environments or for different organizations or on different cloud providers etc.

Users like admin,dev user are the user accounts with which you have access to those clusters.
for example the admin user, A dev user, a prod user etc... these users may have different privileges on different clusters












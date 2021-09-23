--image=nginx --> pulled from dokerhub   i.e. docker.io/nginx/nginx

gcr.io/kubernetes-e2e-test-image/dnsutils


docker login private-registry.io
docker run private-registry.io/apps/internal-app 


how to pass docker login credentials for kubernetes, we can use k8s secret object to pass credentials of private registry.


MacBook-Pro:6.Security bharathdasaraju$ kubectl create secret docker-registry regcred \
> --docker-server=private-registry.io/apps/internal-app \
> --docker-username=bharath \
> --docker-password=password12345 \
> --docker-email=bhrth.dsra1@gmail.com
secret/regcred created
MacBook-Pro:6.Security bharathdasaraju$ kubectl describe secret regcred
Name:         regcred
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  kubernetes.io/dockerconfigjson

Data
====
.dockerconfigjson:  171 bytes
MacBook-Pro:6.Security bharathdasaraju$ 


MacBook-Pro:6.Security bharathdasaraju$ kubectl run nginx --image=private-registry.io/apps/internal-app --dry-run=client -o yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: private-registry.io/apps/internal-app
    name: nginx
  imagePullSecrets:
  - name: regcred
MacBook-Pro:6.Security bharathdasaraju$ 




Create an NGINX Pod
------------------------->
kubectl run --generator=run-pod/v1 nginx --image=nginx

Generate POD Manifest YAML file (-o yaml). Do not create it(--dry-run)
kubectl run --generator=run-pod/v1 nginx --image=nginx --dry-run -o yaml

Create a deployment
-------------------------------------------------------------------------------------------------------->
kubectl create deployment --image=nginx nginx

Generate Deployment YAML file (-o yaml). Do not create it(--dry-run)
kubectl create deployment --image=nginx nginx --dry-run -o yaml

Generate Deployment YAML file (-o yaml). Do not create it(--dry-run) with 4 Replicas (--replicas=4)
kubectl create deployment --image=nginx nginx --dry-run -o yaml > nginx-deployment.yaml

Save it to a file, make necessary changes to the file (for example, adding more replicas) and then create the deployment.

---------------------------------------------------------------------------------------------------------->

master $ kubectl create deployment httpd-frontend --image=httpd:2.4-alpine --dry-run -o yaml > deploy.yaml
master $ vim deploy.yaml
master $ kubectl apply -f deploy.yaml
deployment.apps/httpd-frontend created
master $

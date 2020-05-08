Create:
------->
kubectl create -f deployment-definition.yaml

Get:
---->
kubectl get deployments

Update:
------->
kubectl apply -f deployment-definition.yaml

kubectl set image deployment/myapp-deployment nginx-container=nginx:1.18.0

Rollout status:
----------------->
kubectl rollout status deployment/myapp-deployment
kubectl rollout history deployment/myapp-deployment

Rollback:
---------->
kubectl rollout undo deployment/myapp-deployment

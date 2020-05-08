bharathdasaraju@MacBook-Pro (master)$ kubectl apply -f Deployment-definition.yml
deployment.apps/myapp-deployment created
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f Deployment-definition.yml
deployment.apps/myapp-deployment configured
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f Deployment-definition.yml
deployment.apps/myapp-deployment configured
bharathdasaraju@MacBook-Pro (master) $



bharathdasaraju@MacBook-Pro (master) $ kubectl rollout status deployment/myapp-deployment
deployment "myapp-deployment" successfully rolled out
bharathdasaraju@MacBook-Pro (master) $ kubectl rollout history deployment/myapp-deployment
deployment.apps/myapp-deployment
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>
4         <none>
bharathdasaraju@MacBook-Pro (master) $

How to set a newer versio of container image using kubectl command.
$ kubectl set image deployment/myapp-deployment nginx-container=nginx:1.9.1

bharathdasaraju@MacBook-Pro (master) $ kubectl set image deployment/myapp-deployment nginx-container=nginx:1.9.1
deployment.apps/myapp-deployment image updated
bharathdasaraju@MacBook-Pro (master) $

When we first create a deployment
 1. The deployment triggers a rollout
 2. A new rollout creates a new deployment revision  --> lets call it revision 1

 In the future when the application is upgraded, meaning when the container version is updated to a new one,
 a new rollout is triggered and a new deployment version is created named revision 2

This helps us keep track of the changes made to our deployment and enables us to roll back to a previous version of deployment if necessary.

we can see the status of our rollout by running the below command.
bharathdasaraju@MacBook-Pro $ kubectl rollout status deployment/bkweb -R
Waiting for deployment "bkweb" rollout to finish: 1 old replicas are pending termination...
Waiting for deployment "bkweb" rollout to finish: 1 old replicas are pending termination...
deployment "bkweb" successfully rolled out
bharathdasaraju@MacBook-Pro $

bharathdasaraju@MacBook-Pro ~ $ kubectl rollout history deploy/bkweb
deployment.apps/bkweb
REVISION  CHANGE-CAUSE
1         <none>
2         <none>
3         <none>
bharathdasaraju@MacBook-Pro ~ $


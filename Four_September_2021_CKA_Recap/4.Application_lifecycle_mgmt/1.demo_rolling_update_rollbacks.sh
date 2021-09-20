# Rolling Updates and Rollbacks

Rollouts and version

kubectl rollout status deploy webapp
kubectl rollout history deploy webapp

Deployment stratefy:
----------------------->
1.Rolling Update --> its the default deployment strategy

RollingUpdateStrategy:  25% max unavailable, 25% max surge

in this unavailable means lets say the deployment set replicas as 4.
Whenever the rolling update happens the 25% pods are unavailable that means 1 pod is unavailable at a time.

rollback:
-------------->
kubectl rollout undo deploy webapp



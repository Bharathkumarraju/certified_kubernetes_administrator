NoSchedule taint:
----------------------->
kubectl taint nodes node1 app=blue:NoSchedule

NoExecute Taint:
------------------->
means that new pods will not be scheduled on the node and existing pods on the node if any will be
evicted if they do not tolerate the taint.
These pods may have been scheduled on the node before the taint was applied to the node.

NoExecute taint:
------------------>


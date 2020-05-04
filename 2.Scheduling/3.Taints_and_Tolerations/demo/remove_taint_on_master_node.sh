master $ kubectl describe node master | grep -i Taint
Taints:             node-role.kubernetes.io/master:NoSchedulemaster $
master $

echo "Remove the above taint on the master node"
kubectl taint node master node-role.kubernetes.io/master:NoSchedule-

master $ kubectl taint node master node-role.kubernetes.io/master:NoSchedule-
node/master untainted
master $


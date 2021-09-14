bharathdasaraju@MacBook-Pro 2.Scheduling (master) $ kubectl edit pod nginx | grep -i nodename
Vim: Warning: Output is not to a terminal
  29   nodeName: minikube

[1]+  Stopped                 kubectl edit pod nginx | grep --color=auto -i nodename
bharathdasaraju@MacBook-Pro 2.Scheduling (master) $ 

Need to create a binding and send POST request add that binding to pod.

bharathdasaraju@MacBook-Pro 2.Scheduling (master) $ read | kubectl edit pod nginx  | grep -i node
Vim: Warning: Output is not to a terminal
Vim: Warning: Input is not from a terminal
  29   nodeName: minikube
  40     key: node.kubernetes.io/not-ready
  44     key: node.kubernetes.io/unreachable
^C
bharathdasaraju@MacBook-Pro 2.Scheduling (master) $ 

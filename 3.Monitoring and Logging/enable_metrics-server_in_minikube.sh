bharathdasaraju@MacBook-Pro ~ $ minikube addons enable metrics-server
🌟  The 'metrics-server' addon is enabled
bharathdasaraju@MacBook-Pro ~ $

bharathdasaraju@MacBook-Pro ~ $ kubectl top node
error: metrics not available yet
bharathdasaraju@MacBook-Pro ~ $ kubectl top node
NAME       CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
minikube   246m         12%    1693Mi          45%
bharathdasaraju@MacBook-Pro ~ $ kubectl top pod
NAME    CPU(cores)   MEMORY(bytes)
nginx   0m           2Mi
bharathdasaraju@MacBook-Pro ~
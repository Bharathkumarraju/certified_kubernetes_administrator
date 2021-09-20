To monitor kubernetes cluster can use
opensource:
--------------------->
1. Metrics Server --> no historical Metrics
2. Prometheus
3. Elastic Stack

Proprietory:
---------------->
4. Datadog
5. Dynatrace


bharathdasaraju@MacBook-Pro 2.Scheduling % minikube addons enable metrics-server
    ▪ Using image k8s.gcr.io/metrics-server/metrics-server:v0.4.2
🌟  The 'metrics-server' addon is enabled
bharathdasaraju@MacBook-Pro 2.Scheduling % 

bharathdasaraju@MacBook-Pro 2.Scheduling % minikube addons enable dashboard     
    ▪ Using image kubernetesui/dashboard:v2.1.0
    ▪ Using image kubernetesui/metrics-scraper:v1.0.4
💡  Some dashboard features require the metrics-server addon. To enable all features please run:

        minikube addons enable metrics-server


🌟  The 'dashboard' addon is enabled
bharathdasaraju@MacBook-Pro 2.Scheduling % minikube dashboard --url        
🤔  Verifying dashboard health ...
🚀  Launching proxy ...
🤔  Verifying proxy health ...
http://127.0.0.1:59522/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/


bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl top node
NAME       CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
minikube   493m         24%    898Mi           45%       
bharathdasaraju@MacBook-Pro 2.Scheduling % 
We can not provide advanced options like Large (or) Medium (or) Not Small like that with NodeSeletors

So Node Affinity gives us the advanced capability to place a pod on particular Node with conditions.

to get the exact syntacx run kubectl explain pods --recursive command like below.

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl explain pods --recursive | grep -iwA65 "affinity"
      affinity  <Object>
         nodeAffinity   <Object>
            preferredDuringSchedulingIgnoredDuringExecution     <[]Object>
               preference       <Object>
                  matchExpressions      <[]Object>
                     key        <string>
                     operator   <string>
                     values     <[]string>
                  matchFields   <[]Object>
                     key        <string>
                     operator   <string>
                     values     <[]string>
               weight   <integer>
            requiredDuringSchedulingIgnoredDuringExecution      <Object>
               nodeSelectorTerms        <[]Object>
                  matchExpressions      <[]Object>
                     key        <string>
                     operator   <string>
                     values     <[]string>
                  matchFields   <[]Object>
                     key        <string>
                     operator   <string>
                     values     <[]string>
         podAffinity    <Object>
            preferredDuringSchedulingIgnoredDuringExecution     <[]Object>
               podAffinityTerm  <Object>
                  labelSelector <Object>
                     matchExpressions   <[]Object>
                        key     <string>
                        operator        <string>
                        values  <[]string>
                     matchLabels        <map[string]string>
                  namespaces    <[]string>
                  topologyKey   <string>
               weight   <integer>
            requiredDuringSchedulingIgnoredDuringExecution      <[]Object>
               labelSelector    <Object>
                  matchExpressions      <[]Object>
                     key        <string>
                     operator   <string>
                     values     <[]string>
                  matchLabels   <map[string]string>
               namespaces       <[]string>
               topologyKey      <string>
         podAntiAffinity        <Object>
            preferredDuringSchedulingIgnoredDuringExecution     <[]Object>
               podAffinityTerm  <Object>
                  labelSelector <Object>
                     matchExpressions   <[]Object>
                        key     <string>
                        operator        <string>
                        values  <[]string>
                     matchLabels        <map[string]string>
                  namespaces    <[]string>
                  topologyKey   <string>
               weight   <integer>
            requiredDuringSchedulingIgnoredDuringExecution      <[]Object>
               labelSelector    <Object>
                  matchExpressions      <[]Object>
                     key        <string>
                     operator   <string>
                     values     <[]string>
                  matchLabels   <map[string]string>
               namespaces       <[]string>
               topologyKey      <string>
      automountServiceAccountToken      <boolean>
bharathdasaraju@MacBook-Pro 2.Scheduling % 


bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl describe node minikube | grep -i large
                    size=Large
bharathdasaraju@MacBook-Pro 2.Scheduling % 

bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get pods
No resources found in default namespace.
bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl apply -f pod_with_node_affinity.yaml 
pod/nginx created
bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl get pods -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP           NODE       NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          16s   172.17.0.2   minikube   <none>           <none>
bharathdasaraju@MacBook-Pro 2.Scheduling % 


bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl apply -f pod_with_node_affinity_NotIn.yaml 
pod/nginx2 created
bharathdasaraju@MacBook-Pro 2.Scheduling % 


bharathdasaraju@MacBook-Pro 2.Scheduling % kubectl apply -f pod_with_node_affinity_Exists.yaml 
pod/nginx3 created
bharathdasaraju@MacBook-Pro 2.Scheduling % 


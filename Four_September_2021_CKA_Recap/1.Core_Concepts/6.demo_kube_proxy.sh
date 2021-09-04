by default with in a kubernetes cluster every pod can reach every other pod. This is achieved by kube-proxy 

Its pod-network :) kube-proxy creates iptables rules to foward request from web application to database application.


but the service can not join the pod-network.



bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get all --all-namespaces | grep -i "kube-proxy"
kube-system   pod/kube-proxy-w85sf                   1/1     Running   1          109m
kube-system   daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   109m
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ 




bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $ kubectl get ds kube-proxy -n kube-system -o yaml | grep -iC25 "kube-proxy"
    spec:
      containers:
      - command:
        - /usr/local/bin/kube-proxy
        - --config=/var/lib/kube-proxy/config.conf
        - --hostname-override=$(NODE_NAME)
        env:
        - name: NODE_NAME
          valueFrom:
            fieldRef:
              apiVersion: v1
              fieldPath: spec.nodeName
bharathdasaraju@MacBook-Pro certified_kubernetes_administrator (master) $               


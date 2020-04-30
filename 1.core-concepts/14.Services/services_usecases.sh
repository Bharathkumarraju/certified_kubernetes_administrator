One of the service usecase is to listen to a port on the node,
and forward requests on that port to a port on the POD running the web application.

So this kind of service is called as NodePort service,
because the service listens to specific port on the node and forward requests to pods.

There other kinds of services available as well
1. NodePort
2. ClusterIP
3. LoadBalancer
4. ExternalName




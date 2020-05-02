1.NodePort:
-------------->
One of the service usecase is to listen to a port on the node,
and forward requests on that port to a port on the POD running the web application.

So this kind of service is called as NodePort service,
because the service listens to specific port on the node and forward requests to pods.

There other kinds of services available as well
1. NodePort ( as mentioned above)
2. ClusterIP
3. LoadBalancer
4. ExternalName

2.ClusterIP:
------------->
In this case service creates a virtual ip inside the cluster to enable communication between,
different services such as set of front-end servers and a set of back-end servers

3.LoadBalancer:
--------------->
This service type provisions a load balancer for our application in supported cloud providers(AWS,GCP,Azure)
Example:
  To distribute load across the differnt web servers in the front-end tier.



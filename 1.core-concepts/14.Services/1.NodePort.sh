External access to the application.

Service can help by mapping a port on the node to port on the POD

Example:
1. The port on the pod were the actual web server is running is 80 and its referred as targetPort.
   because that is were the service forwards the requests to.

2. The second port is the port on the service itself it is simply referred as the Port(80)

Service is like a virtual server inside the node inside the kubernetes cluster.
Service has its own IP-Address and that IP-Address is called the cluster-IP  of the service.

3. And finally we have the port on the node itself, which we use to access the web server exterbally
   and that is known as the NodePort.The port is by default greater than of 30000 to 32767


bharathdasaraju@MacBook-Pro 14.Services (master) $ kubectl apply -f 1.NodePort.yml
service/bharathapp-service created
bharathdasaraju@MacBook-Pro 14.Services (master) $

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ kubectl get services -o wide
NAME                 TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE     SELECTOR
bharathapp-service   NodePort   10.98.61.170   <none>        80:30009/TCP   3m55s   app=bkdeployment
bharathdasaraju@MacBook-Pro 12.Deployments (master) $

bharathdasaraju@MacBook-Pro 12.Deployments (master) $ curl http://192.168.64.2:30009
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
bharathdasaraju@MacBook-Pro 12.Deployments (master) $


bharathdasaraju@MacBook-Pro 1.core-concepts (master) $ kubectl explain service.spec --recursive
KIND:     Service
VERSION:  v1

RESOURCE: spec <Object>

DESCRIPTION:
     Spec defines the behavior of a service.
     https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status

     ServiceSpec describes the attributes that a user creates on a service.

FIELDS:
   clusterIP    <string>
   externalIPs  <[]string>
   externalName <string>
   externalTrafficPolicy        <string>
   healthCheckNodePort  <integer>
   ipFamily     <string>
   loadBalancerIP       <string>
   loadBalancerSourceRanges     <[]string>
   ports        <[]Object>
      appProtocol       <string>
      name      <string>
      nodePort  <integer>
      port      <integer>
      protocol  <string>
      targetPort        <string>
   publishNotReadyAddresses     <boolean>
   selector     <map[string]string>
   sessionAffinity      <string>
   sessionAffinityConfig        <Object>
      clientIP  <Object>
         timeoutSeconds <integer>
   topologyKeys <[]string>
   type <string>
bharathdasaraju@MacBook-Pro 1.core-concepts (master) $


bharathdasaraju@MacBook-Pro 1.core-concepts (master) $ kubectl explain service.spec.type --recursive
KIND:     Service
VERSION:  v1

FIELD:    type <string>

DESCRIPTION:
     type determines how the Service is exposed. Defaults to ClusterIP. Valid
     options are ExternalName, ClusterIP, NodePort, and LoadBalancer.
     "ExternalName" maps to the specified externalName. "ClusterIP" allocates a
     cluster-internal IP address for load-balancing to endpoints. Endpoints are
     determined by the selector or if that is not specified, by manual
     construction of an Endpoints object. If clusterIP is "None", no virtual IP
     is allocated and the endpoints are published as a set of endpoints rather
     than a stable IP. "NodePort" builds on ClusterIP and allocates a port on
     every node which routes to the clusterIP. "LoadBalancer" builds on NodePort
     and creates an external load-balancer (if supported in the current cloud)
     which routes to the clusterIP. More info:
     https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types
bharathdasaraju@MacBook-Pro 1.core-concepts (master) $




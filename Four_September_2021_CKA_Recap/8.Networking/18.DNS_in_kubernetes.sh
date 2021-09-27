DNS Resolution within the cluster.

Kubenetes deploys a built-in DNS server by default when we setup a cluster.

if we setup Kubenetes manually then we need setup DNS server by our selves.

"for example:"
--------------------->
in "default" namespace we have 
   --> one pod called "test"

in "apps" namespace we have 
   --> one pod namely "web" and 
   --> a service called "web-service"

From the "test" pod we can access the "web-service" with name "web-service.apps" i.e. "service_name.namespace"

"service fully_qualified domain:" http://web-service.apps.svc.cluster.local

pod_ip: 10.244.2.5  for pod_fqdn: http://10-244-2-5.apps.pod.cluster.local
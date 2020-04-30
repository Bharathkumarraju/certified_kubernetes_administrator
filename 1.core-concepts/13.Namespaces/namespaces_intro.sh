Three namespaces created by kubernetes at the time of cluster creation are as below
1. default
2. kube-system
3. kube-public

1.default:
  default namespace -> by default k8s(Created automatically by kubernetes at the time of cluster creation)
  gives us this default namespace to create pods and deployments

2.kube-system:
  Kubernetes creates a set of pods and services for its internal purpose such as those required by the
  networking solution and the DNS service etc... to isoalte these from the user and to prevent accidentally deleting and
  modifying the services, kubernetes crteates them under another namespace created at cluster startup called "kube-system"

3.kube-public:
  A third namespace that is automatically created by kubernetes at the time of cluster creation in kube-public
  This is were resources that should be made available to all users are gets created.

In real world scenario each environment should have their own namespace like DEV TEST STAGE PRODUCTION
The important point ot note here is

1. The reources with-in a namespace can refer to each other simply by their names.
     1. web-pod
     2. db-service
     3. web-deployment
--> In this case the we-app pod can reach the db-service simply using the hostname db-service if required like
    in the web-pod we use like mysql.connect("db-service").
--> If required web-app pod can reach a service in another namespace as well.
    for this we must append the name of the namespace to the name of the service.
 For example:
    The web-pod in the default namespace to connect to the database in the dev namespace we must use like below.
    mysql.connect("db-service.dev.svc.cluster.local")
    i.e. syntax is like "serviename.namespace.svc.cluster.local"

dev.svc.cluster.local:
you are able to do this because when the service is created a DNS entry is added automatically in the above format.
looking closely at the DNS name of the service,

The last part "cluster.local" is the dafult domain name of the kubernetes cluster
and the "svc" is the subdomain followd by the "namespace" and followed by service itself.
--> so its fqdn is "db-service.dev.svc.cluster.local"








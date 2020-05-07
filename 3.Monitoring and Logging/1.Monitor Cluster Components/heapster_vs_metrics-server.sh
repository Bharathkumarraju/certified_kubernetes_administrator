Heapster:
----------->
Heapster was one of the original projects that enabled the
monitoring and analysis features of kubernetes.

However Heapster is now DEPRECATED!!! and slimmed down version now called as Metrics-Server

Metrics-Server:
----------------->
We can have one metrics-server per kubernetes cluster..

The metrics server retrieves metrics from each of the
kubernetes nodes and pods, aggregates them and stores them in a memory.

Note that the metrics server is only an in memory monitoring solution
and does not store the metrics on the disk and as a result you can not see historical performance data.

For the historical performance data, we must rely on one of the advanced monitoring solutions,
like datadog,dynatrace etc...

So How the metrics got generated for the PODS on these nodes?
--------------------------------------------------------------->
The Kubelet contains a subcomponent known as cAdvisor or Container Advisor.

cAdvisor is responsible for retrieving performance metrics from pods and exposing them through the kubelet API to
make the metrics available for the metrics server.

How to enable metrics-server in minikube:
---------------------------------------------->
minikube addons enable metrics-server

in other clusters use this https://github.com/kubernetes-sigs/metrics-server






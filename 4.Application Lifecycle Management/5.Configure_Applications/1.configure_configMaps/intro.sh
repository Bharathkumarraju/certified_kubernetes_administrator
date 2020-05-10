When you have a lot of pod-definition files,
it will become difficult to manage the environment data stored with in the various files.

We can take this environment information out of the pod definition file and manage it centrally
using ConfigurationMaps.

ConfigMaps are used to pass configuration data in the form of key value pairs in kubernetes.
When a pod is created, inject the configmap into the pod.

There are two phases involved in configuring ConfigMaps.
1. Create the ConfigMap.
2. Inject the ConfigMap into the pod.

Two ways to create the ConfigMap:
------------------------------------->
1. Imperative way:
--------------------->
$ kubectl create configmap

2.Declarative way Using configmap definition file
-------------------------------------------------->
$ kubectl create -f







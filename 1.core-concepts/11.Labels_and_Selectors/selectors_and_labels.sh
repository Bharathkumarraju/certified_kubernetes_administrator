why we need labels and selectors in the kubernetes...

1.Lets say we have deployed three instances of our front-end web application as three pods.

2.So we would like to create ReplicationController or ReplicaSet to ensure that we have three active pods at anytime.
  And yes that is the one of the usecase of ReplicaSet. You can use it to monitor existing pods.

3. The role of the ReplicaSet is to monitor the pods and if any of them fails will deploy new ones
   ReplicaSet infact is a process that monitors the pods

Now how does the ReplicaSet knows what pods to monitor:
---------------------------------------------------------->
There could be hundreads of other pods in the cluster running different applications.

This is were labeling our pods during creation comes in handy.

We could now provide these labels as a filter for ReplicaSet under the "selector" section we used to "matchLabels" filter and
provide the same label that ewe used while creating the pods.

This way the ReplicaSet knows which pods to monitor.






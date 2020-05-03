Lets say we have created a lot of different types of Objects in kubernetes like
Pods,Sevices,ReplicaSets and Deployments.

So overtime we may endup having hundreds or thousands of these objects in the kubernetes cluster.
Then we will need a way to filter and view different objects by different categories such as
1. to group objects by their type
2. to view objects by application
3. to view objects by their functionality

whatever it may be, we can group and select objects using labels and selectors
For each object we can attach labels as per our need like app, function etc...

How to add labels in pod-definition file:
----------------------------------------->
Create a section called labels under metadata of pod definition file.
under that add the labels in key,value format.

once the pod gets created use --selector app=App1 to get the details about that pod as below.
this is one of the usecase of labels.

bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f 2.Labels_and_Selectors/labels_in_Pod.yml
pod/simple-webapp created
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl get pods --selector app=App1
NAME            READY   STATUS         RESTARTS   AGE
simple-webapp   0/1     ErrImagePull   0          15s
bharathdasaraju@MacBook-Pro (master) $



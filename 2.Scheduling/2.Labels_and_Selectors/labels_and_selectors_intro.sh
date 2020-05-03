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
under that add the labels in key,value format




kubernetes objects use labels and selectors internally to connect different objects together.

for example:
------------>
To create a replicaSet consisting of 3 different pods,
We first label the pod definition and use selector in a replicaSet to group the pods.

In the replicaSet definition file.
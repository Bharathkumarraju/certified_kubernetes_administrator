when you have multiple schedulers on different master nodes,
you can use --leader-elect=true option in one of the master node with --lock-object-name option.


In the pod-specification file we can use new filed called schedulerName and specify the custom scheduler name.



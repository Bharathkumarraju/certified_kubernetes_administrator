Imperative:
------------------------------------------------------------------------------------------>

bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get deploy
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
simple-webapp-deployment   3/3     3            3           3h52m
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl scale deployment simple-webapp-deployment --replicas=4
deployment.apps/simple-webapp-deployment scaled
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ kubectl get deploy
NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
simple-webapp-deployment   4/4     4            4           3h54m
bharathdasaraju@MacBook-Pro 1.Core_Concepts (master) $ 


Declarative:
-------------------------------------------------------------------------->

kubectl apply -f /path/
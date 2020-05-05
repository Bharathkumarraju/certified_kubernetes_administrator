1. Apply a label color=blue to node node01

master $ kubectl label nodes node01 color=blue
node/node01 labeled
master $

master $ kubectl describe node node01 | grep -iC10 labels
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    color=blue
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Tue, 05 May 2020 00:11:47 +0000
Taints:             <none>
master $

2.Create a new deployment named 'blue' with the NGINX image and 6 replicas

master $ kubectl create deployment blue --image=nginx
deployment.apps/blue created
master $
master $ kubectl scale deployment blue --replicas=6
deployment.apps/blue scaled
master $ kubectl get all
NAME                        READY   STATUS    RESTARTS   AGE
pod/blue-6dfcb7b4cc-488sz   1/1     Running   0          10s
pod/blue-6dfcb7b4cc-9hcvc   1/1     Running   0          10s
pod/blue-6dfcb7b4cc-gxx55   1/1     Running   0          10s
pod/blue-6dfcb7b4cc-hm55v   1/1     Running   0          10s
pod/blue-6dfcb7b4cc-hx5k4   1/1     Running   0          50s
pod/blue-6dfcb7b4cc-rprph   1/1     Running   0          10s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   6m58s

NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/blue   6/6     6            6           50s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/blue-6dfcb7b4cc   6         6         6       50s
master $

Set Node Affinity to the deployment to place the PODs on node01 only
master $ kubectl apply -f Node-affinity-to-deployment-to-place-pods-on-node01.yml
master $ kubectl get pods -o wide
NAME                    READY   STATUS    RESTARTS   AGE   IP          NODE     NOMINATED NODE   READINESS GATES
blue-64dd5b96b9-7ftks   1/1     Running   0          54s   10.40.0.6   node01   <none>           <none>
blue-64dd5b96b9-dvgkb   1/1     Running   0          46s   10.40.0.3   node01   <none>           <none>
blue-64dd5b96b9-gq8kf   1/1     Running   0          54s   10.40.0.5   node01   <none>           <none>
blue-64dd5b96b9-j6xm4   1/1     Running   0          48s   10.40.0.8   node01   <none>           <none>
blue-64dd5b96b9-jx8rw   1/1     Running   0          50s   10.40.0.4   node01   <none>           <none>
blue-64dd5b96b9-tfqr6   1/1     Running   0          54s   10.40.0.7   node01   <none>           <none>
master $

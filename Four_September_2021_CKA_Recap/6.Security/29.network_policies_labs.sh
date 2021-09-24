root@controlplane:~# kubectl get netpol
NAME             POD-SELECTOR   AGE
payroll-policy   name=payroll   4m28s
root@controlplane:~# 

root@controlplane:~# kubectl describe netpol payroll-policy
Name:         payroll-policy
Namespace:    default
Created on:   2021-09-24 04:51:36 +0000 UTC
Labels:       <none>
Annotations:  <none>
Spec:
  PodSelector:     name=payroll
  Allowing ingress traffic:
    To Port: 8080/TCP
    From:
      PodSelector: name=internal
  Not affecting egress traffic
  Policy Types: Ingress
root@controlplane:~# 


the policy means traffic from internal pod can access port 8080 on payroll pod is allowed.

root@controlplane:~# kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
external   1/1     Running   0          7m35s
internal   1/1     Running   0          7m35s
mysql      1/1     Running   0          7m35s
payroll    1/1     Running   0          7m35s
root@controlplane:~# 



Create a network policy to allow traffic from the Internal application only to the payroll-service and db-service.
Use the spec given on the below. You might want to enable ingress traffic to the pod to test your rules in the UI.

Policy Name: internal-policy
Policy Type: Egress
Egress Allow: payroll
Payroll Port: 8080
Egress Allow: mysql
MySQL Port: 3306




apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internal-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      name: internal
  policyTypes:
  - Egress
  - Ingress
  ingress:
    - {}
  egress:
  - to:
    - podSelector:
        matchLabels:
          name: mysql
    ports:
    - protocol: TCP
      port: 3306

  - to:
    - podSelector:
        matchLabels:
          name: payroll
    ports:
    - protocol: TCP
      port: 8080

  - ports:
    - port: 53
      protocol: UDP
    - port: 53
      protocol: TCP


Note: We have also allowed Egress traffic to TCP and UDP port. 
This has been added to ensure that the internal DNS resolution works from the internal pod. 
Remember: The kube-dns service is exposed on port 53:



root@controlplane:~# kubectl apply -f internal-policy-updated.yaml 
networkpolicy.networking.k8s.io/internal-policy created
root@controlplane:~# kubectl get svc -n kube-system
NAME       TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   66m
root@controlplane:~# 

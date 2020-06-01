
We have seen how a client uses the certificate file and key to query a kubernetes REST API for list of pods etc...

$ curl https://my-kube-playground:6443/api/v1/pods \
    --key admin.key \
    --cert admin.crt \
    --cacert ca.cert

How can we do the above same certs authentication with kubectl command.
Well you can pass client-key. client-certificate and certificate authority as below.

$ kubectl get pods \
    --server my-kube-playground:6443 \
    --client-key admin.key \
    --client-certificate admin.crt \
    --certificate-authority ca.crt

Obviously typing all those certs everytime is a tedious task. So we move all these(servers/certs) info to a configuration file called KubeConfig.
And then specify this file as the kubeconfig option in your command.

By default the kubectl tool looks for the file named "config" under "$HOME/.kube/config"

The KubeConfig file($HOME/.kube/config) is in specific format.
----------------------------------------------------------------------->
The config file has three sections
1. Clusters
2. Users
3. Contexts

Clusters are various kubernetes clusters that you need to access to.
You have multiple clusters for development,testing and production environments or for different organizations or on different cloud providers etc.

Users like admin,dev user are the user accounts with which you have access to those clusters.
for example the admin user, A dev user, a prod user etc... these users may have different privileges on different clusters.

Contexts, finally contexts marry clusters and users together.
context defines which user account will be used to access which cluster.
For example, we could create a context named admin at production that will use the admin account to access the production cluster. (OR)
I may want to access the cluster that I have setup on google with the devusers credentials to test deploying the app that I built.

Remember under contexts, you are not creating any new users or configuring any kind of user access or authorization in the cluster.
You are using existing users with the existing privileges and defining what user you are going to use to access what cluster.
That way you do not have to specify the user certificates and server address in each and every kubectl command you run.

How to overcome below command to kubeconfig configuration:
---------------------------------------------------------------->
$ kubectl get pods \
    --server my-kube-playground:6443 \
    --client-key admin.key \
    --client-certificate admin.crt \
    --certificate-authority ca.crt

The server specification in our command goes into the cluster section(MyKubePlayground - cluster).
The admin users keys and certificates goes into the users section(MyKubeAdmin - user).
you then  create a context that specifies to use the MyKubeAdmin user to access the MyKubePlayground cluster.

The real kubeconfig file:
--------------------------->
check kube_cofig.yaml

If you have multiple contexts, you can specify a context as default context by setting field called "current-context"

There are command line options available with the kubectl to view and modify the kubeconfig files.

By default kubectl command uses default kubeconfig file located at the users home directory ~/.kube/config...
if you want to specify custom path you can do that using "kubectl config view --kubeconfig=my-custom-kube-config"

bharathdasaraju@MacBook-Pro ~ $ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/bharathdasaraju/.minikube/ca.crt
    server: https://192.168.64.2:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /Users/bharathdasaraju/.minikube/profiles/minikube/client.crt
    client-key: /Users/bharathdasaraju/.minikube/profiles/minikube/client.key
bharathdasaraju@MacBook-Pro ~ $

bharathdasaraju@MacBook-Pro ~ $ kubectl config view --kubeconfig=~/bharathskube_config
apiVersion: v1
clusters: []
contexts: []
current-context: ""
kind: Config
preferences: {}
users: []
bharathdasaraju@MacBook-Pro ~ $


How to change the current-context to the prod-user@production context:
--------------------------------------------------------------------------->
$ kubectl config use-context prod-user@production

How to configure namespaces in kubeconfig file:
---------------------------------------------------->
Each cluster may be configured with multiple namespaces within it.

So can we configure a context to switch to a particular namespace? YES.
The context section in the kubeconfig file can take additional section called namespace where you can specify a particular namespace.
(check kube_config2.yaml)
This way when you switch to that context you will automatically be in a specific namespace.

Certificates specified in the kube-config file:
---------------------------------------------------->
clusters:
- name: production
  cluster:
    certificate-authority: ca.crt

So instead of path to the certificate, you can specify the contents of the certificates directly in the kubeconfig file as below,
using "certificate-authority-data", convert the plain text into base4 encoded format and pass to this field

bharathdasaraju@MacBook-Pro ~ $ cat /Users/bharathdasaraju/.minikube/ca.crt | base64
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQVRBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwdGFXNXAKYTNWaVpVTkJNQjRYRFRJd01ETXlPREF5TWpNME5Wb1hEVE13TURNeU56QXlNak0wTlZvd0ZURVRNQkVHQTFVRQpBeE1LYldsdWFXdDFZbVZEUVRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS21ICkRzV05kQzRKUHJlcnlkVlFQSHBSa2U0dHFZWWVoS1Rqb0VFRmtMRjRFM01pN2pvQjJkaFVmb3RhM2YxWDJTSkYKcnhDM05ldkFQS3BQY1RFT3JIUzJVemlISUNSYUlyWEpWeWJFK1BQWGxTRXZySXhUd1hsbkp6c3htYzVXMXJKTApuWHJzNUROdUc5ZUhYa0QyelVKZGl1QzA5eG1COUIyc04wWGZScU51TlV0NS9IOHJzQk1Iam5DUFJVUGl4a0VxCkN6VmZtM3M5NWRoSjJkTllLRit0MVNoam15dGJmWEI2U1I3eUlHSGJuTE5MaElNV2tqdnd3QW1OZFVoVTk4OHYKcXAyaFhrRVd3RG00M3hoQS9tSnkwREF5MWhYcEc3Uzdid0ZGK3kzUmZWdURHS1pnYVlzVUJQckpUQXlIcGNYZwplbDcrRzl1aUZxOU1UQTYrc3Y4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXCk1CUUdDQ3NHQVFVRkJ3TUNCZ2dyQmdFRkJRY0RBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCZzU4ZllxeURyZXkweHh6ZEpmc290NGVyemR6ODAxcWVZRmhURytHTDFES2VXNVlCbApLYjYxOVc5RFpiL2RTSTVYeFhGQ3ZNUkVGSHl4bWpVbzBvOFNsQ3lFTnRaQkJhamN5YzQ0cFBtVGpwRi83SkpoCjNWOFBVUzdRVVRnRG8xTWhuaVZLaXZpMzU5ZTFZWnBMZUJkQytvRUQvZ1hDcjFYYzk5dS8wYmUzUjNPQTFzbnQKeDdGUEt5NGNBV296YXJHaWZrU1h1emp6WVdQeDhuQkovV3NrK2RHZG1nU3BGYUEycjN3Ri9zSlh6eWJIMDhkMgpiSFdqcDdzVTNaQ1NncWMxdTNFaDI1YjhtZ3F0dVpiK2hkVkhtQlNWZVJ4aU42Yy9KSVJMZURmVUpobjk4aUJZCjA5Tjh2amQ5N1Q3eVFMckFySTVNUFZXNXduMm9jOGV3Z0hqdgotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
bharathdasaraju@MacBook-Pro ~ $

clusters:
- name: production
  cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQVRBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwdGFXNXAKYTNWaVpVTkJNQjRYRFRJd01ETXlPREF5TWpNME5Wb1hEVE13TURNeU56QXlNak0wTlZvd0ZURVRNQkVHQTFVRQpBeE1LYldsdWFXdDFZbVZEUVRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS21ICkRzV05kQzRKUHJlcnlkVlFQSHBSa2U0dHFZWWVoS1Rqb0VFRmtMRjRFM01pN2pvQjJkaFVmb3RhM2YxWDJTSkYKcnhDM05ldkFQS3BQY1RFT3JIUzJVemlISUNSYUlyWEpWeWJFK1BQWGxTRXZySXhUd1hsbkp6c3htYzVXMXJKTApuWHJzNUROdUc5ZUhYa0QyelVKZGl1QzA5eG1COUIyc04wWGZScU51TlV0NS9IOHJzQk1Iam5DUFJVUGl4a0VxCkN6VmZtM3M5NWRoSjJkTllLRit0MVNoam15dGJmWEI2U1I3eUlHSGJuTE5MaElNV2tqdnd3QW1OZFVoVTk4OHYKcXAyaFhrRVd3RG00M3hoQS9tSnkwREF5MWhYcEc3Uzdid0ZGK3kzUmZWdURHS1pnYVlzVUJQckpUQXlIcGNYZwplbDcrRzl1aUZxOU1UQTYrc3Y4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXCk1CUUdDQ3NHQVFVRkJ3TUNCZ2dyQmdFRkJRY0RBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCZzU4ZllxeURyZXkweHh6ZEpmc290NGVyemR6ODAxcWVZRmhURytHTDFES2VXNVlCbApLYjYxOVc5RFpiL2RTSTVYeFhGQ3ZNUkVGSHl4bWpVbzBvOFNsQ3lFTnRaQkJhamN5YzQ0cFBtVGpwRi83SkpoCjNWOFBVUzdRVVRnRG8xTWhuaVZLaXZpMzU5ZTFZWnBMZUJkQytvRUQvZ1hDcjFYYzk5dS8wYmUzUjNPQTFzbnQKeDdGUEt5NGNBV296YXJHaWZrU1h1emp6WVdQeDhuQkovV3NrK2RHZG1nU3BGYUEycjN3Ri9zSlh6eWJIMDhkMgpiSFdqcDdzVTNaQ1NncWMxdTNFaDI1YjhtZ3F0dVpiK2hkVkhtQlNWZVJ4aU42Yy9KSVJMZURmVUpobjk4aUJZCjA5Tjh2amQ5N1Q3eVFMckFySTVNUFZXNXduMm9jOGV3Z0hqdgotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==



bharathdasaraju@MacBook-Pro ~ $ cat /Users/bharathdasaraju/.minikube/ca.crt
-----BEGIN CERTIFICATE-----
MIIC5zCCAc+gAwIBAgIBATANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwptaW5p
a3ViZUNBMB4XDTIwMDMyODAyMjM0NVoXDTMwMDMyNzAyMjM0NVowFTETMBEGA1UE
AxMKbWluaWt1YmVDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKmH
DsWNdC4JPrerydVQPHpRke4tqYYehKTjoEEFkLF4E3Mi7joB2dhUfota3f1X2SJF
rxC3NevAPKpPcTEOrHS2UziHICRaIrXJVybE+PPXlSEvrIxTwXlnJzsxmc5W1rJL
nXrs5DNuG9eHXkD2zUJdiuC09xmB9B2sN0XfRqNuNUt5/H8rsBMHjnCPRUPixkEq
CzVfm3s95dhJ2dNYKF+t1ShjmytbfXB6SR7yIGHbnLNLhIMWkjvwwAmNdUhU988v
qp2hXkEWwDm43xhA/mJy0DAy1hXpG7S7bwFF+y3RfVuDGKZgaYsUBPrJTAyHpcXg
el7+G9uiFq9MTA6+sv8CAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgKkMB0GA1UdJQQW
MBQGCCsGAQUFBwMCBggrBgEFBQcDATAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
DQEBCwUAA4IBAQBg58fYqyDrey0xxzdJfsot4erzdz801qeYFhTG+GL1DKeW5YBl
Kb619W9DZb/dSI5XxXFCvMREFHyxmjUo0o8SlCyENtZBBajcyc44pPmTjpF/7JJh
3V8PUS7QUTgDo1MhniVKivi359e1YZpLeBdC+oED/gXCr1Xc99u/0be3R3OA1snt
x7FPKy4cAWozarGifkSXuzjzYWPx8nBJ/Wsk+dGdmgSpFaA2r3wF/sJXzybH08d2
bHWjp7sU3ZCSgqc1u3Eh25b8mgqtuZb+hdVHmBSVeRxiN6c/JIRLeDfUJhn98iBY
09N8vjd97T7yQLrArI5MPVW5wn2oc8ewgHjv
-----END CERTIFICATE-----
bharathdasaraju@MacBook-Pro ~ $ cat /Users/bharathdasaraju/.minikube/ca.crt | base64
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQVRBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwdGFXNXAKYTNWaVpVTkJNQjRYRFRJd01ETXlPREF5TWpNME5Wb1hEVE13TURNeU56QXlNak0wTlZvd0ZURVRNQkVHQTFVRQpBeE1LYldsdWFXdDFZbVZEUVRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS21ICkRzV05kQzRKUHJlcnlkVlFQSHBSa2U0dHFZWWVoS1Rqb0VFRmtMRjRFM01pN2pvQjJkaFVmb3RhM2YxWDJTSkYKcnhDM05ldkFQS3BQY1RFT3JIUzJVemlISUNSYUlyWEpWeWJFK1BQWGxTRXZySXhUd1hsbkp6c3htYzVXMXJKTApuWHJzNUROdUc5ZUhYa0QyelVKZGl1QzA5eG1COUIyc04wWGZScU51TlV0NS9IOHJzQk1Iam5DUFJVUGl4a0VxCkN6VmZtM3M5NWRoSjJkTllLRit0MVNoam15dGJmWEI2U1I3eUlHSGJuTE5MaElNV2tqdnd3QW1OZFVoVTk4OHYKcXAyaFhrRVd3RG00M3hoQS9tSnkwREF5MWhYcEc3Uzdid0ZGK3kzUmZWdURHS1pnYVlzVUJQckpUQXlIcGNYZwplbDcrRzl1aUZxOU1UQTYrc3Y4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXCk1CUUdDQ3NHQVFVRkJ3TUNCZ2dyQmdFRkJRY0RBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCZzU4ZllxeURyZXkweHh6ZEpmc290NGVyemR6ODAxcWVZRmhURytHTDFES2VXNVlCbApLYjYxOVc5RFpiL2RTSTVYeFhGQ3ZNUkVGSHl4bWpVbzBvOFNsQ3lFTnRaQkJhamN5YzQ0cFBtVGpwRi83SkpoCjNWOFBVUzdRVVRnRG8xTWhuaVZLaXZpMzU5ZTFZWnBMZUJkQytvRUQvZ1hDcjFYYzk5dS8wYmUzUjNPQTFzbnQKeDdGUEt5NGNBV296YXJHaWZrU1h1emp6WVdQeDhuQkovV3NrK2RHZG1nU3BGYUEycjN3Ri9zSlh6eWJIMDhkMgpiSFdqcDdzVTNaQ1NncWMxdTNFaDI1YjhtZ3F0dVpiK2hkVkhtQlNWZVJ4aU42Yy9KSVJMZURmVUpobjk4aUJZCjA5Tjh2amQ5N1Q3eVFMckFySTVNUFZXNXduMm9jOGV3Z0hqdgotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
bharathdasaraju@MacBook-Pro ~ $


How to decode the certificate used in the kubeconfig file:
------------------------------------------------------------->


bharathdasaraju@MacBook-Pro ~ $ echo "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1ekNDQWMrZ0F3SUJBZ0lCQVRBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwdGFXNXAKYTNWaVpVTkJNQjRYRFRJd01ETXlPREF5TWpNME5Wb1hEVE13TURNeU56QXlNak0wTlZvd0ZURVRNQkVHQTFVRQpBeE1LYldsdWFXdDFZbVZEUVRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS21ICkRzV05kQzRKUHJlcnlkVlFQSHBSa2U0dHFZWWVoS1Rqb0VFRmtMRjRFM01pN2pvQjJkaFVmb3RhM2YxWDJTSkYKcnhDM05ldkFQS3BQY1RFT3JIUzJVemlISUNSYUlyWEpWeWJFK1BQWGxTRXZySXhUd1hsbkp6c3htYzVXMXJKTApuWHJzNUROdUc5ZUhYa0QyelVKZGl1QzA5eG1COUIyc04wWGZScU51TlV0NS9IOHJzQk1Iam5DUFJVUGl4a0VxCkN6VmZtM3M5NWRoSjJkTllLRit0MVNoam15dGJmWEI2U1I3eUlHSGJuTE5MaElNV2tqdnd3QW1OZFVoVTk4OHYKcXAyaFhrRVd3RG00M3hoQS9tSnkwREF5MWhYcEc3Uzdid0ZGK3kzUmZWdURHS1pnYVlzVUJQckpUQXlIcGNYZwplbDcrRzl1aUZxOU1UQTYrc3Y4Q0F3RUFBYU5DTUVBd0RnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXCk1CUUdDQ3NHQVFVRkJ3TUNCZ2dyQmdFRkJRY0RBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQTBHQ1NxR1NJYjMKRFFFQkN3VUFBNElCQVFCZzU4ZllxeURyZXkweHh6ZEpmc290NGVyemR6ODAxcWVZRmhURytHTDFES2VXNVlCbApLYjYxOVc5RFpiL2RTSTVYeFhGQ3ZNUkVGSHl4bWpVbzBvOFNsQ3lFTnRaQkJhamN5YzQ0cFBtVGpwRi83SkpoCjNWOFBVUzdRVVRnRG8xTWhuaVZLaXZpMzU5ZTFZWnBMZUJkQytvRUQvZ1hDcjFYYzk5dS8wYmUzUjNPQTFzbnQKeDdGUEt5NGNBV296YXJHaWZrU1h1emp6WVdQeDhuQkovV3NrK2RHZG1nU3BGYUEycjN3Ri9zSlh6eWJIMDhkMgpiSFdqcDdzVTNaQ1NncWMxdTNFaDI1YjhtZ3F0dVpiK2hkVkhtQlNWZVJ4aU42Yy9KSVJMZURmVUpobjk4aUJZCjA5Tjh2amQ5N1Q3eVFMckFySTVNUFZXNXduMm9jOGV3Z0hqdgotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==" | base64 --decode
-----BEGIN CERTIFICATE-----
MIIC5zCCAc+gAwIBAgIBATANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwptaW5p
a3ViZUNBMB4XDTIwMDMyODAyMjM0NVoXDTMwMDMyNzAyMjM0NVowFTETMBEGA1UE
AxMKbWluaWt1YmVDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKmH
DsWNdC4JPrerydVQPHpRke4tqYYehKTjoEEFkLF4E3Mi7joB2dhUfota3f1X2SJF
rxC3NevAPKpPcTEOrHS2UziHICRaIrXJVybE+PPXlSEvrIxTwXlnJzsxmc5W1rJL
nXrs5DNuG9eHXkD2zUJdiuC09xmB9B2sN0XfRqNuNUt5/H8rsBMHjnCPRUPixkEq
CzVfm3s95dhJ2dNYKF+t1ShjmytbfXB6SR7yIGHbnLNLhIMWkjvwwAmNdUhU988v
qp2hXkEWwDm43xhA/mJy0DAy1hXpG7S7bwFF+y3RfVuDGKZgaYsUBPrJTAyHpcXg
el7+G9uiFq9MTA6+sv8CAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgKkMB0GA1UdJQQW
MBQGCCsGAQUFBwMCBggrBgEFBQcDATAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3
DQEBCwUAA4IBAQBg58fYqyDrey0xxzdJfsot4erzdz801qeYFhTG+GL1DKeW5YBl
Kb619W9DZb/dSI5XxXFCvMREFHyxmjUo0o8SlCyENtZBBajcyc44pPmTjpF/7JJh
3V8PUS7QUTgDo1MhniVKivi359e1YZpLeBdC+oED/gXCr1Xc99u/0be3R3OA1snt
x7FPKy4cAWozarGifkSXuzjzYWPx8nBJ/Wsk+dGdmgSpFaA2r3wF/sJXzybH08d2
bHWjp7sU3ZCSgqc1u3Eh25b8mgqtuZb+hdVHmBSVeRxiN6c/JIRLeDfUJhn98iBY
09N8vjd97T7yQLrArI5MPVW5wn2oc8ewgHjv
-----END CERTIFICATE-----
bharathdasaraju@MacBook-Pro ~ $



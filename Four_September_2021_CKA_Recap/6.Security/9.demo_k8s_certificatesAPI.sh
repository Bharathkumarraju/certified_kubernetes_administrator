Certificate workflow and API

1. API Object: Create  CertificateSigningRequest Object
2. Review Requests
3. Approve Requests


Example:
------------>
1. A user first creates a key. and then generates a certificate signing request with his name on it.

MacBook-Pro:6.Security bharathdasaraju$ cd generate_tls_for_kubernetes/
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl genrsa -out bharath.key 2048
Generating RSA private key, 2048 bit long modulus
..................................+++
...............+++
e is 65537 (0x10001)
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl req -new -key bharath.key -subj "/CN=bharath" -out bharath.csr
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ ls
admin.crt               admin.key               apiserver.csr           bharath.csr             ca.crt                  ca.key                  openssl-apiserver.conf
admin.csr               apiserver.crt           apiserver.key           bharath.key             ca.csr                  ca.srl
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 



2. Then sends the request to the administrator. the administrator takes the key and creates a "CertificateSigningRequest" object.

The "CertificateSigningRequest" is created like any other kubernetes object using a manifest file with the usual fields.
The kind is "CertificateSigningRequest" under the spec section,
specify the groups the user should be part of and list the usages of the account as list of strings.

the request filed is where you specify the certificate signing request sent by the user.
But you wont specify as plain text, instead it must be encoded using the base64 command(as below) then move the encoded text into the requeast field.
and then submit the request.

MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ cat bharath.csr | base64
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1Z6Q0NBVDhDQVFBd0VqRVFNQTRHQTFVRUF3d0hZbWhoY21GMGFEQ0NBU0l3RFFZSktvWklodmNOQVFFQgpCUUFEZ2dFUEFEQ0NBUW9DZ2dFQkFPZ0tPR1UvUU9nTlRoeW1ucTl4VzBwREZSdnk0UG5uUERkYmF2RExIaTZnCjQ3dWpjYnFWY3MyYmdHbWlNdWlhTFQzV01YaVB4eFRjWXFKZDYvSGEyc1hBbXZLQUtVZTVpNUJRM093cTNrVncKbnBFN2xDczVOWWRzT25XYWVPRnBVbzJQMno0eDEzYzBPY2UxRms2UjNwZDdaSzlReWxqVEVxeVJhZ2ZVSEo0TQowak04V21mRHRmTXdWTlRRQzErYjVUdmRINmxhSTJMeXhjRFFzS3pYMUdLNW5WTDNaeS84NEM1NUlYL0Q4QTRNCnBxaVJtSXV1QTV3U0dhRnV5bEpGdGFXc2g0WHVpTytoRHdHNU8wcVdOeDkzaDBEZkFkb0JmZHVDb0k3RjdQU3oKcEtGQnBZdnFzc3hZcWJOTnJJRVhxZ3k4MUF1SU41VG83Wi9PUGYwb0Q2Y0NBd0VBQWFBQU1BMEdDU3FHU0liMwpEUUVCQ3dVQUE0SUJBUUJGcXFxYkJsOXFqWWhZTm1BTCtKb0NxSFozUTF2Qnpoa1owNWJnb1NPVUxVTHBNRUYyCmlnZ2JvSlRxQWY5NmU0OVlDRE1vaUlWUUg1K2JIT0hzMDBpRzFFK0FscEkwNVNGczVXRkh6bDFSMFJqdmpxWnYKcm1UcjFhWWpGeUh4dHBseGdqNnowQy8vYVZreEI1NnY2UklCQ0xLUkwzTmRUaWdHcE4rc2xTNmVtRjNic0lrbwp6T3VHYUg5TElSTllVL3BuRnJBcFpCU25vWElGa2M4WHRwS29IakttMDVmOUZZMlJseHhHdVl5bjZ0c2o2WGNkCnhsM1owWXI3cGoyWWVJdS9sWXNXcGdIalZsWHFZbVpIQWJVL1VwTll3ZzR3ZVRNRHVUWmQ0YUwwRVpQcGc2clkKKzFEckdHODFaeDZWbUhXa2xWTXdDUDkvQXZ2VlhqaWlHdVNBCi0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 

MacBook-Pro:6.Security bharathdasaraju$ kubectl apply -f CertificateSigningRequest.yaml 
Warning: certificates.k8s.io/v1beta1 CertificateSigningRequest is deprecated in v1.19+, unavailable in v1.22+; use certificates.k8s.io/v1 CertificateSigningRequest
certificatesigningrequest.certificates.k8s.io/bharath created
MacBook-Pro:6.Security bharathdasaraju$ kubectl get csr
NAME      AGE   SIGNERNAME                     REQUESTOR       CONDITION
bharath   11s   kubernetes.io/legacy-unknown   minikube-user   Pending
MacBook-Pro:6.Security bharathdasaraju$ 

MacBook-Pro:6.Security bharathdasaraju$ kubectl get csr
NAME      AGE   SIGNERNAME                     REQUESTOR       CONDITION
bharath   11s   kubernetes.io/legacy-unknown   minikube-user   Pending
MacBook-Pro:6.Security bharathdasaraju$ 
MacBook-Pro:6.Security bharathdasaraju$ kubectl certificate approve bharath
certificatesigningrequest.certificates.k8s.io/bharath approved
MacBook-Pro:6.Security bharathdasaraju$ kubectl get csr
NAME      AGE   SIGNERNAME                     REQUESTOR       CONDITION
bharath   51s   kubernetes.io/legacy-unknown   minikube-user   Approved,Issued
MacBook-Pro:6.Security bharathdasaraju$ 


MacBook-Pro:6.Security bharathdasaraju$ kubectl get csr bharath -o yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"certificates.k8s.io/v1beta1","kind":"CertificateSigningRequest","metadata":{"annotations":{},"name":"bharath"},"spec":{"groups":["system:authenticated"],"request":"LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1Z6Q0NBVDhDQVFBd0VqRVFNQTRHQTFVRUF3d0hZbWhoY21GMGFEQ0NBU0l3RFFZSktvWklodmNOQVFFQgpCUUFEZ2dFUEFEQ0NBUW9DZ2dFQkFPZ0tPR1UvUU9nTlRoeW1ucTl4VzBwREZSdnk0UG5uUERkYmF2RExIaTZnCjQ3dWpjYnFWY3MyYmdHbWlNdWlhTFQzV01YaVB4eFRjWXFKZDYvSGEyc1hBbXZLQUtVZTVpNUJRM093cTNrVncKbnBFN2xDczVOWWRzT25XYWVPRnBVbzJQMno0eDEzYzBPY2UxRms2UjNwZDdaSzlReWxqVEVxeVJhZ2ZVSEo0TQowak04V21mRHRmTXdWTlRRQzErYjVUdmRINmxhSTJMeXhjRFFzS3pYMUdLNW5WTDNaeS84NEM1NUlYL0Q4QTRNCnBxaVJtSXV1QTV3U0dhRnV5bEpGdGFXc2g0WHVpTytoRHdHNU8wcVdOeDkzaDBEZkFkb0JmZHVDb0k3RjdQU3oKcEtGQnBZdnFzc3hZcWJOTnJJRVhxZ3k4MUF1SU41VG83Wi9PUGYwb0Q2Y0NBd0VBQWFBQU1BMEdDU3FHU0liMwpEUUVCQ3dVQUE0SUJBUUJGcXFxYkJsOXFqWWhZTm1BTCtKb0NxSFozUTF2Qnpoa1owNWJnb1NPVUxVTHBNRUYyCmlnZ2JvSlRxQWY5NmU0OVlDRE1vaUlWUUg1K2JIT0hzMDBpRzFFK0FscEkwNVNGczVXRkh6bDFSMFJqdmpxWnYKcm1UcjFhWWpGeUh4dHBseGdqNnowQy8vYVZreEI1NnY2UklCQ0xLUkwzTmRUaWdHcE4rc2xTNmVtRjNic0lrbwp6T3VHYUg5TElSTllVL3BuRnJBcFpCU25vWElGa2M4WHRwS29IakttMDVmOUZZMlJseHhHdVl5bjZ0c2o2WGNkCnhsM1owWXI3cGoyWWVJdS9sWXNXcGdIalZsWHFZbVpIQWJVL1VwTll3ZzR3ZVRNRHVUWmQ0YUwwRVpQcGc2clkKKzFEckdHODFaeDZWbUhXa2xWTXdDUDkvQXZ2VlhqaWlHdVNBCi0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=","usages":["digital signature","key encipherment","server auth"]}}
  creationTimestamp: "2021-09-22T23:53:45Z"
  managedFields:
  - apiVersion: certificates.k8s.io/v1beta1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .: {}
          f:kubectl.kubernetes.io/last-applied-configuration: {}
      f:spec:
        f:groups: {}
        f:request: {}
        f:signerName: {}
        f:usages: {}
    manager: kubectl-client-side-apply
    operation: Update
    time: "2021-09-22T23:53:45Z"
  - apiVersion: certificates.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:status:
        f:certificate: {}
    manager: kube-controller-manager
    operation: Update
    time: "2021-09-22T23:54:33Z"
  - apiVersion: certificates.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:status:
        f:conditions:
          .: {}
          k:{"type":"Approved"}:
            .: {}
            f:lastTransitionTime: {}
            f:lastUpdateTime: {}
            f:message: {}
            f:reason: {}
            f:status: {}
            f:type: {}
    manager: kubectl
    operation: Update
    time: "2021-09-22T23:54:33Z"
  name: bharath
  resourceVersion: "121875"
  uid: dcdbbadd-fb6a-489f-86dc-47dd868b9a33
spec:
  groups:
  - system:masters
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1Z6Q0NBVDhDQVFBd0VqRVFNQTRHQTFVRUF3d0hZbWhoY21GMGFEQ0NBU0l3RFFZSktvWklodmNOQVFFQgpCUUFEZ2dFUEFEQ0NBUW9DZ2dFQkFPZ0tPR1UvUU9nTlRoeW1ucTl4VzBwREZSdnk0UG5uUERkYmF2RExIaTZnCjQ3dWpjYnFWY3MyYmdHbWlNdWlhTFQzV01YaVB4eFRjWXFKZDYvSGEyc1hBbXZLQUtVZTVpNUJRM093cTNrVncKbnBFN2xDczVOWWRzT25XYWVPRnBVbzJQMno0eDEzYzBPY2UxRms2UjNwZDdaSzlReWxqVEVxeVJhZ2ZVSEo0TQowak04V21mRHRmTXdWTlRRQzErYjVUdmRINmxhSTJMeXhjRFFzS3pYMUdLNW5WTDNaeS84NEM1NUlYL0Q4QTRNCnBxaVJtSXV1QTV3U0dhRnV5bEpGdGFXc2g0WHVpTytoRHdHNU8wcVdOeDkzaDBEZkFkb0JmZHVDb0k3RjdQU3oKcEtGQnBZdnFzc3hZcWJOTnJJRVhxZ3k4MUF1SU41VG83Wi9PUGYwb0Q2Y0NBd0VBQWFBQU1BMEdDU3FHU0liMwpEUUVCQ3dVQUE0SUJBUUJGcXFxYkJsOXFqWWhZTm1BTCtKb0NxSFozUTF2Qnpoa1owNWJnb1NPVUxVTHBNRUYyCmlnZ2JvSlRxQWY5NmU0OVlDRE1vaUlWUUg1K2JIT0hzMDBpRzFFK0FscEkwNVNGczVXRkh6bDFSMFJqdmpxWnYKcm1UcjFhWWpGeUh4dHBseGdqNnowQy8vYVZreEI1NnY2UklCQ0xLUkwzTmRUaWdHcE4rc2xTNmVtRjNic0lrbwp6T3VHYUg5TElSTllVL3BuRnJBcFpCU25vWElGa2M4WHRwS29IakttMDVmOUZZMlJseHhHdVl5bjZ0c2o2WGNkCnhsM1owWXI3cGoyWWVJdS9sWXNXcGdIalZsWHFZbVpIQWJVL1VwTll3ZzR3ZVRNRHVUWmQ0YUwwRVpQcGc2clkKKzFEckdHODFaeDZWbUhXa2xWTXdDUDkvQXZ2VlhqaWlHdVNBCi0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  signerName: kubernetes.io/legacy-unknown
  usages:
  - digital signature
  - key encipherment
  - server auth
  username: minikube-user
status:
  certificate: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1akNDQWM2Z0F3SUJBZ0lRWVdpS3cveHNkVkpVT09pMTBBZU9LekFOQmdrcWhraUc5dzBCQVFzRkFEQVYKTVJNd0VRWURWUVFERXdwdGFXNXBhM1ZpWlVOQk1CNFhEVEl4TURreU1qSXpORGt6TTFvWERUSXlNRGt5TWpJegpORGt6TTFvd0VqRVFNQTRHQTFVRUF4TUhZbWhoY21GMGFEQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQCkFEQ0NBUW9DZ2dFQkFPZ0tPR1UvUU9nTlRoeW1ucTl4VzBwREZSdnk0UG5uUERkYmF2RExIaTZnNDd1amNicVYKY3MyYmdHbWlNdWlhTFQzV01YaVB4eFRjWXFKZDYvSGEyc1hBbXZLQUtVZTVpNUJRM093cTNrVnducEU3bENzNQpOWWRzT25XYWVPRnBVbzJQMno0eDEzYzBPY2UxRms2UjNwZDdaSzlReWxqVEVxeVJhZ2ZVSEo0TTBqTThXbWZECnRmTXdWTlRRQzErYjVUdmRINmxhSTJMeXhjRFFzS3pYMUdLNW5WTDNaeS84NEM1NUlYL0Q4QTRNcHFpUm1JdXUKQTV3U0dhRnV5bEpGdGFXc2g0WHVpTytoRHdHNU8wcVdOeDkzaDBEZkFkb0JmZHVDb0k3RjdQU3pwS0ZCcFl2cQpzc3hZcWJOTnJJRVhxZ3k4MUF1SU41VG83Wi9PUGYwb0Q2Y0NBd0VBQWFNMU1ETXdEZ1lEVlIwUEFRSC9CQVFECkFnV2dNQk1HQTFVZEpRUU1NQW9HQ0NzR0FRVUZCd01CTUF3R0ExVWRFd0VCL3dRQ01BQXdEUVlKS29aSWh2Y04KQVFFTEJRQURnZ0VCQUZ2NVE5QXRaR2QySnVwY3N5a29OZ3N0ODNmKzFjc1FYbjJtN1MxcWF3UnB0VVVFRDRiRwpyU0czUGRzeTVWZWxQQmlicHRiS0dXNitQU2xyc3lHRDRWZkJ6RWIzaVFGSWtiL1ltY1h0WVhKMEx2cjBqY1FHCjN5N01DbDMyYWR1MDJtSWNlcm5NZG1kekRlQUhENkg2YThqeG9oOEZvZktNNmlQdytyM3hYWWhxVmJyalFscnQKclZ2cDNwbE9qc0pSUW5pWnpMb3Y0UXRzNk02RHBySWlsditVUU9lMUZ5eXpuSCtaV2JwUmZMejJ6L0ZqT0ZvVgpCeXpaM0NmN1BxSEM0ZXFyZHF2U3VQdHhhK3VaNU1xWVlnRHN4NjRraEVqR0dkNHFlSVdpbHFQcWNuNG5USlRJCi82ZXhlVi9LaEwzc3lXaUN1TGJjWllqMnRQWDZ5WkN2UmNrPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
  conditions:
  - lastTransitionTime: "2021-09-22T23:54:33Z"
    lastUpdateTime: "2021-09-22T23:54:33Z"
    message: This CSR was approved by kubectl certificate approve.
    reason: KubectlApprove
    status: "True"
    type: Approved
MacBook-Pro:6.Security bharathdasaraju$ 


So the issued certificate is as below:
----------------------------------------------------->

LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1akNDQWM2Z0F3SUJBZ0lRWVdpS3cveHNkVkpVT09pMTBBZU9LekFOQmdrcWhraUc5dzBCQVFzRkFEQVYKTVJNd0VRWURWUVFERXdwdGFXNXBhM1ZpWlVOQk1CNFhEVEl4TURreU1qSXpORGt6TTFvWERUSXlNRGt5TWpJegpORGt6TTFvd0VqRVFNQTRHQTFVRUF4TUhZbWhoY21GMGFEQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQCkFEQ0NBUW9DZ2dFQkFPZ0tPR1UvUU9nTlRoeW1ucTl4VzBwREZSdnk0UG5uUERkYmF2RExIaTZnNDd1amNicVYKY3MyYmdHbWlNdWlhTFQzV01YaVB4eFRjWXFKZDYvSGEyc1hBbXZLQUtVZTVpNUJRM093cTNrVnducEU3bENzNQpOWWRzT25XYWVPRnBVbzJQMno0eDEzYzBPY2UxRms2UjNwZDdaSzlReWxqVEVxeVJhZ2ZVSEo0TTBqTThXbWZECnRmTXdWTlRRQzErYjVUdmRINmxhSTJMeXhjRFFzS3pYMUdLNW5WTDNaeS84NEM1NUlYL0Q4QTRNcHFpUm1JdXUKQTV3U0dhRnV5bEpGdGFXc2g0WHVpTytoRHdHNU8wcVdOeDkzaDBEZkFkb0JmZHVDb0k3RjdQU3pwS0ZCcFl2cQpzc3hZcWJOTnJJRVhxZ3k4MUF1SU41VG83Wi9PUGYwb0Q2Y0NBd0VBQWFNMU1ETXdEZ1lEVlIwUEFRSC9CQVFECkFnV2dNQk1HQTFVZEpRUU1NQW9HQ0NzR0FRVUZCd01CTUF3R0ExVWRFd0VCL3dRQ01BQXdEUVlKS29aSWh2Y04KQVFFTEJRQURnZ0VCQUZ2NVE5QXRaR2QySnVwY3N5a29OZ3N0ODNmKzFjc1FYbjJtN1MxcWF3UnB0VVVFRDRiRwpyU0czUGRzeTVWZWxQQmlicHRiS0dXNitQU2xyc3lHRDRWZkJ6RWIzaVFGSWtiL1ltY1h0WVhKMEx2cjBqY1FHCjN5N01DbDMyYWR1MDJtSWNlcm5NZG1kekRlQUhENkg2YThqeG9oOEZvZktNNmlQdytyM3hYWWhxVmJyalFscnQKclZ2cDNwbE9qc0pSUW5pWnpMb3Y0UXRzNk02RHBySWlsditVUU9lMUZ5eXpuSCtaV2JwUmZMejJ6L0ZqT0ZvVgpCeXpaM0NmN1BxSEM0ZXFyZHF2U3VQdHhhK3VaNU1xWVlnRHN4NjRraEVqR0dkNHFlSVdpbHFQcWNuNG5USlRJCi82ZXhlVi9LaEwzc3lXaUN1TGJjWllqMnRQWDZ5WkN2UmNrPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==



MacBook-Pro:6.Security bharathdasaraju$ echo "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM1akNDQWM2Z0F3SUJBZ0lRWVdpS3cveHNkVkpVT09pMTBBZU9LekFOQmdrcWhraUc5dzBCQVFzRkFEQVYKTVJNd0VRWURWUVFERXdwdGFXNXBhM1ZpWlVOQk1CNFhEVEl4TURreU1qSXpORGt6TTFvWERUSXlNRGt5TWpJegpORGt6TTFvd0VqRVFNQTRHQTFVRUF4TUhZbWhoY21GMGFEQ0NBU0l3RFFZSktvWklodmNOQVFFQkJRQURnZ0VQCkFEQ0NBUW9DZ2dFQkFPZ0tPR1UvUU9nTlRoeW1ucTl4VzBwREZSdnk0UG5uUERkYmF2RExIaTZnNDd1amNicVYKY3MyYmdHbWlNdWlhTFQzV01YaVB4eFRjWXFKZDYvSGEyc1hBbXZLQUtVZTVpNUJRM093cTNrVnducEU3bENzNQpOWWRzT25XYWVPRnBVbzJQMno0eDEzYzBPY2UxRms2UjNwZDdaSzlReWxqVEVxeVJhZ2ZVSEo0TTBqTThXbWZECnRmTXdWTlRRQzErYjVUdmRINmxhSTJMeXhjRFFzS3pYMUdLNW5WTDNaeS84NEM1NUlYL0Q4QTRNcHFpUm1JdXUKQTV3U0dhRnV5bEpGdGFXc2g0WHVpTytoRHdHNU8wcVdOeDkzaDBEZkFkb0JmZHVDb0k3RjdQU3pwS0ZCcFl2cQpzc3hZcWJOTnJJRVhxZ3k4MUF1SU41VG83Wi9PUGYwb0Q2Y0NBd0VBQWFNMU1ETXdEZ1lEVlIwUEFRSC9CQVFECkFnV2dNQk1HQTFVZEpRUU1NQW9HQ0NzR0FRVUZCd01CTUF3R0ExVWRFd0VCL3dRQ01BQXdEUVlKS29aSWh2Y04KQVFFTEJRQURnZ0VCQUZ2NVE5QXRaR2QySnVwY3N5a29OZ3N0ODNmKzFjc1FYbjJtN1MxcWF3UnB0VVVFRDRiRwpyU0czUGRzeTVWZWxQQmlicHRiS0dXNitQU2xyc3lHRDRWZkJ6RWIzaVFGSWtiL1ltY1h0WVhKMEx2cjBqY1FHCjN5N01DbDMyYWR1MDJtSWNlcm5NZG1kekRlQUhENkg2YThqeG9oOEZvZktNNmlQdytyM3hYWWhxVmJyalFscnQKclZ2cDNwbE9qc0pSUW5pWnpMb3Y0UXRzNk02RHBySWlsditVUU9lMUZ5eXpuSCtaV2JwUmZMejJ6L0ZqT0ZvVgpCeXpaM0NmN1BxSEM0ZXFyZHF2U3VQdHhhK3VaNU1xWVlnRHN4NjRraEVqR0dkNHFlSVdpbHFQcWNuNG5USlRJCi82ZXhlVi9LaEwzc3lXaUN1TGJjWllqMnRQWDZ5WkN2UmNrPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==" | base64 --decode 
-----BEGIN CERTIFICATE-----
MIIC5jCCAc6gAwIBAgIQYWiKw/xsdVJUOOi10AeOKzANBgkqhkiG9w0BAQsFADAV
MRMwEQYDVQQDEwptaW5pa3ViZUNBMB4XDTIxMDkyMjIzNDkzM1oXDTIyMDkyMjIz
NDkzM1owEjEQMA4GA1UEAxMHYmhhcmF0aDCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAOgKOGU/QOgNThymnq9xW0pDFRvy4PnnPDdbavDLHi6g47ujcbqV
cs2bgGmiMuiaLT3WMXiPxxTcYqJd6/Ha2sXAmvKAKUe5i5BQ3Owq3kVwnpE7lCs5
NYdsOnWaeOFpUo2P2z4x13c0Oce1Fk6R3pd7ZK9QyljTEqyRagfUHJ4M0jM8WmfD
tfMwVNTQC1+b5TvdH6laI2LyxcDQsKzX1GK5nVL3Zy/84C55IX/D8A4MpqiRmIuu
A5wSGaFuylJFtaWsh4XuiO+hDwG5O0qWNx93h0DfAdoBfduCoI7F7PSzpKFBpYvq
ssxYqbNNrIEXqgy81AuIN5To7Z/OPf0oD6cCAwEAAaM1MDMwDgYDVR0PAQH/BAQD
AgWgMBMGA1UdJQQMMAoGCCsGAQUFBwMBMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcN
AQELBQADggEBAFv5Q9AtZGd2JupcsykoNgst83f+1csQXn2m7S1qawRptUUED4bG
rSG3Pdsy5VelPBibptbKGW6+PSlrsyGD4VfBzEb3iQFIkb/YmcXtYXJ0Lvr0jcQG
3y7MCl32adu02mIcernMdmdzDeAHD6H6a8jxoh8FofKM6iPw+r3xXYhqVbrjQlrt
rVvp3plOjsJRQniZzLov4Qts6M6DprIilv+UQOe1FyyznH+ZWbpRfLz2z/FjOFoV
ByzZ3Cf7PqHC4eqrdqvSuPtxa+uZ5MqYYgDsx64khEjGGd4qeIWilqPqcn4nTJTI
/6exeV/KhL3syWiCuLbcZYj2tPX6yZCvRck=
-----END CERTIFICATE-----
MacBook-Pro:6.Security bharathdasaraju$ 


Kube controlller-manager does all this certificate stuff :) 
kube-controller-manager yaml file:
------------------------------------->
--cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
--cluster-signing-key-file=/etc/kubernetes/pki/ca.key


A new member akshay joined our team. He requires access to our cluster. The Certificate Signing Request is at the /root location.


root@controlplane:~# ls -lrth
total 8.0K
-rw------- 1 root root 1.7K Sep 23 00:03 akshay.key
-rw-r--r-- 1 root root  887 Sep 23 00:03 akshay.csr
root@controlplane:~# 

root@controlplane:~# cat akshay.csr | base64
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBN
QTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJD
Z0tDQVFFQXBQTE5NcjBjUDZueVIrTmdmYVJ0UFNKemVIZXFXS21Ha21nMmk1NmRoQWFYCnlaNTFK
SVkwY0MyUWpXQ2o0ZTF5ZUJlUFRJWThPSWQ1QXdKcU92Y05JMzh1SWZ1WjVDNkhNV3ZXR2lOZmNj
ek0KeUVLTFhxMTVDSy91bUNSTDEwenBiOFdBVzkyS2tPY05xbENza1VnWWpZbWs4RkdwS2J6dUhw
bVdsVjdEcm9hLwpJSlVVRXN0NGcyN1JCRHVVNk1PVnRHMUMwMnpmd1UyeUxCSzFsMDgyV29NVno0
NzY3UWZsdWlIWmR5MEdaZUZMCjBHalpvYkxNelFRS0U3V0dGa3ZiUzdMaklRSVR4M0QwSEV1OUVE
NnFURHpyN3JUS005VTVrcXQ1VHBldHhqNnYKSWFhR2lrRmNLbnl4NExaOE9seVFDdlNFdlNOT2JO
blpSTkt1VTRHTXV3SURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBQitORGFUZ1Y0
MnZ3R2lPbjRmT0lodlpkQ3o1WkQzbXlyL25kcHVWaFBwMTg5cTN0STI2CjhYUzBHUGY2aFlDV2g5
aGl5TWM0SGZUR3h2M1ZFYlU0WWFnVVczTnlCUHlKY0tCNXoyMEZVNWZramFRdmhUdkcKTmx6blgy
UURXRmtHY3RZb05uZjdwdFFkRldnUnVERklaSEZHN291OE84UCtBUE5iVlRpR1gyc05CaGFXVjJW
VApsVHVSZk5zQkNndlRvZDdIQ0F1Tzl4OExIbFVhdUNVYnV3STNvN3ZVYVpWanJVeVZscFd1MGFU
QlZ2OVNJWWNMCldrRmxxU0tGM0c4ektrelE0TGxyZEo3dnpjajVZVld6M2NkWjRtc1NJaDdWZ1dZ
L2lrYlpLKy9LVW9JdU9IY3oKL2VMQ0hDK2lNSGJiMzVqcjEyZkVBamdVK2hoTHlxdThZZms9Ci0t
LS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
root@controlplane:~#




root@controlplane:~# ls -rtlh
total 12K
-rw------- 1 root root 1.7K Sep 23 00:03 akshay.key
-rw-r--r-- 1 root root  887 Sep 23 00:03 akshay.csr
-rw-r--r-- 1 root root 1.4K Sep 23 00:06 certificatesiging.yaml
root@controlplane:~# vim CertSigningRequest_user.yaml 
root@controlplane:~# kubectl apply -f CertSigningRequest_user.yaml
certificatesigningrequest.certificates.k8s.io/akshay created
root@controlplane:~# 


root@controlplane:~# kubectl get csr
NAME        AGE   SIGNERNAME                                    REQUESTOR                  CONDITION
akshay      48s   kubernetes.io/kube-apiserver-client           kubernetes-admin           Pending
csr-7788z   16m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   Approved,Issued
root@controlplane:~# 

root@controlplane:~# kubectl certificate approve akshay
certificatesigningrequest.certificates.k8s.io/akshay approved
root@controlplane:~# kubectl get csr
NAME        AGE    SIGNERNAME                                    REQUESTOR                  CONDITION
akshay      109s   kubernetes.io/kube-apiserver-client           kubernetes-admin           Approved,Issued
csr-7788z   17m    kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   Approved,Issued
root@controlplane:~# 



root@controlplane:~# kubectl get csr agent-smith -o yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  creationTimestamp: "2021-09-23T00:15:27Z"
  managedFields:
  - apiVersion: certificates.k8s.io/v1
    fieldsType: FieldsV1
    fieldsV1:
      f:spec:
        f:groups: {}
        f:request: {}
        f:signerName: {}
        f:usages: {}
    manager: kubectl-create
    operation: Update
    time: "2021-09-23T00:15:27Z"
  name: agent-smith
  resourceVersion: "1794"
  uid: 8a739bc7-cc33-46b8-8208-5df6969917e7
spec:
  groups:
  - system:masters
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1dEQ0NBVUFDQVFBd0V6RVJNQThHQTFVRUF3d0libVYzTFhWelpYSXdnZ0VpTUEwR0NTcUdTSWIzRFFFQgpBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRRE8wV0pXK0RYc0FKU0lyanBObzV2UklCcGxuemcrNnhjOStVVndrS2kwCkxmQzI3dCsxZUVuT041TXVxOTlOZXZtTUVPbnJEVU8vdGh5VnFQMncyWE5JRFJYall5RjQwRmJtRCs1eld5Q0sKeTNCaWhoQjkzTUo3T3FsM1VUdlo4VEVMcXlhRGtuUmwvanYvU3hnWGtvazBBQlVUcFdNeDRCcFNpS2IwVSt0RQpJRjVueEF0dE1Wa0RQUTdOYmVaUkc0M2IrUVdsVkdSL3o2RFdPZkpuYmZlek90YUF5ZEdMVFpGQy93VHB6NTJrCkVjQ1hBd3FDaGpCTGt6MkJIUFI0Sjg5RDZYYjhrMzlwdTZqcHluZ1Y2dVAwdEliT3pwcU52MFkwcWRFWnB3bXcKajJxRUwraFpFV2trRno4MGxOTnR5VDVMeE1xRU5EQ25JZ3dDNEdaaVJHYnJBZ01CQUFHZ0FEQU5CZ2txaGtpRwo5dzBCQVFzRkFBT0NBUUVBUzlpUzZDMXV4VHVmNUJCWVNVN1FGUUhVemFsTnhBZFlzYU9SUlFOd0had0hxR2k0CmhPSzRhMnp5TnlpNDRPT2lqeWFENnRVVzhEU3hrcjhCTEs4S2czc3JSRXRKcWw1ckxaeTlMUlZyc0pnaEQ0Z1kKUDlOTCthRFJTeFJPVlNxQmFCMm5XZVlwTTVjSjVURjUzbGVzTlNOTUxRMisrUk1uakRRSjdqdVBFaWM4L2RoawpXcjJFVU02VWF3enlrcmRISW13VHYybWxNWTBSK0ROdFYxWWllKzBIOS9ZRWx0K0ZTR2poNUw1WVV2STFEcWl5CjRsM0UveTNxTDcxV2ZBY3VIM09zVnBVVW5RSVNNZFFzMHFXQ3NiRTU2Q0M1RGhQR1pJcFVibktVcEF3a2ErOEUKdndRMDdqRytocGtueG11RkFlWHhnVXdvZEFMYUo3anUvVERJY3c9PQotLS0tLUVORCBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0K
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - digital signature
  - key encipherment
  - server auth
  username: agent-x
status: {}
root@controlplane:~# 


root@controlplane:~# kubectl certificate deny agent-smith
certificatesigningrequest.certificates.k8s.io/agent-smith denied
root@controlplane:~# kubectl get csr
NAME          AGE     SIGNERNAME                                    REQUESTOR                  CONDITION
agent-smith   106s    kubernetes.io/kube-apiserver-client           agent-x                    Denied
akshay        4m17s   kubernetes.io/kube-apiserver-client           kubernetes-admin           Approved,Issued
csr-7788z     20m     kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   Approved,Issued
root@controlplane:~# 


root@controlplane:~# kubectl delete csr agent-smith 
certificatesigningrequest.certificates.k8s.io "agent-smith" deleted
root@controlplane:~# 
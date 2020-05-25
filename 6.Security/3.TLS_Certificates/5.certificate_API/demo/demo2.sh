master $ kubectl get csr agent-smith -o yaml
apiVersion: certificates.k8s.io/v1beta1
kind: CertificateSigningRequest
metadata:
  creationTimestamp: "2020-05-25T01:25:26Z"
  name: agent-smith
  resourceVersion: "2448"
  selfLink: /apis/certificates.k8s.io/v1beta1/certificatesigningrequests/agent-smith
  uid: b9d809c2-326f-4146-b905-295f33790d68
spec:
  groups:
  - system:masters
  - system:authenticated
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1dEQ0NBVUFDQVFBd0V6RVJNQThHQTFVRUF3d0libVYzTFhWelpYSXdnZ0VpTUEwR0NTcUdTSWIzRFFFQgpBUVVBQTRJQkR3QXdnZ0VLQW9JQkFRRE8wV0pXK0RYc0FKU0lyanBObzV2UklCcGxuemcrNnhjOStVVndrS2kwCkxmQzI3dCsxZUVuT041TXVxOTlOZXZtTUVPbnJEVU8vdGh5VnFQMncyWE5JRFJYall5RjQwRmJtRCs1eld5Q0sKeTNCaWhoQjkzTUo3T3FsM1VUdlo4VEVMcXlhRGtuUmwvanYvU3hnWGtvazBBQlVUcFdNeDRCcFNpS2IwVSt0RQpJRjVueEF0dE1Wa0RQUTdOYmVaUkc0M2IrUVdsVkdSL3o2RFdPZkpuYmZlek90YUF5ZEdMVFpGQy93VHB6NTJrCkVjQ1hBd3FDaGpCTGt6MkJIUFI0Sjg5RDZYYjhrMzlwdTZqcHluZ1Y2dVAwdEliT3pwcU52MFkwcWRFWnB3bXcKajJxRUwraFpFV2trRno4MGxOTnR5VDVMeE1xRU5EQ25JZ3dDNEdaaVJHYnJBZ01CQUFHZ0FEQU5CZ2txaGtpRwo5dzBCQVFzRkFBT0NBUUVBUzlpUzZDMXV4VHVmNUJCWVNVN1FGUUhVemFsTnhBZFlzYU9SUlFOd0had0hxR2k0CmhPSzRhMnp5TnlpNDRPT2lqeWFENnRVVzhEU3hrcjhCTEs4S2czc3JSRXRKcWw1ckxaeTlMUlZyc0pnaEQ0Z1kKUDlOTCthRFJTeFJPVlNxQmFCMm5XZVlwTTVjSjVURjUzbGVzTlNOTUxRMisrUk1uakRRSjdqdVBFaWM4L2RoawpXcjJFVU02VWF3enlrcmRISW13VHYybWxNWTBSK0ROdFYxWWllKzBIOS9ZRWx0K0ZTR2poNUw1WVV2STFEcWl5CjRsM0UveTNxTDcxV2ZBY3VIM09zVnBVVW5RSVNNZFFzMHFXQ3NiRTU2Q0M1RGhQR1pJcFVibktVcEF3a2ErOEUKdndRMDdqRytocGtueG11RkFlWHhnVXdvZEFMYUo3anUvVERJY3c9PQotLS0tLUVORCBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0K
  usages:
  - digital signature
  - key encipherment
  - server auth
  username: agent-x
status: {}
master $


------------------------------------------------------------------------------------------>

master $ kubectl certificate deny agent-smith
certificatesigningrequest.certificates.k8s.io/agent-smith approved
master $

master $ kubectl get csr
NAME          AGE     REQUESTOR                 CONDITION
agent-smith   2m38s   agent-x                   Denied
akshay        8m4s    kubernetes-admin          Approved,Issued
csr-2k96h     27m     system:node:master        Approved,Issued
csr-cg2rn     27m     system:bootstrap:96771a   Approved,Issued
master $

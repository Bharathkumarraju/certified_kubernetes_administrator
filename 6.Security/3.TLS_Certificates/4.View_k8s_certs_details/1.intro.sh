How to view certificates in an existing kubernets cluster.

How to perform a health check of all the certificates in the entire cluster:
---------------------------------------------------------------------------------->
How the kubernets cluster has deployed matters...
1. "The Hard way"
Manually create and use TLS certs in each component mostly all k8s components deployed as linux service.

2. "kubeadm"
-------------------------------->
all TLS certs creation automatically takes care by kubeadm tool.
in this all k8s components deployed as static pods. go and have a look at /etc/kubernets/manifests.

The idea is to create the list of certificate files used  their pods, the names configured on them.
The alternate names configured, the organization  the certificate account belongs to,
the issuer of the certificate and the expiration date on the certificate.

check link: https://docs.google.com/spreadsheets/d/1NyON12dBlYO8mwLopQNkZKPoVXfC6ocZB0liEJldh3Y/edit?usp=sharing


Kube-apiserver:
-------------------->
cat /etc/kubernets/manifests/kube-apiserver.yaml

Lets take the apiserver.crt file in /etc/kubernets/pki/apiserver.crt
use the below command and provide certificate file as input to decode the certificate and view details.

$ openssl x509 -in /etc/kubernets/pki/apiserver.crt -text -noout

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl x509 -in apiserver.crt -text -noout
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 13415778325770680940 (0xba2e6b4eb4f23a6c)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: CN=KUBERNETES-CA
        Validity
            Not Before: May 23 07:16:53 2020 GMT
            Not After : Jun 22 07:16:53 2020 GMT
        Subject: CN=kube-apiserver
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:d5:84:cf:06:56:67:79:d8:5b:04:88:fe:8b:92:
                    30:2d:4d:60:fd:6a:a3:1e:85:a8:73:b2:67:c5:12:
                    8d:6a:ac:9a:3b:b8:a9:cd:69:a2:ba:10:35:79:f5:
                    8a:f7:85:7d:69:6f:d9:c6:ea:a3:de:96:b4:a7:cd:
                    0a:ec:d7:b6:fd:7d:7a:b5:8f:bf:4c:fe:2c:28:08:
                    8d:f7:8c:c1:b8:d6:7a:23:7a:fa:0a:0b:67:95:c9:
                    5e:c4:b0:31:c7:ea:61:38:76:94:c1:bd:ed:5d:ca:
                    e0:6d:3d:4c:da:19:58:ed:56:38:91:27:dd:8a:e2:
                    1f:26:bf:b5:07:18:41:53:e2:de:af:96:e2:d5:c8:
                    a8:63:09:9b:23:7b:52:dc:c2:f5:09:86:70:1a:e5:
                    fb:38:1d:58:b6:cb:46:e6:1a:d8:e6:63:58:c2:23:
                    b7:ee:31:22:33:9e:a4:28:d3:88:28:c5:34:7d:fd:
                    1f:48:f2:67:9a:c7:03:27:90:36:57:48:4f:b1:18:
                    8c:24:ce:9a:a8:0b:a0:9d:6b:40:57:9f:ae:0e:f2:
                    2e:70:45:dc:aa:e6:cb:20:e7:e3:94:52:cf:81:66:
                    6b:2d:0c:24:d1:24:78:55:32:40:a6:ea:ef:36:12:
                    37:8a:b2:be:f8:5f:12:0f:67:77:f7:77:f3:8f:85:
                    20:87
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha1WithRSAEncryption
         1a:0a:8e:f6:4a:b9:65:af:90:1d:55:bc:19:b1:2b:59:08:70:
         f2:cf:51:8e:99:a1:46:7b:35:ed:4a:a2:65:b3:bd:39:50:aa:
         b8:07:68:99:24:3b:dd:f6:96:5e:7b:85:74:7e:6a:13:cb:d3:
         dc:40:24:11:95:a0:80:25:11:db:9c:43:2b:a6:ec:2e:22:9e:
         d5:7f:78:7a:c1:12:ff:80:ec:9e:38:09:68:d6:f3:7e:ba:d8:
         36:5f:22:d5:55:5a:30:ee:86:ee:4b:63:7b:2b:f9:c7:9c:98:
         6c:2a:de:66:bb:21:dc:b0:a1:36:89:e9:db:08:a9:46:03:2d:
         7a:95:97:ee:19:cc:8a:15:d1:f1:14:7d:cb:e3:1a:e8:f1:01:
         33:81:02:8c:31:c0:54:9b:3b:34:2b:da:88:ef:ae:7e:39:63:
         06:c6:2c:42:d4:55:d3:1f:04:23:ee:ee:74:e2:69:2f:5d:34:
         6c:84:f0:2c:2d:33:64:ad:41:0a:57:bb:81:ed:f1:f1:2d:63:
         cb:37:13:29:76:6d:d8:70:6b:a4:d3:78:84:ac:5a:3d:2b:8c:
         5c:2f:a5:36:53:69:22:13:aa:fe:0c:d7:1d:11:51:26:79:03:
         1d:31:95:d3:f0:24:97:90:57:ec:b4:16:4f:07:ff:43:a6:bd:
         2e:ce:71:d4
bharathdasaraju@MacBook-Pro TLSCERTS $




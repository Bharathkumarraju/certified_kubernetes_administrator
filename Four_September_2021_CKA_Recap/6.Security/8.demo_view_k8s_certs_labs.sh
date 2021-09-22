root@controlplane:/etc/kubernetes/pki# ls -rtlh
total 60K
-rw------- 1 root root 1.7K Sep 22 23:00 ca.key
-rw-r--r-- 1 root root 1.1K Sep 22 23:00 ca.crt
-rw------- 1 root root 1.7K Sep 22 23:00 apiserver.key
-rw-r--r-- 1 root root 1.3K Sep 22 23:00 apiserver.crt
-rw------- 1 root root 1.7K Sep 22 23:00 apiserver-kubelet-client.key
-rw-r--r-- 1 root root 1.2K Sep 22 23:00 apiserver-kubelet-client.crt
-rw------- 1 root root 1.7K Sep 22 23:00 front-proxy-ca.key
-rw-r--r-- 1 root root 1.1K Sep 22 23:00 front-proxy-ca.crt
-rw------- 1 root root 1.7K Sep 22 23:00 front-proxy-client.key
-rw-r--r-- 1 root root 1.1K Sep 22 23:00 front-proxy-client.crt
drwxr-xr-x 2 root root 4.0K Sep 22 23:00 etcd
-rw------- 1 root root 1.7K Sep 22 23:00 apiserver-etcd-client.key
-rw-r--r-- 1 root root 1.2K Sep 22 23:00 apiserver-etcd-client.crt
-rw------- 1 root root  451 Sep 22 23:00 sa.pub
-rw------- 1 root root 1.7K Sep 22 23:00 sa.key
root@controlplane:/etc/kubernetes/pki# pwd
/etc/kubernetes/pki
root@controlplane:/etc/kubernetes/pki# 


Identify the Certificate file used to authenticate kube-apiserver as a client to ETCD Server

root@controlplane:/etc/kubernetes/pki# ls -rlth apiserver-etcd-client.crt
-rw-r--r-- 1 root root 1.2K Sep 22 23:00 apiserver-etcd-client.crt
root@controlplane:/etc/kubernetes/pki# 

root@controlplane:/etc/kubernetes/pki# ls -rtlh apiserver-kubelet-client.key
-rw------- 1 root root 1.7K Sep 22 23:00 apiserver-kubelet-client.key
root@controlplane:/etc/kubernetes/pki# 



root@controlplane:/etc/kubernetes/pki/etcd# ls -lrth
total 32K
-rw------- 1 root root 1.7K Sep 22 23:00 ca.key
-rw-r--r-- 1 root root 1.1K Sep 22 23:00 ca.crt
-rw------- 1 root root 1.7K Sep 22 23:00 server.key
-rw-r--r-- 1 root root 1.2K Sep 22 23:00 server.crt
-rw------- 1 root root 1.7K Sep 22 23:00 peer.key
-rw-r--r-- 1 root root 1.2K Sep 22 23:00 peer.crt
-rw------- 1 root root 1.7K Sep 22 23:00 healthcheck-client.key
-rw-r--r-- 1 root root 1.2K Sep 22 23:00 healthcheck-client.crt
root@controlplane:/etc/kubernetes/pki/etcd# 




root@controlplane:/etc/kubernetes/pki# ls -rtlh
total 60K
-rw------- 1 root root 1.7K Sep 22 23:00 ca.key
-rw-r--r-- 1 root root 1.1K Sep 22 23:00 ca.crt
-rw------- 1 root root 1.7K Sep 22 23:00 apiserver.key
-rw-r--r-- 1 root root 1.3K Sep 22 23:00 apiserver.crt
-rw------- 1 root root 1.7K Sep 22 23:00 apiserver-kubelet-client.key
-rw-r--r-- 1 root root 1.2K Sep 22 23:00 apiserver-kubelet-client.crt
-rw------- 1 root root 1.7K Sep 22 23:00 front-proxy-ca.key
-rw-r--r-- 1 root root 1.1K Sep 22 23:00 front-proxy-ca.crt
-rw------- 1 root root 1.7K Sep 22 23:00 front-proxy-client.key
-rw-r--r-- 1 root root 1.1K Sep 22 23:00 front-proxy-client.crt
drwxr-xr-x 2 root root 4.0K Sep 22 23:00 etcd
-rw------- 1 root root 1.7K Sep 22 23:00 apiserver-etcd-client.key
-rw-r--r-- 1 root root 1.2K Sep 22 23:00 apiserver-etcd-client.crt
-rw------- 1 root root  451 Sep 22 23:00 sa.pub
-rw------- 1 root root 1.7K Sep 22 23:00 sa.key
root@controlplane:/etc/kubernetes/pki# openssl x509 -in apiserver.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 5024350321412119082 (0x45ba13ff46e39a2a)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Sep 22 23:00:32 2021 GMT
            Not After : Sep 22 23:00:32 2022 GMT
        Subject: CN = kube-apiserver
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:c0:88:39:19:19:fa:35:ab:b6:88:32:84:20:8f:
                    0b:73:e1:9f:4f:0c:99:78:ea:66:eb:28:05:1e:06:
                    f0:05:1f:a1:c2:8a:ed:75:c4:79:12:fe:3f:a5:d1:
                    0c:bb:9c:c2:81:2e:fb:c0:fe:9f:1e:a7:56:fb:fd:
                    75:4f:46:54:93:a4:fc:ed:6d:95:1d:e7:b2:10:05:
                    fb:02:e7:9b:9d:9c:f7:b8:68:32:84:a4:e5:38:29:
                    51:51:85:35:b0:45:49:76:9e:7a:09:4a:01:7f:59:
                    91:99:8e:2f:24:a4:12:1e:d5:df:2b:e3:f1:c9:5e:
                    72:4e:67:f9:ab:dc:a7:29:6e:c1:d9:47:70:69:51:
                    62:37:1b:c5:02:7e:b0:9a:26:df:05:bc:09:b9:fb:
                    7a:dc:d4:e7:07:7c:d8:1f:e7:da:81:3a:4c:c4:4f:
                    f7:06:c9:62:0b:3a:af:7a:8c:59:5f:10:6a:1b:4f:
                    c3:64:14:e0:75:b5:83:ff:f1:eb:5d:5d:91:f4:8f:
                    09:ab:a0:5a:2b:ca:66:d2:59:66:cd:73:94:9a:25:
                    9a:8f:ca:e5:c2:8f:59:88:1d:d0:a5:25:64:09:b3:
                    1a:e8:52:12:b1:43:f0:5d:00:a1:75:cb:07:2a:74:
                    4b:c2:95:ae:fe:92:8b:c7:95:d3:9c:2a:38:60:68:
                    d7:45
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication
            X509v3 Authority Key Identifier: 
                keyid:A9:72:4F:47:6F:40:07:63:76:67:D3:79:51:92:52:65:E1:C3:14:6D

            X509v3 Subject Alternative Name: 
                DNS:controlplane, DNS:kubernetes, DNS:kubernetes.default, DNS:kubernetes.default.svc, DNS:kubernetes.default.svc.cluster.local, IP Address:10.96.0.1, IP Address:10.56.203.8
    Signature Algorithm: sha256WithRSAEncryption
         58:21:ea:22:32:18:21:a5:b0:0a:e9:1e:21:42:71:7f:ab:46:
         49:58:7a:62:2f:7f:a9:5f:bf:a9:c1:69:09:b2:c0:62:ad:71:
         0c:e5:f2:10:8b:2a:94:07:78:d9:7a:1a:b9:17:6b:93:33:ab:
         24:cc:b2:9e:ab:2f:32:ea:36:40:f0:02:df:36:91:76:99:4a:
         07:fc:44:06:8e:c5:07:d0:01:f5:78:9c:55:e3:79:58:56:a6:
         25:63:82:67:ca:27:e7:86:13:06:5a:4a:ea:e7:d5:55:d5:8e:
         82:a5:92:a5:a2:a5:9d:88:06:2c:cb:74:01:fd:f2:9c:6e:1e:
         73:9e:8c:e0:fd:b6:0e:e1:cc:7b:2c:68:fa:34:89:97:89:3e:
         bd:7c:37:6a:6e:28:3f:50:cc:25:7b:94:84:18:b5:85:d2:3f:
         54:b3:54:15:68:c4:5f:36:6a:19:49:f1:2e:3b:a6:94:b7:12:
         97:d1:27:2e:08:12:48:71:1a:8d:aa:b8:f5:70:7f:83:43:27:
         be:88:26:7a:09:b3:3b:a9:f0:c8:89:70:c6:49:cf:e8:75:4f:
         e3:69:f8:9a:8a:8a:9c:89:54:1f:2b:19:3d:df:35:d2:fe:75:
         0b:59:68:97:fa:f9:9a:5b:3b:e5:15:71:2d:6a:46:8f:4e:72:
         07:c4:92:cc
root@controlplane:/etc/kubernetes/pki# 

root@controlplane:/etc/kubernetes/pki# openssl x509 -in apiserver.crt -text -noout | grep -i "issuer"
        Issuer: CN = kubernetes
root@controlplane:/etc/kubernetes/pki# 


root@controlplane:/etc/kubernetes/pki# openssl x509 -in ca.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 0 (0x0)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Sep 22 23:00:32 2021 GMT
            Not After : Sep 20 23:00:32 2031 GMT
        Subject: CN = kubernetes
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:9f:3c:af:c3:a2:5f:61:7d:a0:32:38:b3:e0:84:
                    2e:d8:a9:e3:db:40:74:ab:86:d2:02:33:bc:78:34:
                    0b:30:0e:73:f6:b8:af:17:cb:1c:64:29:69:c9:a2:
                    78:8a:a2:a5:b5:db:3f:b0:e8:33:2e:30:13:16:8a:
                    55:fe:9d:90:54:7f:d3:2e:7a:a8:2f:12:93:8b:44:
                    50:8e:24:f9:f0:e4:d4:1c:6d:f1:7f:a0:ad:f8:78:
                    40:2c:ad:8f:5e:71:02:08:11:55:ce:de:0f:33:7a:
                    fe:3e:cc:40:e6:ff:46:3d:21:77:e5:dc:0a:6e:a2:
                    f7:1f:e2:f8:e1:0e:e9:99:aa:d2:51:4e:b6:7e:83:
                    0e:6f:df:b6:dd:e8:6d:b8:4c:bf:d0:b0:ba:f2:5b:
                    3d:8d:63:ec:9f:e7:ba:44:14:9e:ac:52:22:e1:02:
                    ea:bc:63:b0:c8:6a:8b:00:a7:98:f7:d0:63:33:d9:
                    df:14:ca:c0:2f:ec:dd:27:3a:51:47:01:5c:7b:02:
                    27:76:32:83:24:6a:13:f6:9a:89:f3:e5:d8:40:3f:
                    9f:3e:5e:40:e5:22:38:2c:9a:dc:d2:2e:d6:56:24:
                    c3:a3:61:4b:57:c1:09:ec:89:95:ca:1d:97:06:14:
                    ad:6c:ad:a6:21:03:25:48:94:92:d4:4c:7e:f6:27:
                    9c:a1
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment, Certificate Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Subject Key Identifier: 
                A9:72:4F:47:6F:40:07:63:76:67:D3:79:51:92:52:65:E1:C3:14:6D
    Signature Algorithm: sha256WithRSAEncryption
         42:e0:22:33:fc:7a:21:00:94:e5:66:7b:f7:59:27:42:3a:c5:
         4f:e8:54:90:3a:7d:24:f1:29:5f:ed:e1:04:ff:e0:e5:cf:75:
         be:46:f0:90:2b:97:c5:cd:10:20:8c:95:a6:ee:b5:29:81:e7:
         d7:81:e7:89:09:02:97:a3:6f:c4:33:bd:03:fa:49:a7:1d:0f:
         47:d1:a4:58:af:5c:22:4c:71:e2:89:a0:6d:39:bf:27:60:89:
         42:7d:74:7d:68:b6:19:b2:28:90:b5:d6:57:e5:be:31:a6:55:
         11:b6:7a:35:21:38:09:f3:cb:93:09:12:f1:42:c6:d3:78:33:
         05:05:55:b1:a1:c7:1b:3d:71:af:5a:c9:6f:ef:e0:44:52:73:
         49:92:14:11:ae:49:92:b2:40:b1:85:20:88:12:82:5d:bc:c5:
         28:ca:c5:03:23:30:10:3e:ea:b6:44:3d:dc:90:e4:7d:17:35:
         d0:35:f4:55:a0:0b:50:13:c2:11:8b:5f:21:ae:48:11:b8:52:
         e9:f8:25:c2:d1:1a:f5:6c:6f:91:31:5b:aa:c8:79:e2:ec:f0:
         29:d9:d4:c0:b3:f0:fc:bb:d7:e8:be:ca:ad:da:82:51:9b:75:
         60:45:0f:68:29:0b:e3:f4:1e:b8:8b:6e:2e:18:ea:48:98:c7:
         50:06:43:62
root@controlplane:/etc/kubernetes/pki#





root@controlplane:/etc/kubernetes/pki/etcd# openssl x509 -in server.crt -text -noout 
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 3888003370887390627 (0x35f4f6775f43a5a3)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = etcd-ca
        Validity
            Not Before: Sep 22 23:00:34 2021 GMT
            Not After : Sep 22 23:00:34 2022 GMT
        Subject: CN = controlplane
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:a7:7b:fb:12:fa:e8:20:66:00:46:2c:36:0a:6d:
                    66:2f:d1:b0:41:76:da:6b:35:5e:c0:82:cb:ba:32:
                    b2:46:1d:1d:d6:44:5e:34:9c:fe:56:a1:72:ee:29:
                    f0:91:ea:22:4c:6c:2e:91:59:ff:88:8e:0b:ef:89:
                    2c:8b:b5:e5:4d:ee:bf:79:ea:50:49:c0:fc:8b:f1:
                    33:11:25:b6:ef:e7:aa:55:2c:83:40:b4:64:1e:a3:
                    7c:a5:61:6a:d9:e7:87:2b:a3:4f:35:74:5c:c4:84:
                    99:20:9b:ae:51:d5:71:cc:a3:84:c8:71:83:d5:1e:
                    5e:af:c6:46:e3:f3:3f:5a:ae:c8:b5:8e:cf:7f:a5:
                    2b:64:96:ce:93:8d:6f:a7:1c:d7:7e:91:5c:7a:e7:
                    5f:44:23:52:9e:66:15:81:93:34:19:6f:89:94:76:
                    48:98:25:56:73:12:3d:a9:3b:b6:e1:23:ad:70:df:
                    50:d9:9d:a1:39:18:75:94:1c:38:29:25:1e:41:30:
                    ad:ec:8d:0a:44:07:ec:27:d7:31:68:6e:9b:25:dd:
                    c7:b6:74:25:64:55:94:b5:ea:e3:f4:54:ec:96:49:
                    33:18:ee:59:3f:3e:7d:ce:78:8b:8b:39:37:6e:13:
                    a3:77:ef:0b:77:bf:90:8c:eb:1d:4b:f9:2e:fe:a7:
                    14:6f
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 Authority Key Identifier: 
                keyid:49:94:05:BA:D9:64:3B:11:41:D9:1D:3A:0D:DF:1A:9C:DC:63:38:2F

            X509v3 Subject Alternative Name: 
                DNS:controlplane, DNS:localhost, IP Address:10.56.203.8, IP Address:127.0.0.1, IP Address:0:0:0:0:0:0:0:1
    Signature Algorithm: sha256WithRSAEncryption
         21:bb:d7:25:c3:ef:3f:2c:ea:ff:f2:91:db:e1:12:e4:c6:8d:
         02:42:02:74:37:a3:a3:0a:2d:b3:a6:52:71:02:d9:5f:0d:22:
         6c:d9:49:ce:ec:70:81:c7:dc:b9:0a:0a:80:fb:59:72:6a:af:
         1b:7f:00:2b:16:d0:d9:65:1f:40:5a:a2:ca:e1:2b:3d:24:68:
         90:df:88:18:03:87:5e:c4:3b:ae:58:3b:16:34:39:18:67:1a:
         e1:71:9b:8b:02:9b:93:d2:d0:7f:a9:33:c1:11:23:e5:30:34:
         04:31:87:4b:b5:fe:41:c6:b8:86:2c:33:0d:9c:09:11:fc:a3:
         35:fd:3a:d0:6b:c8:ec:ac:a7:c4:d6:3a:2e:51:9b:2a:3d:89:
         ee:ae:56:cf:1b:51:f1:78:57:58:2f:99:86:6c:e1:c5:9b:e2:
         85:e4:8f:30:cd:e8:07:6b:9b:b5:fb:62:93:38:1d:52:ba:2d:
         85:80:b8:df:b3:c3:bc:22:fb:c0:b2:35:8f:df:c2:d3:77:d0:
         4d:43:5d:66:08:dd:19:b1:3a:bf:49:f5:15:e1:82:7a:6b:38:
         e1:f0:40:d1:24:e1:3e:ea:f6:a2:e4:f0:fd:5f:11:76:97:c0:
         4d:17:12:b8:dd:09:0f:c8:6e:6f:c9:a6:d5:f2:1b:0c:6a:6d:
         a9:11:a3:cc
root@controlplane:/etc/kubernetes/pki/etcd# 



root@controlplane:/etc/kubernetes/pki/etcd# openssl x509 -in ../apiserver.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 5024350321412119082 (0x45ba13ff46e39a2a)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Sep 22 23:00:32 2021 GMT
            Not After : Sep 22 23:00:32 2022 GMT
        Subject: CN = kube-apiserver
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:c0:88:39:19:19:fa:35:ab:b6:88:32:84:20:8f:
                    0b:73:e1:9f:4f:0c:99:78:ea:66:eb:28:05:1e:06:
                    f0:05:1f:a1:c2:8a:ed:75:c4:79:12:fe:3f:a5:d1:
                    0c:bb:9c:c2:81:2e:fb:c0:fe:9f:1e:a7:56:fb:fd:
                    75:4f:46:54:93:a4:fc:ed:6d:95:1d:e7:b2:10:05:
                    fb:02:e7:9b:9d:9c:f7:b8:68:32:84:a4:e5:38:29:
                    51:51:85:35:b0:45:49:76:9e:7a:09:4a:01:7f:59:
                    91:99:8e:2f:24:a4:12:1e:d5:df:2b:e3:f1:c9:5e:
                    72:4e:67:f9:ab:dc:a7:29:6e:c1:d9:47:70:69:51:
                    62:37:1b:c5:02:7e:b0:9a:26:df:05:bc:09:b9:fb:
                    7a:dc:d4:e7:07:7c:d8:1f:e7:da:81:3a:4c:c4:4f:
                    f7:06:c9:62:0b:3a:af:7a:8c:59:5f:10:6a:1b:4f:
                    c3:64:14:e0:75:b5:83:ff:f1:eb:5d:5d:91:f4:8f:
                    09:ab:a0:5a:2b:ca:66:d2:59:66:cd:73:94:9a:25:
                    9a:8f:ca:e5:c2:8f:59:88:1d:d0:a5:25:64:09:b3:
                    1a:e8:52:12:b1:43:f0:5d:00:a1:75:cb:07:2a:74:
                    4b:c2:95:ae:fe:92:8b:c7:95:d3:9c:2a:38:60:68:
                    d7:45
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication
            X509v3 Authority Key Identifier: 
                keyid:A9:72:4F:47:6F:40:07:63:76:67:D3:79:51:92:52:65:E1:C3:14:6D

            X509v3 Subject Alternative Name: 
                DNS:controlplane, DNS:kubernetes, DNS:kubernetes.default, DNS:kubernetes.default.svc, DNS:kubernetes.default.svc.cluster.local, IP Address:10.96.0.1, IP Address:10.56.203.8
    Signature Algorithm: sha256WithRSAEncryption
         58:21:ea:22:32:18:21:a5:b0:0a:e9:1e:21:42:71:7f:ab:46:
         49:58:7a:62:2f:7f:a9:5f:bf:a9:c1:69:09:b2:c0:62:ad:71:
         0c:e5:f2:10:8b:2a:94:07:78:d9:7a:1a:b9:17:6b:93:33:ab:
         24:cc:b2:9e:ab:2f:32:ea:36:40:f0:02:df:36:91:76:99:4a:
         07:fc:44:06:8e:c5:07:d0:01:f5:78:9c:55:e3:79:58:56:a6:
         25:63:82:67:ca:27:e7:86:13:06:5a:4a:ea:e7:d5:55:d5:8e:
         82:a5:92:a5:a2:a5:9d:88:06:2c:cb:74:01:fd:f2:9c:6e:1e:
         73:9e:8c:e0:fd:b6:0e:e1:cc:7b:2c:68:fa:34:89:97:89:3e:
         bd:7c:37:6a:6e:28:3f:50:cc:25:7b:94:84:18:b5:85:d2:3f:
         54:b3:54:15:68:c4:5f:36:6a:19:49:f1:2e:3b:a6:94:b7:12:
         97:d1:27:2e:08:12:48:71:1a:8d:aa:b8:f5:70:7f:83:43:27:
         be:88:26:7a:09:b3:3b:a9:f0:c8:89:70:c6:49:cf:e8:75:4f:
         e3:69:f8:9a:8a:8a:9c:89:54:1f:2b:19:3d:df:35:d2:fe:75:
         0b:59:68:97:fa:f9:9a:5b:3b:e5:15:71:2d:6a:46:8f:4e:72:
         07:c4:92:cc
root@controlplane:/etc/kubernetes/pki/etcd# 



root@controlplane:/etc/kubernetes/pki/etcd# openssl x509 -in ../ca.crt -text -noout 
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 0 (0x0)
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN = kubernetes
        Validity
            Not Before: Sep 22 23:00:32 2021 GMT
            Not After : Sep 20 23:00:32 2031 GMT
        Subject: CN = kubernetes
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:9f:3c:af:c3:a2:5f:61:7d:a0:32:38:b3:e0:84:
                    2e:d8:a9:e3:db:40:74:ab:86:d2:02:33:bc:78:34:
                    0b:30:0e:73:f6:b8:af:17:cb:1c:64:29:69:c9:a2:
                    78:8a:a2:a5:b5:db:3f:b0:e8:33:2e:30:13:16:8a:
                    55:fe:9d:90:54:7f:d3:2e:7a:a8:2f:12:93:8b:44:
                    50:8e:24:f9:f0:e4:d4:1c:6d:f1:7f:a0:ad:f8:78:
                    40:2c:ad:8f:5e:71:02:08:11:55:ce:de:0f:33:7a:
                    fe:3e:cc:40:e6:ff:46:3d:21:77:e5:dc:0a:6e:a2:
                    f7:1f:e2:f8:e1:0e:e9:99:aa:d2:51:4e:b6:7e:83:
                    0e:6f:df:b6:dd:e8:6d:b8:4c:bf:d0:b0:ba:f2:5b:
                    3d:8d:63:ec:9f:e7:ba:44:14:9e:ac:52:22:e1:02:
                    ea:bc:63:b0:c8:6a:8b:00:a7:98:f7:d0:63:33:d9:
                    df:14:ca:c0:2f:ec:dd:27:3a:51:47:01:5c:7b:02:
                    27:76:32:83:24:6a:13:f6:9a:89:f3:e5:d8:40:3f:
                    9f:3e:5e:40:e5:22:38:2c:9a:dc:d2:2e:d6:56:24:
                    c3:a3:61:4b:57:c1:09:ec:89:95:ca:1d:97:06:14:
                    ad:6c:ad:a6:21:03:25:48:94:92:d4:4c:7e:f6:27:
                    9c:a1
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment, Certificate Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
            X509v3 Subject Key Identifier: 
                A9:72:4F:47:6F:40:07:63:76:67:D3:79:51:92:52:65:E1:C3:14:6D
    Signature Algorithm: sha256WithRSAEncryption
         42:e0:22:33:fc:7a:21:00:94:e5:66:7b:f7:59:27:42:3a:c5:
         4f:e8:54:90:3a:7d:24:f1:29:5f:ed:e1:04:ff:e0:e5:cf:75:
         be:46:f0:90:2b:97:c5:cd:10:20:8c:95:a6:ee:b5:29:81:e7:
         d7:81:e7:89:09:02:97:a3:6f:c4:33:bd:03:fa:49:a7:1d:0f:
         47:d1:a4:58:af:5c:22:4c:71:e2:89:a0:6d:39:bf:27:60:89:
         42:7d:74:7d:68:b6:19:b2:28:90:b5:d6:57:e5:be:31:a6:55:
         11:b6:7a:35:21:38:09:f3:cb:93:09:12:f1:42:c6:d3:78:33:
         05:05:55:b1:a1:c7:1b:3d:71:af:5a:c9:6f:ef:e0:44:52:73:
         49:92:14:11:ae:49:92:b2:40:b1:85:20:88:12:82:5d:bc:c5:
         28:ca:c5:03:23:30:10:3e:ea:b6:44:3d:dc:90:e4:7d:17:35:
         d0:35:f4:55:a0:0b:50:13:c2:11:8b:5f:21:ae:48:11:b8:52:
         e9:f8:25:c2:d1:1a:f5:6c:6f:91:31:5b:aa:c8:79:e2:ec:f0:
         29:d9:d4:c0:b3:f0:fc:bb:d7:e8:be:ca:ad:da:82:51:9b:75:
         60:45:0f:68:29:0b:e3:f4:1e:b8:8b:6e:2e:18:ea:48:98:c7:
         50:06:43:62
root@controlplane:/etc/kubernetes/pki/etcd# 
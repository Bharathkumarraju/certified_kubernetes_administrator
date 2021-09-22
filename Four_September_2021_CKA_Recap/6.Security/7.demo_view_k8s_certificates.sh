#k8s 

"kube-apiserver": cat /etc/kubernetes/manifests/kube-apiserver.yaml

MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl x509 -in apiserver.crt -text -noout
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 13415778325770680942 (0xba2e6b4eb4f23a6e)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: CN=KUBERNETES-CA
        Validity
            Not Before: Sep 22 22:42:58 2021 GMT
            Not After : Oct 22 22:42:58 2021 GMT
        Subject: CN=kube-apiserver
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:bc:89:64:af:08:09:a0:04:c6:a5:c5:29:d7:10:
                    df:e1:2d:28:a5:1b:3e:77:2a:76:09:17:8e:95:fe:
                    9e:7d:f9:b5:7b:01:7d:88:2e:28:ab:36:f2:f9:b6:
                    dd:84:fb:2f:f4:ce:bc:81:be:6b:df:60:cd:f5:a6:
                    d1:5d:be:09:83:7e:19:ef:52:d2:56:0f:24:bc:8d:
                    74:72:48:fa:e2:fd:63:2f:30:80:3a:3c:d9:41:d7:
                    62:af:84:bb:e6:bb:2e:0b:96:dc:a6:c6:1f:81:ef:
                    c1:31:e7:85:9a:1d:74:0c:c6:3a:c7:04:b2:a1:65:
                    44:e8:1b:8a:b7:c8:f9:d2:7e:e5:3a:45:ef:5e:52:
                    c3:a7:1e:94:4e:4f:c9:0d:77:51:72:31:79:07:65:
                    4c:23:b0:b5:e2:92:eb:1b:8e:ce:14:f4:dd:32:1a:
                    1b:e1:44:ca:e8:e1:4c:84:bb:00:bf:30:d2:42:e3:
                    4f:bd:11:86:96:f2:ce:e7:45:0c:36:aa:09:2f:8a:
                    f3:02:ed:27:1f:25:88:cd:20:64:6e:f5:e6:29:15:
                    84:c9:aa:c8:1e:4a:0e:d5:03:6f:1b:59:a0:b4:d1:
                    b8:77:20:f2:0c:41:fe:a9:69:80:79:81:d2:df:b4:
                    ae:c0:21:e5:cc:e9:be:ea:90:d2:44:1e:c8:38:85:
                    5f:d1
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha1WithRSAEncryption
         65:8a:0f:cb:41:b7:43:b8:c3:72:1c:cf:2c:a6:c4:64:91:31:
         e5:b2:c0:95:b0:57:14:56:34:a9:fe:d4:41:50:9c:f9:4a:43:
         64:e6:4f:e9:2a:dc:41:9f:79:1b:93:b8:7b:86:16:b1:6f:3f:
         16:4a:c3:f6:f8:ef:33:97:a1:a6:ef:e0:4f:89:45:25:72:be:
         2b:a9:67:a1:97:09:b4:8b:40:e2:b0:b8:41:66:53:ec:9d:a7:
         60:51:66:bd:3d:db:1c:af:7b:fb:71:5d:39:7e:c7:aa:93:07:
         b2:f2:de:f0:6e:67:06:dd:e1:3f:39:4c:f8:2d:26:fd:38:78:
         2f:fe:53:f6:cc:01:17:d6:a2:f2:6e:93:48:8d:b1:07:45:51:
         ca:c7:b9:bf:87:8f:0d:70:cd:5b:64:92:8c:9e:92:d9:56:d7:
         90:2b:fa:9e:b6:03:28:22:f3:6b:9c:71:5a:3d:cb:79:b1:ee:
         d3:8b:57:26:60:1f:85:c4:dd:9d:83:04:6c:75:06:60:92:e1:
         1c:5f:1e:02:82:d1:bf:c7:11:bd:e7:5e:14:18:32:79:74:d1:
         ba:b7:c1:cf:fc:e8:20:ea:fa:77:43:13:79:d9:6d:a9:75:dd:
         f2:4a:24:52:c0:dc:a7:9a:98:01:4d:0a:e6:d1:15:0c:bb:96:
         69:61:07:b9
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$



MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ openssl x509 -in admin.crt -text -noout
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 13415778325770680941 (0xba2e6b4eb4f23a6d)
    Signature Algorithm: sha1WithRSAEncryption
        Issuer: CN=KUBERNETES-CA
        Validity
            Not Before: Sep 22 22:21:45 2021 GMT
            Not After : Oct 22 22:21:45 2021 GMT
        Subject: CN=kube-admin
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:d3:3e:1f:b3:49:45:a2:9d:b9:f8:8a:3d:79:a8:
                    bb:de:9a:6a:d7:e7:64:e5:3d:2e:1f:3e:0a:a1:21:
                    77:44:a8:6e:37:2a:bd:4e:19:bf:7b:42:d6:49:a1:
                    35:b0:e2:4a:3c:3e:ae:f8:01:9f:52:90:33:07:2f:
                    4e:79:f0:ee:2b:6e:25:f9:db:21:dc:72:e5:16:4b:
                    04:3f:36:0e:26:73:aa:97:50:7a:6f:0f:04:94:00:
                    1f:62:94:cb:2d:29:0d:3b:5e:b5:c6:84:da:65:90:
                    be:1c:96:22:73:cb:60:ac:8e:01:68:7c:2d:26:5e:
                    5d:ec:c3:0e:ff:99:00:53:01:93:cc:18:aa:94:f3:
                    69:cf:29:dc:8a:8c:c6:4a:e0:6c:6e:d0:38:95:3c:
                    cd:43:6f:8c:a8:75:d0:4e:ce:65:40:41:32:5d:3f:
                    83:fc:49:3b:e5:59:44:b1:f3:4e:a9:05:32:86:cf:
                    6e:d6:2a:f3:3e:63:5f:23:ad:e7:ca:1e:d3:b1:30:
                    e1:ee:dc:80:aa:f7:a8:e7:1d:0c:55:ba:d7:9b:e7:
                    31:5a:37:9e:0a:55:df:16:fa:9f:e6:01:6f:c8:a1:
                    47:10:72:d5:fa:6b:2d:6c:48:67:dc:cc:1d:5a:6f:
                    27:f3:8f:6e:57:b1:ef:83:fa:c6:5b:8c:09:ab:f8:
                    32:39
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha1WithRSAEncryption
         65:14:3e:1a:17:ba:a2:19:da:76:c8:3f:0b:26:5b:a5:59:ee:
         eb:eb:a3:58:56:bc:15:92:b2:fe:a4:cc:8c:f5:a7:53:98:78:
         ee:50:d0:0b:32:68:50:d1:af:7e:6c:f5:fd:b3:02:03:5b:6d:
         87:4c:89:99:19:af:18:ee:3c:d2:52:59:62:24:37:63:f0:df:
         9c:bc:df:0c:dd:d4:8d:d8:cb:3f:d6:f9:45:2b:ca:e1:c1:b5:
         c6:35:f2:5d:4e:e2:40:6c:63:6d:8a:29:b1:08:1d:b7:ba:f6:
         62:61:b3:5d:a9:ff:f2:cb:04:ff:b7:f4:95:ff:86:78:e9:bc:
         dd:6f:0a:0c:9b:25:17:2b:78:1e:51:cd:41:de:09:10:ae:6d:
         04:4f:f4:af:6e:b5:e8:4f:c7:2d:cd:e8:c6:e2:ed:3e:bd:f0:
         78:14:e4:6c:63:cc:2e:9f:f2:84:b0:89:f4:41:2b:23:6c:2c:
         8e:d2:c2:85:2f:70:ed:83:ac:c9:a8:57:09:1d:74:48:af:17:
         b6:64:6f:ed:22:f1:3a:96:19:f0:c6:4c:21:f9:e8:3c:9a:0b:
         dc:86:ea:d2:2a:2f:1c:30:60:3d:13:cc:af:8d:05:04:64:e5:
         4c:79:88:cf:9b:94:dc:8d:29:5c:07:b6:fe:b1:99:1e:b5:a4:
         8b:a7:cb:15
MacBook-Pro:generate_tls_for_kubernetes bharathdasaraju$ 
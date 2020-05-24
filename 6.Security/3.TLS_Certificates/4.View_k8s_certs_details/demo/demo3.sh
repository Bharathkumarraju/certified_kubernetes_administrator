master $ openssl x509 -in /etc/kubernetes/pki/ca.crt -text -noout
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 0 (0x0)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=kubernetes
        Validity
            Not Before: May 24 00:33:18 2020 GMT
            Not After : May 22 00:33:18 2030 GMT
        Subject: CN=kubernetes
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:c7:19:b8:eb:b3:38:c3:dd:4e:78:f1:ce:e4:1c:
                    85:82:5b:ba:e9:9d:a7:3e:de:43:01:8e:42:f1:3e:
                    68:75:96:1c:a9:b5:f8:68:ec:95:95:fa:44:cf:12:
                    22:79:20:66:13:0a:44:9d:cc:41:3c:9f:b3:49:f7:
                    89:c9:43:df:4a:31:b1:e5:76:2b:a0:1a:f6:72:05:
                    1c:d2:88:27:3f:a1:da:e5:1c:7b:46:8c:18:8d:b3:
                    c6:65:9f:be:91:ec:42:ab:18:a5:ce:2f:a4:7a:58:
                    97:08:26:8b:44:a2:07:9e:06:8a:f7:a7:0a:c9:42:
                    4b:75:4f:7b:a9:0f:f6:21:f8:1a:45:5e:25:1a:ba:
                    91:33:12:04:6a:2c:a9:26:19:da:00:0c:22:8b:93:
                    b6:01:87:6b:b6:ef:e4:e8:d7:71:f6:4d:77:4b:59:
                    e2:5c:a3:14:04:a4:9f:27:30:b3:b4:87:56:de:21:
                    88:03:3d:07:e0:ad:4e:77:c7:98:be:24:47:ff:9a:
                    60:a4:19:38:6e:4e:c5:ae:9b:64:4d:88:ea:fc:02:
                    3c:e4:a4:ff:8a:34:5e:5f:ac:43:39:c6:b6:30:5b:
                    19:4c:f1:45:ae:28:55:1f:8d:14:26:84:da:7b:74:
                    89:47:ab:ee:08:84:5b:38:90:1b:dc:73:46:a3:8d:
                    07:93
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment, Certificate Sign
            X509v3 Basic Constraints: critical
                CA:TRUE
    Signature Algorithm: sha256WithRSAEncryption
         5d:87:ec:48:4a:8a:dd:b7:7a:70:15:33:78:81:8c:64:02:40:
         e6:63:86:92:cf:56:b7:76:c8:a9:a1:c7:6c:e4:07:48:a2:91:
         ba:79:74:e6:09:5a:75:97:42:97:a2:bf:5f:3b:ef:69:54:b9:
         e7:51:ea:6c:5e:24:a1:4b:74:48:8f:ae:0a:e8:9e:2d:fc:36:
         85:42:2b:f7:f9:c6:37:4e:7a:29:a7:bf:90:62:86:e2:83:8d:
         57:81:a8:0a:8a:4e:a1:89:45:6f:cb:56:c0:0a:0c:38:38:6a:
         64:94:9f:f5:be:d0:7e:21:24:f3:9c:04:f5:de:ba:8f:27:a0:
         43:d7:a9:17:93:2f:3b:42:7b:4e:c7:dc:6b:5b:9e:5f:1f:71:
         31:4f:f1:0e:32:88:bf:5f:bd:73:d3:8c:44:69:fc:ff:fa:52:
         dc:d1:cd:7c:72:0a:5b:b8:eb:38:89:ed:72:cb:0a:01:cf:46:
         e0:7b:10:ff:fd:14:21:1f:61:f9:62:42:2c:ab:32:1a:84:b0:
         7b:17:42:b3:07:af:09:9a:3f:52:08:17:ee:d8:c8:7d:fc:55:
         d6:2b:d8:fe:26:ba:5b:25:8e:ad:ed:d6:26:1c:8a:70:c4:f8:
         bc:3e:b6:cd:5f:8e:89:ed:5e:f7:ed:8d:e4:e9:09:2f:5a:c8:
         f2:2e:12:d6
master $


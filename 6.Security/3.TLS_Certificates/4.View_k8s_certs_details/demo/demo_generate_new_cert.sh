generate new cert if it expired.

master $ openssl  x509 -in apiserver-etcd-client.crt -text -noout
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 9618657781232981781 (0x857c564a4a705715)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=etcd-ca
        Validity
            Not Before: May 24 02:50:21 2020 GMT
            Not After : May 14 02:50:21 2020 GMT
        Subject: CN=kube-apiserver-etcd-client, O=system:masters
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:da:b0:85:31:73:09:94:65:20:33:71:74:96:d1:
                    0d:da:08:24:56:93:b2:21:76:ca:b1:2e:04:43:4b:
                    f3:95:d9:1a:3e:8e:6b:44:48:8b:93:19:0d:b0:51:
                    23:19:33:ee:0a:56:9f:9f:bd:4b:21:e3:8d:78:5c:
                    25:74:a9:8d:58:20:14:fb:b9:75:98:a5:a4:7c:e9:
                    8a:53:6e:ad:2b:d1:6c:e0:4e:bc:b7:46:60:6d:cd:
                    e9:8c:9d:c5:14:a8:8c:6c:fc:08:5c:86:a9:df:ef:
                    0c:12:a8:10:00:90:ee:d4:0e:4e:e9:87:83:d5:d8:
                    1e:4c:d5:92:6e:00:75:df:1f:6b:ab:c6:a4:27:78:
                    78:88:d4:53:17:ec:dd:91:b4:c6:64:ff:20:43:33:
                    a7:ce:c8:7d:06:6e:ee:d1:5d:3a:da:0c:95:a2:1a:
                    1a:af:99:b2:d4:4d:5b:47:41:67:1d:7b:65:c9:c4:
                    f2:0f:b3:70:1d:f1:5a:4e:91:30:6e:8b:67:26:92:
                    90:2e:53:a6:e8:0d:41:e1:41:b4:98:36:bb:8d:2f:
                    05:19:09:b9:d8:a3:41:33:0e:a8:ac:e1:83:25:df:
                    e3:b4:e2:7c:31:9e:58:32:35:cc:f9:9f:e6:a6:71:
                    13:7a:fe:85:57:73:ce:ff:28:37:5a:11:a3:4e:dd:
                    3f:33
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha256WithRSAEncryption
         5b:a1:97:ba:08:e2:6f:47:bd:e2:e1:82:1a:dc:bc:f3:05:49:
         27:76:45:54:66:48:d3:f8:d0:60:9d:16:6e:bf:ec:31:57:fc:
         67:51:86:2f:25:ac:19:69:87:0e:3e:43:f0:91:57:ae:0f:2b:
         bb:3d:29:41:a4:2e:83:6e:af:49:71:47:30:f5:06:49:22:40:
         a7:d0:17:5c:20:3c:60:23:2e:84:13:14:98:2a:a1:7a:82:d4:
         ea:52:70:d0:bb:5b:b8:a4:02:a9:5e:3a:b0:20:6c:80:23:09:
         96:79:a8:8c:1b:b9:71:3d:62:3a:2f:62:c3:68:3b:c2:8e:92:
         25:87:8d:51:a2:8c:7a:7d:d1:2d:24:34:ed:56:1b:6d:c9:71:
         31:3f:c0:17:e7:01:a0:36:61:4d:0e:8d:17:93:ec:0d:cd:1a:
         e7:8b:83:e5:6b:d6:54:06:a9:fd:2b:38:a3:d4:c6:d1:8f:33:
         f7:69:8d:fc:04:c8:57:8b:d7:51:56:2f:0f:55:a4:c8:e9:c6:
         19:a8:cb:87:a9:fa:bf:6c:3f:94:c3:cc:25:62:fe:12:db:1a:
         57:11:21:b0:65:85:47:4d:0e:9e:09:d5:04:0d:d9:5e:6b:fa:
         c3:70:4d:4f:4f:c1:2c:13:d9:9b:48:a6:dd:f7:56:67:e7:67:
         f2:d0:13:b2
master $

-------------------------------------------------------------------------------------------------------------------------->

openssl x509 -req -in /etc/kubernetes/pki/apiserver-etcd-client.csr -CA /etc/kubernetes/pki/etcd/ca.crt -CAkey /etc/kubernetes/pki/etcd/ca.key -CAcreateserial -out /etc/kubernetes/pki/apiserver-etcd-client.crt

# Sign a new certificate for the apiserver-etcd-client

master $ openssl x509 -req -in /etc/kubernetes/pki/apiserver-etcd-client.csr -CA /etc/kubernetes/pki/etcd/ca.crt -CAkey /etc/kubernetes/pki/etcd/ca.key -CAcreateserial -out /etc/kubernetes/pki/apiserver-etcd-client.crt
master $

master $ openssl x509 -req -in /etc/kubernetes/pki/apiserver-etcd-client.csr -CA /etc/kubernetes/pki/etcd/ca.crt -CAkey /etc/kubernetes/pki/etcd/ca.key -CAcreateserial -out /etc/kubernetes/pki/apiserver-etcd-client.crt
Signature ok
subject=/CN=kube-apiserver-etcd-client/O=system:masters
Getting CA Private Key
master $

master $ openssl  x509 -in apiserver-etcd-client.crt -text -nooutCertificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 9618657781232981782 (0x857c564a4a705716)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=etcd-ca
        Validity
            Not Before: May 24 02:53:47 2020 GMT
            Not After : Jun 23 02:53:47 2020 GMT
        Subject: CN=kube-apiserver-etcd-client, O=system:masters
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:da:b0:85:31:73:09:94:65:20:33:71:74:96:d1:
                    0d:da:08:24:56:93:b2:21:76:ca:b1:2e:04:43:4b:
                    f3:95:d9:1a:3e:8e:6b:44:48:8b:93:19:0d:b0:51:
                    23:19:33:ee:0a:56:9f:9f:bd:4b:21:e3:8d:78:5c:
                    25:74:a9:8d:58:20:14:fb:b9:75:98:a5:a4:7c:e9:
                    8a:53:6e:ad:2b:d1:6c:e0:4e:bc:b7:46:60:6d:cd:
                    e9:8c:9d:c5:14:a8:8c:6c:fc:08:5c:86:a9:df:ef:
                    0c:12:a8:10:00:90:ee:d4:0e:4e:e9:87:83:d5:d8:
                    1e:4c:d5:92:6e:00:75:df:1f:6b:ab:c6:a4:27:78:
                    78:88:d4:53:17:ec:dd:91:b4:c6:64:ff:20:43:33:
                    a7:ce:c8:7d:06:6e:ee:d1:5d:3a:da:0c:95:a2:1a:
                    1a:af:99:b2:d4:4d:5b:47:41:67:1d:7b:65:c9:c4:
                    f2:0f:b3:70:1d:f1:5a:4e:91:30:6e:8b:67:26:92:
                    90:2e:53:a6:e8:0d:41:e1:41:b4:98:36:bb:8d:2f:
                    05:19:09:b9:d8:a3:41:33:0e:a8:ac:e1:83:25:df:
                    e3:b4:e2:7c:31:9e:58:32:35:cc:f9:9f:e6:a6:71:
                    13:7a:fe:85:57:73:ce:ff:28:37:5a:11:a3:4e:dd:
                    3f:33
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha256WithRSAEncryption
         0a:8d:ed:42:5a:16:e4:52:20:7d:bd:b2:d5:3d:2f:80:9c:2a:
         1e:ae:67:62:4f:21:17:10:03:72:02:e2:56:7e:f3:da:ed:3b:
         ab:7b:9d:58:b9:1b:f2:ed:d2:83:a0:a5:74:e0:a1:6c:5f:ba:
         d3:d6:13:ed:f5:ac:10:08:93:4d:e3:12:44:2b:7e:8e:d6:60:
         f9:14:eb:c1:d2:db:b4:53:c0:6d:fc:cb:a3:5f:7e:b8:a2:82:
         21:dd:f5:17:4d:7f:1f:4e:8b:e9:20:b0:6c:bd:fd:42:ad:f0:
         e4:16:2d:66:ae:f6:a0:f4:97:29:5c:f3:8d:80:0e:3c:77:50:
         9f:75:f2:db:74:35:fc:f1:4a:97:e3:34:61:41:29:ae:98:34:
         58:60:72:cc:08:33:12:27:23:82:13:01:b6:e0:ad:21:3d:aa:
         2a:ed:17:6b:9a:65:e9:25:75:5a:1c:74:d5:94:2c:2d:27:eb:
         c2:be:16:c2:5f:dc:ff:95:c9:2e:35:03:b0:6f:8b:11:43:f5:
         c5:18:43:78:1c:2b:9c:8f:56:67:61:08:f1:da:6b:73:52:8f:
         9a:c1:c8:f5:b4:cf:ce:8e:84:db:1c:8c:54:6b:d3:a0:51:0b:
         59:92:0f:be:69:9a:cf:bb:bf:80:97:0a:be:07:31:3b:7d:6b:
         73:6b:34:6e
master $

------------------------------------------------------------------------------------------------------------------------------------------->
master $ pwd
/etc/kubernetes/pki
master $

master $ openssl x509 -req -in apiserver-etcd-client.csr -CA etcd/ca.crt -CAkey etcd/ca.key  -CAcreateserial -out apiserver-etcd-client.crt
Signature ok
subject=/CN=kube-apiserver-etcd-client/O=system:masters
Getting CA Private Key
master $


master $ openssl x509 -in apiserver-etcd-client.crt -text -noout
Certificate:
    Data:
        Version: 1 (0x0)
        Serial Number: 17143088329821199406 (0xede87c020c231c2e)
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: CN=etcd-ca
        Validity
            Not Before: May 24 03:15:35 2020 GMT
            Not After : Jun 23 03:15:35 2020 GMT
        Subject: CN=kube-apiserver-etcd-client, O=system:masters
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:dc:71:9c:5f:8a:b3:d9:b9:a5:17:f6:73:e7:cc:
                    ce:a4:1a:c7:05:5d:1c:2f:67:53:f6:c9:9a:fb:0a:
                    75:d3:2e:53:4d:ff:d6:9c:17:2a:b5:e1:37:42:3d:
                    42:1f:8a:b9:54:bf:a6:4b:93:37:da:9f:15:de:c1:
                    63:89:be:cf:70:88:41:59:7d:51:fa:11:27:6d:4c:
                    c3:6d:c2:a2:7f:d5:8a:85:c7:92:0b:aa:36:57:8b:
                    b2:9b:be:67:9c:d7:67:25:ba:c5:e3:27:b7:72:b4:
                    ee:65:0b:36:3e:26:79:4e:49:43:c6:19:9b:49:af:
                    dc:db:2d:ad:ed:ef:a1:2b:82:ec:be:5f:c1:78:6f:
                    06:e9:63:08:54:48:eb:db:e6:bd:a0:1d:90:c1:7d:
                    3e:19:41:92:5a:95:95:cb:4d:75:a5:cd:7e:e8:65:
                    db:33:96:e2:22:73:a6:b1:9c:82:20:d5:6a:ad:df:
                    32:5d:1e:c0:19:a5:19:67:14:17:52:6f:3a:42:60:
                    83:57:3d:c3:44:65:52:5d:b6:8f:58:60:c9:50:d4:
                    6f:7b:16:3c:10:35:a1:6f:99:77:2a:11:a5:86:9c:
                    39:f0:7a:86:91:23:a1:64:a5:29:fd:de:35:0c:19:
                    ae:7f:eb:43:7d:e0:e7:24:ad:76:27:da:fc:aa:f3:
                    c5:6d
                Exponent: 65537 (0x10001)
    Signature Algorithm: sha256WithRSAEncryption
         0a:98:bf:91:d9:0b:69:58:e0:56:39:69:da:37:c4:bd:78:8f:
         c1:4a:0a:dd:78:dc:9c:dc:2f:e7:81:62:13:03:4a:d8:8f:71:
         18:46:7f:91:4c:7b:2b:48:09:05:e4:22:ca:c8:a4:06:e1:1b:
         a0:23:66:d4:74:5d:ee:d1:9d:be:ba:cc:ae:52:5d:95:01:ad:
         03:3d:ad:f5:82:cc:38:a3:01:73:f5:8b:fa:4d:f3:13:11:d1:
         29:f0:24:c5:68:2d:f5:94:1b:5c:05:14:6f:f0:6c:4e:f8:a7:
         93:64:fa:a2:ae:ea:81:9a:52:40:bf:d3:4a:b0:60:12:9f:ae:
         9b:39:db:88:b2:ed:86:81:19:3e:ef:06:58:36:c7:1d:a5:fe:
         57:5b:e6:ac:43:c4:fb:18:26:13:34:da:6f:32:f6:af:f5:ef:
         c1:0b:1c:87:45:00:bc:62:1e:57:d4:01:84:32:03:8a:33:79:
         60:f1:5b:9f:77:76:a7:07:79:5b:1f:74:8a:2a:5f:a3:9d:21:
         e7:27:d4:5f:78:f6:87:7b:65:3d:68:a4:73:ab:65:e7:e8:26:
         f3:98:99:71:b5:b9:0a:f2:3e:b9:26:d6:fe:7a:19:bb:42:c3:
         06:62:19:5d:b1:92:72:a5:2b:b1:de:1b:bb:e3:11:e0:f2:56:
         ca:2b:ed:bb
master $





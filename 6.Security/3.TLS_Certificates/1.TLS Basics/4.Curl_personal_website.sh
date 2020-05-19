bharath@bharath ~]$ curl -vvvvvv "https://bharathkumaraju.com"
* Trying 13.35.19.121...
* TCP_NODELAY set
* Connected to bharathkumaraju.com (13.35.19.121) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/cert.pem
  CApath: none
* TLSv1.2 (OUT), TLS handshake, Client hello (1):
* TLSv1.2 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS change cipher, Change cipher spec (1):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256
* ALPN, server accepted to use h2
* Server certificate:
* subject: CN=bharathkumaraju.com
* start date: Nov 25 00:00:00 2019 GMT
* expire date: Dec 25 12:00:00 2020 GMT
* subjectAltName: host "bharathkumaraju.com" matched cert's "bharathkumaraju.com"
* issuer: C=US; O=Amazon; OU=Server CA 1B; CN=Amazon
* SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x7fa9b1008200)
> GET / HTTP/2
> Host: bharathkumaraju.com
> User-Agent: curl/7.64.1
> Accept: */*
>
* Connection state changed (MAX_CONCURRENT_STREAMS == 128)!
< HTTP/2 200
< content-type: text/html
< content-length: 26482
< date: Sat, 16 May 2020 11:48:38 GMT
< last-modified: Mon, 23 Mar 2020 15:44:47 GMT
< etag: "eca67e27131dc3ce9965c2d7af6f852e"
< server: AmazonS3
< x-cache: Hit from cloudfront
< via: 1.1 6744df903aaebd8a225f5410dbe17efd.cloudfront.net (CloudFront)
< x-amz-cf-pop: SIN5-C1
< x-amz-cf-id: ltAr7Gus3JYZZK1inAYAF5xupRVDUXYoajlR0gAJRWAssLdD2TEGIw==
< age: 47871

<DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width,initial-scale=1" />
	<meta name="robots" content="index, follow"/>
    <meta name="google-site-verification"
             content=<meta name="google-site-verification" content="-k3RXuatyOrguCScKS9C3XuXOMnAiCG2MhFXBEpMKeM" />
	<title>Bharathkumar Raju's Official Website</title>
	<link rel="shortcut icon" href="logo-website.png"> </link>
</head>
</html>

* Connection #0 to host bharathkumaraju.com left intact
[bharath@bharath ~]$
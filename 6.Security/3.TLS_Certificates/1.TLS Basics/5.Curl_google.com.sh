bharathdasaraju@MacBook-Pro ~ $ curl -vvvvvv "https://google.com"
*   Trying 74.125.200.100...
* TCP_NODELAY set
* Connected to google.com (74.125.200.100) port 443 (#0)
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
* SSL connection using TLSv1.2 / ECDHE-ECDSA-CHACHA20-POLY1305
* ALPN, server accepted to use h2
* Server certificate:
*  subject: C=US; ST=California; L=Mountain View; O=Google LLC; CN=*.google.com
*  start date: Apr 28 07:43:41 2020 GMT
*  expire date: Jul 21 07:43:41 2020 GMT
*  subjectAltName: host "google.com" matched cert's "google.com"
*  issuer: C=US; O=Google Trust Services; CN=GTS CA 1O1
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x7ff614808200)
> GET / HTTP/2
> Host: google.com
> User-Agent: curl/7.64.1
> Accept: */*
>
* Connection state changed (MAX_CONCURRENT_STREAMS == 100)!
< HTTP/2 301
< location: https://www.google.com/
< content-type: text/html; charset=UTF-8
< date: Sun, 17 May 2020 01:08:43 GMT
< expires: Tue, 16 Jun 2020 01:08:43 GMT
< cache-control: public, max-age=2592000
< server: gws
< content-length: 220
< x-xss-protection: 0
< x-frame-options: SAMEORIGIN
< alt-svc: h3-27=":443"; ma=2592000,h3-25=":443"; ma=2592000,h3-T050=":443"; ma=2592000,h3-Q050=":443"; ma=2592000,h3-Q049=":443"; ma=2592000,h3-Q048=":443"; ma=2592000,h3-Q046=":443"; ma=2592000,h3-Q043=":443"; ma=2592000,quic=":443"; ma=2592000; v="46,43"
<
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="https://www.google.com/">here</A>.
</BODY></HTML>
* Connection #0 to host google.com left intact
* Closing connection 0
bharathdasaraju@MacBook-Pro ~ $
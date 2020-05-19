PRIVATE KEY:
------------------------------------------------------------------------------>

bharathdasaraju@MacBook-Pro TLSCERTS $ openssl genrsa -out my-bank.key 1024
Generating RSA private key, 1024 bit long modulus
........++++++
.................++++++
e is 65537 (0x10001)
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -lrth
total 8
-rw-r--r--  1 bharathdasaraju  staff   887B May 17 08:22 my-bank.key
bharathdasaraju@MacBook-Pro TLSCERTS $ vim my-bank.key
bharathdasaraju@MacBook-Pro TLSCERTS $ cat my-bank.key
-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQDEK6XlSpNaKaW2AtCIGBQheSV/AbvJVrNnGpXgaSSluid8QwHC
psdRz9WOzjC9gZzIsyusOnllNykNG+nqPgghopnXKL0fhW8vFkoumL8AWi4+F5XB
bRFAIufUHiG196w5WNCB4arngFQaLxCZWv2nOWpA0fdzlKADoIlbRmmfUQIDAQAB
AoGABb59chRX8jjr+ENm1cVWuZAxj+F+HSwjvq4hm1uYzh2AUHwpzghSJ8wdJbxV
4warj5jne3iO227dDdw2YjyEwmIoMjPGA5RRrE9EiAtt116HkRJMt028c0Lz6Qg6
tujZDzumV5yO48YuKkNzxq5zStMl3G8qbNlhUBSKEOyA2V0CQQD8RL+DLNP4R6y8
tEZDPEQ4wzxYBCrEBqUT42S4ZCRzWCZ6dioILAUo/Ne2Rd5OxLTfZ2ZI3dnVz8In
Fzn4zECfAkEAxxJ59/pNpDMIBwfKuU+rI4+cx7wQQ2vbThgMIInKI1lD/+THya/u
mtnNQwZ6LwtJRYJPIEOe1zRhPnZWUlBqDwJAZAfStO4ao1Gwgict0U1dc/Cexfvp
BU/pN2issJ0tAvvKTjb61cC2zxjrZGByFWPUoN18Zppp3WmDgEKqfyhm2wJBAI+E
sook2nTWlaL76xtOZINutgkJfHAfAix7CcMrk5+Ia43A0oiFXfAlteXsdYoVCO4j
1AfeuFVOXg06I2GUt+ECQEvRZN15vcmos7fu8YtHOnMHJF/diRagP6dV7FXZHYwk
THVt+Awm3YqDYnWkdcHXeu9/ZBJsHFClYBzWjTi+bzE=
-----END RSA PRIVATE KEY-----
bharathdasaraju@MacBook-Pro TLSCERTS $

PUBLIC KEY:
---------------------------------------------------------------------------------------->
bharathdasaraju@MacBook-Pro TLSCERTS $ openssl rsa -in my-bank.key -pubout > my-bank.pem
writing RSA key
bharathdasaraju@MacBook-Pro TLSCERTS $ ls -lrth
total 16
-rw-r--r--  1 bharathdasaraju  staff   887B May 17 08:22 my-bank.key
-rw-r--r--  1 bharathdasaraju  staff   272B May 17 08:27 my-bank.pem
bharathdasaraju@MacBook-Pro TLSCERTS $ cat my-bank.pem
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDEK6XlSpNaKaW2AtCIGBQheSV/
AbvJVrNnGpXgaSSluid8QwHCpsdRz9WOzjC9gZzIsyusOnllNykNG+nqPgghopnX
KL0fhW8vFkoumL8AWi4+F5XBbRFAIufUHiG196w5WNCB4arngFQaLxCZWv2nOWpA
0fdzlKADoIlbRmmfUQIDAQAB
-----END PUBLIC KEY-----
bharathdasaraju@MacBook-Pro TLSCERTS $



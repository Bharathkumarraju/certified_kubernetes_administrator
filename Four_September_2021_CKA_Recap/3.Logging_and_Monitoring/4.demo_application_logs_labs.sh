root@controlplane:~# kubectl logs -f webapp-2 simple-webapp 
[2021-09-20 03:23:24,120] INFO in event-simulator: USER2 is viewing page2
[2021-09-20 03:23:25,122] INFO in event-simulator: USER3 is viewing page2
[2021-09-20 03:23:26,124] INFO in event-simulator: USER2 is viewing page3
[2021-09-20 03:23:27,124] INFO in event-simulator: USER2 is viewing page1
[2021-09-20 03:23:28,126] INFO in event-simulator: USER2 is viewing page2
[2021-09-20 03:23:29,127] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:23:29,128] INFO in event-simulator: USER3 logged in
[2021-09-20 03:23:30,128] INFO in event-simulator: USER3 is viewing page3
[2021-09-20 03:23:31,130] INFO in event-simulator: USER2 is viewing page3
[2021-09-20 03:23:32,132] WARNING in event-simulator: USER30 Order failed as the item is OUT OF STOCK.
[2021-09-20 03:23:32,132] INFO in event-simulator: USER4 is viewing page3
[2021-09-20 03:23:33,133] INFO in event-simulator: USER3 is viewing page1
[2021-09-20 03:23:34,134] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:23:34,134] INFO in event-simulator: USER1 is viewing page2
[2021-09-20 03:23:35,135] INFO in event-simulator: USER3 is viewing page3
[2021-09-20 03:23:36,136] INFO in event-simulator: USER4 is viewing page3
[2021-09-20 03:23:37,138] INFO in event-simulator: USER3 is viewing page3
[2021-09-20 03:23:38,139] INFO in event-simulator: USER4 is viewing page2
[2021-09-20 03:23:39,141] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:23:39,141] INFO in event-simulator: USER3 is viewing page1
[2021-09-20 03:23:40,142] WARNING in event-simulator: USER30 Order failed as the item is OUT OF STOCK.
[2021-09-20 03:23:40,142] INFO in event-simulator: USER2 logged out
[2021-09-20 03:23:41,144] INFO in event-simulator: USER3 logged out
[2021-09-20 03:23:42,145] INFO in event-simulator: USER4 logged out
[2021-09-20 03:23:43,147] INFO in event-simulator: USER4 logged out
[2021-09-20 03:23:44,149] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:23:44,149] INFO in event-simulator: USER2 logged in
[2021-09-20 03:23:45,151] INFO in event-simulator: USER1 is viewing page2
[2021-09-20 03:23:46,152] INFO in event-simulator: USER2 is viewing page3
[2021-09-20 03:23:47,154] INFO in event-simulator: USER4 is viewing page3
[2021-09-20 03:23:48,156] WARNING in event-simulator: USER30 Order failed as the item is OUT OF STOCK.
[2021-09-20 03:23:48,156] INFO in event-simulator: USER2 is viewing page2
[2021-09-20 03:23:49,156] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:23:49,157] INFO in event-simulator: USER4 logged in
[2021-09-20 03:23:50,158] INFO in event-simulator: USER1 logged in
[2021-09-20 03:23:51,160] INFO in event-simulator: USER2 is viewing page3
[2021-09-20 03:23:52,161] INFO in event-simulator: USER4 logged out
[2021-09-20 03:23:53,161] INFO in event-simulator: USER4 logged in
[2021-09-20 03:23:54,162] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:23:54,163] INFO in event-simulator: USER4 logged out
[2021-09-20 03:23:55,165] INFO in event-simulator: USER3 is viewing page3
[2021-09-20 03:23:56,184] WARNING in event-simulator: USER30 Order failed as the item is OUT OF STOCK.
[2021-09-20 03:23:56,185] INFO in event-simulator: USER2 is viewing page2
[2021-09-20 03:23:57,186] INFO in event-simulator: USER1 logged in
[2021-09-20 03:23:58,188] INFO in event-simulator: USER2 is viewing page2
[2021-09-20 03:23:59,189] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:23:59,190] INFO in event-simulator: USER2 is viewing page2
[2021-09-20 03:24:00,192] INFO in event-simulator: USER1 logged out
[2021-09-20 03:24:01,193] INFO in event-simulator: USER2 logged in
[2021-09-20 03:24:02,194] INFO in event-simulator: USER1 logged out
[2021-09-20 03:24:03,196] INFO in event-simulator: USER1 is viewing page3
[2021-09-20 03:24:04,197] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:24:04,198] WARNING in event-simulator: USER30 Order failed as the item is OUT OF STOCK.
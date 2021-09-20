bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % docker run kodekloud/event-simulator
Unable to find image 'kodekloud/event-simulator:latest' locally
latest: Pulling from kodekloud/event-simulator
4fe2ade4980c: Pull complete 
7cf6a1d62200: Pull complete 
cd7a503c982e: Pull complete 
Digest: sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9
Status: Downloaded newer image for kodekloud/event-simulator:latest
[2021-09-20 03:03:40,440] INFO in event-simulator: USER2 logged out
[2021-09-20 03:03:41,441] INFO in event-simulator: USER1 is viewing page2
[2021-09-20 03:03:42,442] INFO in event-simulator: USER4 is viewing page3
[2021-09-20 03:03:54,460] INFO in event-simulator: USER2 is viewing page1
[2021-09-20 03:03:55,462] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:04:03,445] INFO in event-simulator: USER2 logged in
[2021-09-20 03:04:04,446] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2021-09-20 03:04:04,448] INFO in event-simulator: USER4 is viewing page1
[2021-09-20 03:04:05,449] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:04:05,449] INFO in event-simulator: USER3 is viewing page1
^CTraceback (most recent call last):
  File "event-simulator.py", line 54, in <module>
    time.sleep(1)
KeyboardInterrupt
bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring %


bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % docker run -d kodekloud/event-simulator
8fa3501504271d3a8fc28debbff4d569ae09772fdc2565fa56aee770220b687e
bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % docker logs -f 8fa
[2021-09-20 03:06:53,275] INFO in event-simulator: USER1 logged out
[2021-09-20 03:06:54,277] INFO in event-simulator: USER2 logged in
[2021-09-20 03:06:55,278] INFO in event-simulator: USER2 logged out
[2021-09-20 03:06:56,280] INFO in event-simulator: USER3 logged in
[2021-09-20 03:06:57,282] INFO in event-simulator: USER4 is viewing page3
[2021-09-20 03:06:58,249] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:06:58,250] INFO in event-simulator: USER3 is viewing page3
[2021-09-20 03:06:59,251] INFO in event-simulator: USER4 is viewing page2
[2021-09-20 03:07:00,254] INFO in event-simulator: USER3 is viewing page1
[2021-09-20 03:07:01,255] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2021-09-20 03:07:01,256] INFO in event-simulator: USER1 is viewing page2
[2021-09-20 03:07:02,257] INFO in event-simulator: USER2 is viewing page2
[2021-09-20 03:07:03,259] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:07:03,261] INFO in event-simulator: USER3 logged in
[2021-09-20 03:07:04,263] INFO in event-simulator: USER3 logged in
[2021-09-20 03:07:05,265] INFO in event-simulator: USER4 is viewing page2
[2021-09-20 03:07:06,267] INFO in event-simulator: USER1 is viewing page2
[2021-09-20 03:07:07,271] INFO in event-simulator: USER3 is viewing page2
^C%                                                                                                                                                                                                                                      
bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % 



bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % kubectl run logs-events --image=kodekloud/event-simulator --dry-run=client -o yaml > event-simulator.yaml  
bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % kubectl create -f event-simulator.yaml 
pod/logs-events created
bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % 

bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % kubectl logs logs-events -f
[2021-09-20 03:18:31,489] INFO in event-simulator: USER3 logged out
[2021-09-20 03:18:32,493] INFO in event-simulator: USER1 is viewing page1
[2021-09-20 03:18:33,494] INFO in event-simulator: USER1 is viewing page1
[2021-09-20 03:18:34,495] INFO in event-simulator: USER2 is viewing page1
[2021-09-20 03:18:35,495] INFO in event-simulator: USER3 logged out
[2021-09-20 03:18:36,497] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:18:36,497] INFO in event-simulator: USER1 is viewing page2
[2021-09-20 03:18:37,499] INFO in event-simulator: USER4 is viewing page3
[2021-09-20 03:18:38,500] INFO in event-simulator: USER4 is viewing page3
[2021-09-20 03:18:39,501] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2021-09-20 03:18:39,501] INFO in event-simulator: USER2 is viewing page2
[2021-09-20 03:18:40,502] INFO in event-simulator: USER1 logged in
[2021-09-20 03:18:41,502] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2021-09-20 03:18:41,503] INFO in event-simulator: USER4 is viewing page2
[2021-09-20 03:18:42,503] INFO in event-simulator: USER4 is viewing page3
^C
bharathdasaraju@MacBook-Pro 3.Logging_and_Monitoring % 
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
Docker:
-------->
Logging in docker..

1. Lets run docker container as --> docker run kodekloud/event-simulator
so the events streamed to the standard output by the application by default.

bharathdasaraju@MacBook-Pro ~ $ docker run kodekloud/event-simulator
Unable to find image 'kodekloud/event-simulator:latest' locally
latest: Pulling from kodekloud/event-simulator
4fe2ade4980c: Pull complete
663782b72351: Pull complete
cd7a503c982e: Pull complete
Digest: sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9
Status: Downloaded newer image for kodekloud/event-simulator:latest
[2020-05-07 04:00:02,755] INFO in event-simulator: USER1 is viewing page1
[2020-05-07 04:00:03,758] INFO in event-simulator: USER3 logged in
[2020-05-07 04:00:04,760] INFO in event-simulator: USER4 is viewing page2
[2020-05-07 04:00:05,762] INFO in event-simulator: USER1 logged out
[2020-05-07 04:00:06,765] INFO in event-simulator: USER1 logged in
[2020-05-07 04:00:07,768] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2020-05-07 04:00:07,768] INFO in event-simulator: USER3 is viewing page1
[2020-05-07 04:00:08,775] INFO in event-simulator: USER2 is viewing page1

So, if we run the docker container in the background, in a detached mode using the -d option
2. docker run on detached mode --> docker run -d kodekloud/event-simulator
bharathdasaraju@MacBook-Pro ~ $ docker run -d kodekloud/event-simulator
929ee763c5ace786cf6176130356c0b8773d2f361f40ca641225311cd4e9f7c1
bharathdasaraju@MacBook-Pro ~ $
in order to view the logs
------------------------------>
bharathdasaraju@MacBook-Pro ~ $ docker logs -f 929ee763c5ac
[2020-05-07 04:03:16,846] INFO in event-simulator: USER3 logged out
[2020-05-07 04:03:17,852] INFO in event-simulator: USER3 is viewing page2
[2020-05-07 04:03:18,854] INFO in event-simulator: USER2 is viewing page1
[2020-05-07 04:03:19,857] INFO in event-simulator: USER1 logged in
[2020-05-07 04:03:20,861] INFO in event-simulator: USER1 is viewing page2
[2020-05-07 04:03:21,864] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2020-05-07 04:03:21,864] INFO in event-simulator: USER1 is viewing page1

kubernetes:
----------->

bharathdasaraju@MacBook-Pro (master) $ kubectl apply -f event-simulator.yaml
pod/event-simulator-pod created
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ kubectl logs -f event-simulator-pod
Error from server (BadRequest): a container name must be specified for pod event-simulator-pod, choose one of: [event-simulator nginx]
bharathdasaraju@MacBook-Pro (master) $


bharathdasaraju@MacBook-Pro (master) $ kubectl logs -f event-simulator-pod event-simulator
[2020-05-07 04:07:58,664] INFO in event-simulator: USER3 logged out
[2020-05-07 04:07:59,669] INFO in event-simulator: USER2 is viewing page2
[2020-05-07 04:08:00,671] INFO in event-simulator: USER2 is viewing page2
[2020-05-07 04:08:01,673] INFO in event-simulator: USER2 logged out
[2020-05-07 04:08:02,674] INFO in event-simulator: USER4 is viewing page2
[2020-05-07 04:08:03,676] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2020-05-07 04:08:03,677] INFO in event-simulator: USER3 is viewing page1
[2020-05-07 04:08:04,680] INFO in event-simulator: USER2 logged in
[2020-05-07 04:08:05,681] INFO in event-simulator: USER1 is viewing page1
bharathdasaraju@MacBook-Pro (master) $

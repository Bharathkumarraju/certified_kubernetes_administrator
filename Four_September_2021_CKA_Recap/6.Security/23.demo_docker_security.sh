
MacBook-Pro:6.Security bharathdasaraju$ docker run ubuntu sleep 100



MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ docker ps | grep -i ubuntu
909d1fe5ebab        ubuntu                                "sleep 100"              40 seconds ago      Up 39 seconds                                                                                                                                              inspiring_dijkstra
MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ 

Inside docker container:
---------------------------->
MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ docker exec -it a0d647aee08e sh
# ps
    PID TTY          TIME CMD
      6 pts/0    00:00:00 sh
     11 pts/0    00:00:00 ps
# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.1  0.0   2508   516 ?        Ss   23:55   0:00 sleep 100
root           6  0.5  0.0   2608   604 pts/0    Ss   23:56   0:00 sh
root          12  0.0  0.1   5896  2776 pts/0    R+   23:56   0:00 ps aux
# 

In the host:
------------------------------------------------------------------------------------------------------------------------------->
MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ ps aux | grep -i sleep
bharathdasaraju  13768   0.0  0.0  4268408    688 s003  R+    7:13am   0:00.00 grep -i sleep
bharathdasaraju  13711   0.0  0.1  4436660  21436 s002  S+    7:12am   0:00.06 /usr/local/bin/com.docker.cli run ubuntu sleep 100
bharathdasaraju  13708   0.0  0.1  5038428  15224 s002  S+    7:12am   0:00.04 docker run ubuntu sleep 100
MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ 


by default docker runs processes with-in the container as a root user.

if we dont want to run the processees as root user with-in the contaier we can set the  "--user=user_id" while running the docker run

MacBook-Pro:6.Security bharathdasaraju$ docker run --user=1000 ubuntu sleep 100

MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ docker exec -it a0a3ea054709 sh 
$ ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
1000           1  0.0  0.0   2508   580 ?        Ss   00:01   0:00 sleep 100
1000           6  0.3  0.0   2608   596 pts/0    Ss   00:02   0:00 sh
1000          12  0.0  0.1   5896  2836 pts/0    R+   00:02   0:00 ps aux
$ 


We can also set this in Dockerfile:

Dockerfile:
----------------->
FROM ubuntu

USER 1000



Linux Capabilities:
------------------------->
/usr/include/linux/capability.sh

docker run --cap-add MAC_ADMIN ubuntu
docker run --cap-drop KILL ubuntu

docker run --privileged ubuntu





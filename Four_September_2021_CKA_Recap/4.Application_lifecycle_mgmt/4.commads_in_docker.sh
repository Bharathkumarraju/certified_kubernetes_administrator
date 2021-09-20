MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker run ubuntu
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
37797d16b7bf        ubuntu              "bash"              14 seconds ago      Exited (0) 13 seconds ago                       amazing_sinoussi
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker run ubuntu sleep 100
...
...
...

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
d7cf7e1b851a        ubuntu              "sleep 100"         27 seconds ago      Up 26 seconds                           zen_poincare
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 


MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker build -t ubuntu-sleeper .
Sending build context to Docker daemon  14.34kB
Step 1/2 : FROM ubuntu
 ---> 1318b700e415
Step 2/2 : CMD ["sleep", "10"]
 ---> Running in fb7ee02bbaee
Removing intermediate container fb7ee02bbaee
 ---> a1b5b5b1a7f0
Successfully built a1b5b5b1a7f0
Successfully tagged ubuntu-sleeper:latest
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 


MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker run ubuntu-sleeper
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
f617feb39df1        ubuntu-sleeper      "sleep 10"          6 seconds ago       Up 6 seconds                            naughty_cannon
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 


for CMD --> Command line parameters gets replaced entirely.
for ENTRYPOINT --> Command line parameters gets appended.



MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker build -t docker-sleeper-entry .
Sending build context to Docker daemon  15.36kB
Step 1/2 : FROM ubuntu
 ---> 1318b700e415
Step 2/2 : ENTRYPOINT [ "sleep" ]
 ---> Running in 4f01af5f85d2
Removing intermediate container 4f01af5f85d2
 ---> a0374708bc2d
Successfully built a0374708bc2d
Successfully tagged docker-sleeper-entry:latest
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker run docker-sleeper-entry 30

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker ps
CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS              PORTS               NAMES
8bf99af8cc28        docker-sleeper-entry   "sleep 30"          5 seconds ago       Up 4 seconds                            practical_keller
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 


MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker run ubuntu-sleeper-entry-cmd
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 

MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ docker ps
CONTAINER ID        IMAGE                      COMMAND             CREATED             STATUS              PORTS               NAMES
4ca3f97c129a        ubuntu-sleeper-entry-cmd   "sleep 5"           4 seconds ago       Up 4 seconds                            determined_bose
MacBook-Pro:4.Application_lifecycle_mgmt bharathdasaraju$ 







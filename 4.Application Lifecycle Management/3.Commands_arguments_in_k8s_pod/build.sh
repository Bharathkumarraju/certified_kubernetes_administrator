$ docker build -t ubuntu-sleeper .

bharathdasaraju@MacBook-Pro (master) $ docker run -d ubuntu-sleeper
8d413efd1ef7d64e183c618c2b26475198d109c69f56390a75a64032f4905433
bharathdasaraju@MacBook-Pro (master) $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
8d413efd1ef7        ubuntu-sleeper      "sleep 10"          3 seconds ago       Up 2 seconds                            serene_chatterjee
bharathdasaraju@MacBook-Pro (master) $

bharathdasaraju@MacBook-Pro (master) $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
8d413efd1ef7        ubuntu-sleeper      "sleep 10"          9 seconds ago       Up 8 seconds                            serene_chatterjee
bharathdasaraju@MacBook-Pro (master) $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
bharathdasaraju@MacBook-Pro (master) $

=============================================================================================================>

bharathdasaraju@MacBook-Pro (master) $ docker run -d ubuntu-sleeper 20
a2fdb08aed75cf904957a90644ae83bb581237010747a5962e74a1ebc0ed67f4
bharathdasaraju@MacBook-Pro (master) $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
a2fdb08aed75        ubuntu-sleeper      "sleep 20"          8 seconds ago       Up 7 seconds                            nice_mcclintock

bharathdasaraju@MacBook-Pro (master) $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
a2fdb08aed75        ubuntu-sleeper      "sleep 20"          19 seconds ago      Up 18 seconds                           nice_mcclintock
bharathdasaraju@MacBook-Pro (master) $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
a2fdb08aed75        ubuntu-sleeper      "sleep 20"          20 seconds ago      Up 19 seconds                           nice_mcclintock
bharathdasaraju@MacBook-Pro (master) $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
bharathdasaraju@MacBook-Pro (master) $

=======================================================================================================================>

How to use this image inside kubernetes pod defintion file ..as for this image we pass seconds as argument in "docker run"

i.e.


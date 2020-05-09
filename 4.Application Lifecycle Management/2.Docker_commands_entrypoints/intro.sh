when you run
1. $ docker run  ubuntu
it runs an instance of ubutu image and exits immediately.
If we list the running contianers, we would not see the container running.
bharathdasaraju@MacBook-Pro ~ $ docker run ubuntu
bharathdasaraju@MacBook-Pro ~ $

bharathdasaraju@MacBook-Pro ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
bharathdasaraju@MacBook-Pro ~ $

If we list all containers including those that are stopped we will see that the new container
we ran is in an Exited state.

bharathdasaraju@MacBook-Pro ~ $ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
4a970b265a36        ubuntu              "/bin/bash"         4 seconds ago       Exited (0) 3 seconds ago                       hungry_snyder
bharathdasaraju@MacBook-Pro ~ $

Why container got Exited:
----------------------------->
Unlike virtual machines containers are not meant to host an operating system.
Containers are meant to run a specific task or process such as
1. host an instance of a web server or
2. a application server or
3. a database server  or
4. simply to carry out some kind of computation or analysis
once the task is complete the container Exits.
A container only lives as long as the process inside is alive.

If the web service inside the container is stopped or crashes the container exits.

So who defines what process is run with in the container
If we look at the Dockerfile for popular dockerimages
Dockerfile_link: https://github.com/nginxinc/docker-nginx/blob/master/mainline/buster/Dockerfile

CMD that defines the process which runs when the container starts.
CMD ["nginx"] --> For the NGINX image it is the nginx command that runs the nginx process.
CMD ["mysqld"] --> For the MYSQL image it is the mysqld command that runs thd mysql process.


What we tried to do earlier was to run a container with a plain ubntu operating system.

$ docker run ubuntu sleep 180

bharathdasaraju@MacBook-Pro ~ $ docker run -d ubuntu sleep 180
697cc5951a3b83055aaab64b1ac7c571208df7580a522d46b5bcd5bdc8e42b87
bharathdasaraju@MacBook-Pro ~ $ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
697cc5951a3b        ubuntu              "sleep 180"         3 seconds ago       Up 3 seconds                            elegant_newton
bharathdasaraju@MacBook-Pro ~ $


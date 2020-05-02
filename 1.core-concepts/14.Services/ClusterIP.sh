A full stack web application typically has differnt kinds of pods hosting different parts of application.

1. front-end  --> many pods running as frontend web server

2. backe-end --> another set of pods running as backend server

3. redis --> another a set of pods running a key-value store like Redis

4. Databse --> and anotehr set of pods running as persistent database like MySQL

The web front-end servers needs to communicate to the back-end servers and
backe-end servers needs to communicate to the database as well as redis services etc...

So what is the right way yo establish connectivity between these tiers of web application...

To achieve this we use CluserIP...
how if the frontend-pod needs to talk to backend-pod,
we group all backend servers  as one give and one ClusterIP and this will randomly forward requests to the each backend pod

how if the backend-pod needs to talk to database-pod,
we group all database servers as one and give one ClusterIP and this will randomly forward requests to the each database pod





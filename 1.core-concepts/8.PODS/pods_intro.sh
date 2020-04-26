pods is a smallest entity in the kubernetes...

If single container in pod is not sufficient to serve number of incoming connections we will autoscale the pod always.

we use horizontalpodautoscalers to launch another pods...if new pods also not sufficient to serve incoming connections..
we launch new nodes and autoscale the pods.

A pod usually had one-to-one relationship with the container

Multi-container pods:
----------------------->
A single pod can have multiple containers except for the fact that there is usually not multiple containers of the same Kind.

sometimes you might have a scenario were you have a helper container that might be doing some kind
of supporting task for our web application, such as processing a user entered data, processing a file uploaded
by the user etc. and you want these helper containers to live alongside your application container.

In that case you can have both of these containers part of the same pod so that, when a new application container is created
the helper container also created, when application container dies the helper also dies.sicne the application container and helper container
are part of the same POD.

The two containers can also communicate with each other directly by referring to each others as 'localhost' since they
share the same network namespace, plus they can share the same storage space as well.


Understand Pods again:
----------------------------->

we could take another shot at understanding PODs from a different angle.
Lets, for a moment, keep kubernetes out of our discussion and talk about simple docker containers.

Lets assume we were developing a process or a script to deploy our application on a docker host.
Then we would first simply deploy our application using a simple docker run python-app command
1. docker run python-app app1
2. docker run python-app app2
3. docker run python-app app3
4. docker run python-app app4

and the application runs fine and our users are able to access it.

When the load increases,we deploy more instances of our application
by running the docker run commands many more times.This works fine and we are all happy.

Now sometime in the future our application is further developed undergoes architectural changes and grows and gets complex.
We now have a new helper container that helps our web application by processing or fetcing data from elsewhere.

These helper containers maintain a one-to-one relationship with our application container and thus,
needs to communicate the application containers directly and access data from those containers.

For this we need to maintain a map of what app and help our containers are connected to each other.
1. docker run helper --link app1
2. docker run helper --link app2
3. docker run helper --link app3
4. docker run helper --link app4

We would need to establish network connectivity between these containers ourselves using links and custom networks.
we would need to create shareable volumes and share it among the containers

We would need to maintain a map of that as well.
And most importantly we would need to monitor the state of theapplication container
and when it dies manually kill the helper container as well as its no longer required.
When a new container is deployed we would need to deploy the new helper container as well.

#===================================================================================>
With PODs all the above steps,kubernetes does all of this for us automatically.
#===================================================================================>

We just need to define what containers a POD consists of and the containers in a POD by default will have access to the same storage,
the same network namespace, and same fate as in they will be created together and destroyed together.

Even if our application did not happen to be so complex and we could live with a single container, kubernetes still requires you to create pods.

But this is good in the long run as your application is now equipped for architectural changes and scale in the future.

However also note that multi-pod containers are a rare use-case
and we are going to stick to single container per POD.

$kubectl run nginx --image nginx

What this command really does is it deploys a docker container by creating a POD.
So it first creates a POD automatically and deploys an instance of the nginx docker image.

$kubectl run nginx --image nginx

But were does it get the application image from?
For that you need to specify the image name using the -- image parameter.
The application image,in this case the nginx image, is downloaded from the docker hub repository.
Docker hub is a public repository where latest Docker images of various applications are stored.

You could configure kubernetes to pull the image from the public docker hub or a private repository within the organisation.

Now that we have a POD created, how do we see the list of PODs available?
The kubectl get PODs command helps us see the list of pods in our cluster.

$kubectl get pods -o wide

In this case we see the part is in the container creating state and soon changes to a running state when it is actually running.

And so in the current state we haven’t made the web server accessible to external users.
You can however access it internally from the node.

how to make the service accessible to end users?


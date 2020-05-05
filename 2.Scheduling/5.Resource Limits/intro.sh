cpu
memory
disk

By default kubernetes assumes that a POD or container with in a pod requires 0.5CPU and 256MB of memory.
This is known as the resource request for a container the minimum amount of CPU or memory requested by the container.

when the scheduler tries to place the pod on a node, Scheduler uses these numbers to identify a node which has
sufficient amount of resources available.

Now if you know that your application will need more than these, you can modify these values by specifying them
in your pod (or) deployment definition files.

Simple-pod-definition-file:
---------------------------->
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 8080
      resources:
        requests:
          memory: "1Gi"
          cpu: 1

============================================================================================:

Now lets look at a container running on a node.
In the docker world a container has no limit to the resources that it can consume on a node.

Say container starts with 1 vCPU on a Node, it can go up and consume as much resource as it requires,
thus suffocating the native processes on the node or other containers.

However you can set a limit for the resource usage on these pods.

By default kubernetes sets a limit of 1vCPU to containers. So if you do not specify explicitly, a container will be limited
to consume only 1 vCPU from the Node.
By default kubernetes sets a limit of 512 Mebibyte on containers.

So if you do not like the default limit you can change them by adding limit section under the resources as below

apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
  labels:
    name: simple-webapp-color
spec:
  containers:
    - name: simple-webapp-color
      image: simple-webapp-color
      ports:
        - containerPort: 8080
      resources:
        requests:
          memory: "1Gi"
          cpu: 1
        limits:
          memory: "2Gi"
          cpu: 2

============================================================================

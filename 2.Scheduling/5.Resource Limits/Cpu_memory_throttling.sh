So what happens when a pod tries to exceed resources beyond its specified limit.

CPU:(THROTTLE)
---------------->
In case of CPU, kubernetes throttles the CPU so that it does not go beyond the specified limit.
So A container cannot use more CPU resources than its limit.
However this is not the case with the memory.

MEMORY(TERMINATE):
-------------------->
A conainer can use more memory resources than its limit.
So i a Pod tries to consume more memory than its limit constantly, the POD will be terminated.

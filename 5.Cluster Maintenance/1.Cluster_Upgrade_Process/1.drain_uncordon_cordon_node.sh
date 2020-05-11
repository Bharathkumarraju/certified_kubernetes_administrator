1. You can purposefully drain the node , so that
all the workload on that node will move to other nodes.

$ kubectl drain node-1

once the node-1 upgrade and reboot is over you have to "uncordon(schedulable)" it.

$ kubectl uncordon node-1


$ kubectl cordon node-02
There is also another option i.e. "cordon"
It will make the node as "unschedulable" means no pods going to schedule in this node.
unlike drain it doesnot terminate or move the pods to an another node.
It simply make sure that new pods are not scheduled in the node node-02.


=============================================================================================>

Cluster Management Commands:
  certificate    Modify certificate resources.
  cluster-info   Display cluster info
  top            Display Resource (CPU/Memory/Storage) usage.
  cordon         Mark node as unschedulable
  uncordon       Mark node as schedulable
  drain          Drain node in preparation for maintenance


===========================
Scheduling
===========================

ManualScheduling:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/1.demo_Manual_scheduling_pod.sh
  :language: bash
  :caption: ManualScheduling

ManualSchedulingLabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/2.demo_manual_scheduling_pods_labs.sh
  :language: bash
  :caption: ManualSchedulingLabs

LabelsSelectors:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/3.demo_labels_selectors.sh
  :language: bash
  :caption: LabelsSelectors

labelsselectorslabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/5.demo_labels_selectors_labs.sh
  :language: bash
  :caption: labelsselectorslabs

taintstolerations:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/7.demo_taints_tolerations.sh
  :language: bash
  :caption: taintstolerations

taintstolerationslabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/9.demo_taints_tolerations_labs.sh
  :language: bash
  :caption: taintstolerationslabs

NodeSelectors:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/10.demo_node_selectors.sh
  :language: bash
  :caption: NodeSelectors

nodeaffinity:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/11.demo_node_affnity.sh
  :language: bash
  :caption: nodeaffinity

nodeaffinitytypes:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/12.demo_node_affinity_types.sh
  :language: bash
  :caption: nodeaffinitytypes

nodeaffinitylabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/13.demo_node_affinity_labs.sh
  :language: bash
  :caption: nodeaffinitylabs

resourcelimits:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/14.demo_Resources_limits.sh
  :language: bash
  :caption: resourcelimits

resourcelimitslabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/15.demo_resource_limits_labs.sh
  :language: bash
  :caption: resourcelimitslabs

daemonsets:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/16.demo_daemonsets.sh
  :language: bash
  :caption: daemonsets

daemonsetlabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/17.demo_daemonset_labs.sh
  :language: bash
  :caption: daemonsetlabs

staticpods:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/18.demo_static_pods.sh
  :language: bash
  :caption: staticpods

staticpodlabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/19.demo_staticpods_labs.sh
  :language: bash
  :caption: staticpodlabs

multipleschedulers:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/20.demo_multiple_schedulers.sh
  :language: bash
  :caption: multipleschedulers

multipleschedulerlabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/21.demo_multiple_scheduler_labs.sh
  :language: bash
  :caption: multipleschedulerlabs



pods/deployments/daemonsets with labels, nodeSelectors, taints/tolerations, affinity/antiaffinity rules
-----------------------------------------------------------------------------------------------------------

podlabels:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/pod_with_labales.yaml
  :language: yaml
  :caption: podlabels

replicasetlabels:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/4.demo_replicaset_labels.yaml
  :language: yaml
  :caption: replicasetlabels

replicasetlabels2:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/6.demo_replicaset_labels_1.yaml
  :language: yaml
  :caption: replicasetlabels2

taintstolerations:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/8.demo_taint_tolerations.yaml
  :language: yaml
  :caption: taintstolerations

beepodtolerations:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/bee_pod_tolerations.yaml
  :language: yaml
  :caption: beepodtolerations

podnodeselector:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/pod-definition-nodeSelector.yaml
  :language: yaml
  :caption: podnodeselector

podnodeaffinity_In:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/pod_with_node_affinity_In.yaml
  :language: yaml
  :caption: podnodeaffinity_In

podnodeaffinity_NotIn:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/pod_with_node_affinity_NotIn.yaml
  :language: yaml
  :caption: podnodeaffinity_NotIn

podnodeaffinity_Exists:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/pod_with_node_affinity_Exists.yaml
  :language: yaml
  :caption: podnodeaffinity_Exists

deploymentnodeaffinity:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/red_deployment_node_affinity.yaml
  :language: yaml
  :caption: deploymentnodeaffinity

deploymentnodeaffinity2:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/blue_deployment_node_affinity.yaml
  :language: yaml
  :caption: deploymentnodeaffinity2

podresources:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/pod_with_resource_limits.yaml
  :language: yaml
  :caption: podresources

webappdeployment:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/web_app_deployment.yaml
  :language: yaml
  :caption: webappdeployment

webappreplicaset:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/web_app_replicaset.yaml
  :language: yaml
  :caption: webappreplicaset

webappdaemonset:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/web_app_daemonset.yaml
  :language: yaml
  :caption: webappdaemonset

staticpod_busybox:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/static-busybox.yaml
  :language: yaml
  :caption: staticpod_busybox

custom_scheduler:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/2.Scheduling/pod_with_custom_scheduler.yaml
  :language: yaml
  :caption: custom_scheduler


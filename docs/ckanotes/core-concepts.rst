===========================
Core Concepts
===========================

All kubernetes components(minikube):
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/0.all_components_in_minikube.sh
  :language: bash
  :caption: all_k8s_components

etcd:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/1.demo_etcd.sh
  :language: bash
  :caption: etcd

kubeapiserver:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/2.demo_kube_apiserver.sh
  :language: bash
  :caption: apiserver

kubecontrollermanager:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/3.demo_kube_controller_manager.sh
  :language: bash
  :caption: kubecontrollermanager

kubescheduler:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/4.demo_kube_scheduler.sh
  :language: bash
  :caption: kubescheduler

kubelet:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/5.demo_kubelet.sh
  :language: bash
  :caption: kubelet

kubeproxy:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/6.demo_kube_proxy.sh
  :language: bash
  :caption: kubeproxy

pods:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/7.demo_pods.sh
  :language: bash
  :caption: pods

podslabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/8.demo_pods_labs.sh
  :language: bash
  :caption: podslabs

replicationcontroller:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/9.demo_replicationcontroller.sh
  :language: bash
  :caption: replicationcontroller

replicaset:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/10.demo_replicaset.sh
  :language: bash
  :caption: replicaset

replicasetlabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/11.demo_replicaset_labs.sh
  :language: bash
  :caption: replicasetlabs

deployments:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/12.demo_deployments.sh
  :language: bash
  :caption: deployments

generatedeploymentyaml:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/13.generate_deployment_manifest.sh
  :language: bash
  :caption: generatedeploymentyaml

deploymentlabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/14.deployment_labs.sh
  :language: bash
  :caption: deploymentlabs

namespaces:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/15.k8s_namespaces.sh
  :language: bash
  :caption: namespaces

resourcesinnamespaces:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/16.Resource_quota_on_namespace.sh
  :language: bash
  :caption: resourcesinnamespaces

namespacelabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/17.namespace_labs.sh
  :language: bash
  :caption: namespacelabs

services:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/18.demo_services.sh
  :language: bash
  :caption: services

serviceNodePort:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/19.demo_service_NodePort.sh
  :language: bash
  :caption: serviceNodePort

serviceCLusterIP:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/20.demo_service_clusterIP.sh
  :language: bash
  :caption: serviceCLusterIP

serviceLoadBalancer:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/21.demo_service_loadbalancer.sh
  :language: bash
  :caption: serviceLoadBalancer

servicelabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/22.demo_service_labs.sh
  :language: bash
  :caption: servicelabs

kubectlDeclarative:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/23.kubectl_imperative_declarative.sh
  :language: bash
  :caption: kubectlDeclarative

kubectlImperative:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/24.kubectl_imperative.sh
  :language: bash
  :caption: kubectlImperative

kubectlImperativelabs:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/25.k8s_imperative_labs.sh
  :language: bash
  :caption: kubectlImperativelabs


Pod, RepliationController, Repliaset, Deployment, Service, Namespace manifest files
-------------------------------------------------------------------------------------

podnginx:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/sample_pod_nginx.yaml
  :language: yaml
  :caption: podnginx

podredis:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/sample_pod_redis.yaml
  :language: yaml
  :caption: podredis

replicationcontroller:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/ReplicationController-definition.yaml
  :language: yaml
  :caption: replicationcontroller

replicaset:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/replicaset-definition.yaml
  :language: yaml
  :caption: replicaset

replicasetlab1:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/lab_replicaset_definition1.yaml
  :language: yaml
  :caption: replicasetlab1

replicasetlab2:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/lab_replicaset_definition2.yaml
  :language: yaml
  :caption: replicasetlab2

samplepod:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/sample_pod.yaml
  :language: yaml
  :caption: samplepod

deployment:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/deployment-definition.yaml
  :language: yaml
  :caption: deployment

replicasetrecap:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/replicaset_recap.yaml
  :language: yaml
  :caption: replicasetrecap

redisdeployment:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/redis-deployment.yaml
  :language: yaml
  :caption: redisdeployment

namespace:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/create_namespace.yaml
  :language: yaml
  :caption: namespace

servicenodeport:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/service_nodeport.yaml
  :language: yaml
  :caption: servicenodeport

webpod:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/bkweb_pod.yaml
  :language: yaml
  :caption: webpod

serviceclusterip:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/service_ClusterIP.yaml
  :language: yaml
  :caption: serviceclusterip

webpod2:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/bkweb_pod2.yaml
  :language: yaml
  :caption: webpod2

servicelb:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/service_loadbalancer.yaml
  :language: yaml
  :caption: servicelb

simplewebapp:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/simple-webapp-deployment.yaml
  :language: yaml
  :caption: simplewebapp

servicewebapp:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/service_definition_webapp.yaml
  :language: yaml
  :caption: servicewebapp

nginxdeploymentimperative:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/nginx_deployment_imperative.yaml
  :language: yaml
  :caption: nginxdeploymentimperative

podsrecap:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/pods_recap.yaml
  :language: yaml
  :caption: podsrecap

simplewebservice:
.. literalinclude:: ../../Four_September_2021_CKA_Recap/1.Core_Concepts/simple_webapp_service.yaml
  :language: yaml
  :caption: simplewebservice


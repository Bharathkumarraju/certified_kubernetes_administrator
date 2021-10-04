=================================
Application lifecycle management
=================================

rollingupdate_rollbacks

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/1.demo_rolling_update_rollbacks.sh
  :language: bash
  :caption: rollingupdate_rollbacks

rollingupdate_rollbackslabs

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/2.demo_rollingupdate_rollback_labs.sh
  :language: bash
  :caption: rollingupdate_rollbackslabs

curl_test

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/curl-test.sh
  :language: bash
  :caption: curl_test

configureapp

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/3.demo_configure_application_k8s.sh
  :language: bash
  :caption: configureapp

dockercommands

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/4.demo_commads_in_docker.sh
  :language: bash
  :caption: dockercommands

k8s_commands

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/5.demo_commands_in_kubernetes.sh
  :language: bash
  :caption: k8s_commands

k8s_commandslabs

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/6.demo_commands_in_k8s_labs.sh
  :language: bash
  :caption: k8s_commandslabs

configmap

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/7.demo_config_maps.sh
  :language: bash
  :caption: configmap

configmaplabs

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/8.demo_configmaps_labs.sh
  :language: bash
  :caption: configmaplabs

secrets

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/9.demo_k8s_secrets.sh
  :language: bash
  :caption: secrets

secretslabs

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/10.demo_k8s_secrets_labs.sh
  :language: bash
  :caption: secretslabs

multicontainer_pods

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/11.demo_multi_container_pods.sh
  :language: bash
  :caption: multicontainer_pods

multicontainer_podslabs

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/12.demo_multicontainer_pod_labs.sh
  :language: bash
  :caption: multicontainer_podslabs

initcontainers

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/13.demo_init_container.sh
  :language: bash
  :caption: initcontainers

initcontainerlabs

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/15.demo_initContainers_labs.sh
  :language: bash
  :caption: initcontainerlabs

yaml specifications for application
-------------------------------------

poddefinition

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/ubuntu-sleeper-pod-defnition.yaml
  :language: yaml
  :caption: poddefinition

overwritepodargs

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/overwrite_pod_args.yaml
  :language: yaml
  :caption: overwritepodargs

envs_in_poddefinition

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/example_of_envs_in_pod.yaml
  :language: yaml
  :caption: envs_in_poddefinition

app_config_properties

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/app_config.properties
  :language: bash
  :caption: app_config_properties

configmap

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/demo_configmap.yaml
  :language: yaml
  :caption: configmap

configmap_in_pods

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/use_configmaps_in_pod.yaml
  :language: yaml
  :caption: configmap_in_pods

webconfigmap

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/webapp-config-map.yaml
  :language: yaml
  :caption: webconfigmap

configmap_use_envFrom

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/use_configmaps_envFrom.yaml
  :language: yaml
  :caption: configmap_use_envFrom

createsecrets

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/create_secret.yaml
  :language: yaml
  :caption: createsecrets

app_secrets

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/app_secrets.properties
  :language: bash
  :caption: app_secrets

usesecrets_in_app

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/k8s_secrets_in_app.yaml
  :language: yaml
  :caption: usesecrets_in_app

multicontainerpods

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/multi_container_pod.yaml
  :language: yaml
  :caption: multicontainerpods

configure_sidecar

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/configure_sidecar_app_to_send_logs_to_elasticsearch.yaml
  :language: yaml
  :caption: configure_sidecar

init_container

.. literalinclude:: ../../Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/14.demo_init_container_example.yaml
  :language: yaml
  :caption: init_container



configure sidecar to send logs to elasticsearch
------------------------------------------------------

used below code to to configure ELK

ELK code at `ELK-CODE`_.

.. _ELK-CODE: https://github.com/Bharathkumarraju/certified_kubernetes_administrator/tree/master/Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/elastic-search_multi_container_pods/




command args in pod specification
----------------------------------

pod specifications at `webpods`_.

.. _webpods: https://github.com/Bharathkumarraju/certified_kubernetes_administrator/tree/master/Four_September_2021_CKA_Recap/4.Application_lifecycle_mgmt/kubect_commands_args/



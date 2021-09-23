Cluster_Scoped_Resources:
-------------------------------------->
1. nodes
2. PV
3. clusterroles
4. clusterrolebindings
5. certificatesigningrequests
6. namespaces

namespaced resources:
-------------------------------------------------------------------------------------->
MacBook-Pro:6.Security bharathdasaraju$ kubectl api-resources --namespaced=true | sort
NAME                        SHORTNAMES   APIGROUP                    NAMESPACED   KIND
bindings                                                             true         Binding
configmaps                  cm                                       true         ConfigMap
controllerrevisions                      apps                        true         ControllerRevision
cronjobs                    cj           batch                       true         CronJob
daemonsets                  ds           apps                        true         DaemonSet
deployments                 deploy       apps                        true         Deployment
endpoints                   ep                                       true         Endpoints
endpointslices                           discovery.k8s.io            true         EndpointSlice
events                      ev                                       true         Event
events                      ev           events.k8s.io               true         Event
horizontalpodautoscalers    hpa          autoscaling                 true         HorizontalPodAutoscaler
ingresses                   ing          extensions                  true         Ingress
ingresses                   ing          networking.k8s.io           true         Ingress
jobs                                     batch                       true         Job
leases                                   coordination.k8s.io         true         Lease
limitranges                 limits                                   true         LimitRange
localsubjectaccessreviews                authorization.k8s.io        true         LocalSubjectAccessReview
networkpolicies             netpol       networking.k8s.io           true         NetworkPolicy
persistentvolumeclaims      pvc                                      true         PersistentVolumeClaim
poddisruptionbudgets        pdb          policy                      true         PodDisruptionBudget
pods                                     metrics.k8s.io              true         PodMetrics
pods                        po                                       true         Pod
podtemplates                                                         true         PodTemplate
replicasets                 rs           apps                        true         ReplicaSet
replicationcontrollers      rc                                       true         ReplicationController
resourcequotas              quota                                    true         ResourceQuota
rolebindings                             rbac.authorization.k8s.io   true         RoleBinding
roles                                    rbac.authorization.k8s.io   true         Role
secrets                                                              true         Secret
serviceaccounts             sa                                       true         ServiceAccount
services                    svc                                      true         Service
statefulsets                sts          apps                        true         StatefulSet
MacBook-Pro:6.Security bharathdasaraju$ 

cluster scoped resources:
-------------------------------------------------------------------------------------->

MacBook-Pro:6.Security bharathdasaraju$ kubectl api-resources --namespaced=false | sort
NAME                              SHORTNAMES   APIGROUP                       NAMESPACED   KIND
apiservices                                    apiregistration.k8s.io         false        APIService
certificatesigningrequests        csr          certificates.k8s.io            false        CertificateSigningRequest
clusterrolebindings                            rbac.authorization.k8s.io      false        ClusterRoleBinding
clusterroles                                   rbac.authorization.k8s.io      false        ClusterRole
componentstatuses                 cs                                          false        ComponentStatus
csidrivers                                     storage.k8s.io                 false        CSIDriver
csinodes                                       storage.k8s.io                 false        CSINode
customresourcedefinitions         crd,crds     apiextensions.k8s.io           false        CustomResourceDefinition
flowschemas                                    flowcontrol.apiserver.k8s.io   false        FlowSchema
ingressclasses                                 networking.k8s.io              false        IngressClass
mutatingwebhookconfigurations                  admissionregistration.k8s.io   false        MutatingWebhookConfiguration
namespaces                        ns                                          false        Namespace
nodes                                          metrics.k8s.io                 false        NodeMetrics
nodes                             no                                          false        Node
persistentvolumes                 pv                                          false        PersistentVolume
podsecuritypolicies               psp          policy                         false        PodSecurityPolicy
priorityclasses                   pc           scheduling.k8s.io              false        PriorityClass
prioritylevelconfigurations                    flowcontrol.apiserver.k8s.io   false        PriorityLevelConfiguration
runtimeclasses                                 node.k8s.io                    false        RuntimeClass
selfsubjectaccessreviews                       authorization.k8s.io           false        SelfSubjectAccessReview
selfsubjectrulesreviews                        authorization.k8s.io           false        SelfSubjectRulesReview
storageclasses                    sc           storage.k8s.io                 false        StorageClass
subjectaccessreviews                           authorization.k8s.io           false        SubjectAccessReview
tokenreviews                                   authentication.k8s.io          false        TokenReview
validatingwebhookconfigurations                admissionregistration.k8s.io   false        ValidatingWebhookConfiguration
volumeattachments                              storage.k8s.io                 false        VolumeAttachment
MacBook-Pro:6.Security bharathdasaraju$ 
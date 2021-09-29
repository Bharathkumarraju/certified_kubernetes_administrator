MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o wide
NAME       STATUS   ROLES                  AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION    CONTAINER-RUNTIME
minikube   Ready    control-plane,master   25d   v1.20.2   192.168.49.2   <none>        Ubuntu 20.04.2 LTS   5.4.39-linuxkit   docker://20.10.6
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 


MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o json | jq
{
  "apiVersion": "v1",
  "items": [
    {
      "apiVersion": "v1",
      "kind": "Node",
      "metadata": {
        "annotations": {
          "kubeadm.alpha.kubernetes.io/cri-socket": "/var/run/dockershim.sock",
          "node.alpha.kubernetes.io/ttl": "0",
          "volumes.kubernetes.io/controller-managed-attach-detach": "true"
        },
        "creationTimestamp": "2021-09-04T06:52:20Z",
        "labels": {
          "beta.kubernetes.io/arch": "amd64",
          "beta.kubernetes.io/os": "linux",
          "color": "blue",
          "kubernetes.io/arch": "amd64",
          "kubernetes.io/hostname": "minikube",
          "kubernetes.io/os": "linux",
          "minikube.k8s.io/commit": "c61663e942ec43b20e8e70839dcca52e44cd85ae",
          "minikube.k8s.io/name": "minikube",
          "minikube.k8s.io/updated_at": "2021_09_04T14_52_27_0700",
          "minikube.k8s.io/version": "v1.20.0",
          "node-role.kubernetes.io/control-plane": "",
          "node-role.kubernetes.io/master": "",
          "size": "Large"
        },
        "managedFields": [
          {
            "apiVersion": "v1",
            "fieldsType": "FieldsV1",
            "fieldsV1": {
              "f:metadata": {
                "f:annotations": {
                  "f:kubeadm.alpha.kubernetes.io/cri-socket": {}
                },
                "f:labels": {
                  "f:node-role.kubernetes.io/control-plane": {},
                  "f:node-role.kubernetes.io/master": {}
                }
              }
            },
            "manager": "kubeadm",
            "operation": "Update",
            "time": "2021-09-04T06:52:25Z"
          },
          {
            "apiVersion": "v1",
            "fieldsType": "FieldsV1",
            "fieldsV1": {
              "f:metadata": {
                "f:labels": {
                  "f:color": {},
                  "f:minikube.k8s.io/commit": {},
                  "f:minikube.k8s.io/name": {},
                  "f:minikube.k8s.io/updated_at": {},
                  "f:minikube.k8s.io/version": {},
                  "f:size": {}
                }
              }
            },
            "manager": "kubectl-label",
            "operation": "Update",
            "time": "2021-09-17T23:00:31Z"
          },
          {
            "apiVersion": "v1",
            "fieldsType": "FieldsV1",
            "fieldsV1": {
              "f:metadata": {
                "f:annotations": {
                  "f:node.alpha.kubernetes.io/ttl": {}
                }
              },
              "f:spec": {
                "f:podCIDR": {},
                "f:podCIDRs": {
                  ".": {},
                  "v:\"10.244.0.0/24\"": {}
                }
              }
            },
            "manager": "kube-controller-manager",
            "operation": "Update",
            "time": "2021-09-24T12:52:22Z"
          },
          {
            "apiVersion": "v1",
            "fieldsType": "FieldsV1",
            "fieldsV1": {
              "f:metadata": {
                "f:annotations": {
                  ".": {},
                  "f:volumes.kubernetes.io/controller-managed-attach-detach": {}
                },
                "f:labels": {
                  ".": {},
                  "f:beta.kubernetes.io/arch": {},
                  "f:beta.kubernetes.io/os": {},
                  "f:kubernetes.io/arch": {},
                  "f:kubernetes.io/hostname": {},
                  "f:kubernetes.io/os": {}
                }
              },
              "f:status": {
                "f:addresses": {
                  ".": {},
                  "k:{\"type\":\"Hostname\"}": {
                    ".": {},
                    "f:address": {},
                    "f:type": {}
                  },
                  "k:{\"type\":\"InternalIP\"}": {
                    ".": {},
                    "f:address": {},
                    "f:type": {}
                  }
                },
                "f:allocatable": {
                  ".": {},
                  "f:cpu": {},
                  "f:ephemeral-storage": {},
                  "f:hugepages-1Gi": {},
                  "f:hugepages-2Mi": {},
                  "f:memory": {},
                  "f:pods": {}
                },
                "f:capacity": {
                  ".": {},
                  "f:cpu": {},
                  "f:ephemeral-storage": {},
                  "f:hugepages-1Gi": {},
                  "f:hugepages-2Mi": {},
                  "f:memory": {},
                  "f:pods": {}
                },
                "f:conditions": {
                  ".": {},
                  "k:{\"type\":\"DiskPressure\"}": {
                    ".": {},
                    "f:lastHeartbeatTime": {},
                    "f:lastTransitionTime": {},
                    "f:message": {},
                    "f:reason": {},
                    "f:status": {},
                    "f:type": {}
                  },
                  "k:{\"type\":\"MemoryPressure\"}": {
                    ".": {},
                    "f:lastHeartbeatTime": {},
                    "f:lastTransitionTime": {},
                    "f:message": {},
                    "f:reason": {},
                    "f:status": {},
                    "f:type": {}
                  },
                  "k:{\"type\":\"PIDPressure\"}": {
                    ".": {},
                    "f:lastHeartbeatTime": {},
                    "f:lastTransitionTime": {},
                    "f:message": {},
                    "f:reason": {},
                    "f:status": {},
                    "f:type": {}
                  },
                  "k:{\"type\":\"Ready\"}": {
                    ".": {},
                    "f:lastHeartbeatTime": {},
                    "f:lastTransitionTime": {},
                    "f:message": {},
                    "f:reason": {},
                    "f:status": {},
                    "f:type": {}
                  }
                },
                "f:daemonEndpoints": {
                  "f:kubeletEndpoint": {
                    "f:Port": {}
                  }
                },
                "f:images": {},
                "f:nodeInfo": {
                  "f:architecture": {},
                  "f:bootID": {},
                  "f:containerRuntimeVersion": {},
                  "f:kernelVersion": {},
                  "f:kubeProxyVersion": {},
                  "f:kubeletVersion": {},
                  "f:machineID": {},
                  "f:operatingSystem": {},
                  "f:osImage": {},
                  "f:systemUUID": {}
                }
              }
            },
            "manager": "kubelet",
            "operation": "Update",
            "time": "2021-09-24T12:52:32Z"
          },
          {
            "apiVersion": "v1",
            "fieldsType": "FieldsV1",
            "fieldsV1": {
              "f:status": {
                "f:conditions": {
                  "k:{\"type\":\"NetworkUnavailable\"}": {
                    ".": {},
                    "f:lastHeartbeatTime": {},
                    "f:lastTransitionTime": {},
                    "f:message": {},
                    "f:reason": {},
                    "f:status": {},
                    "f:type": {}
                  }
                }
              }
            },
            "manager": "kube-utils",
            "operation": "Update",
            "time": "2021-09-27T07:00:54Z"
          }
        ],
        "name": "minikube",
        "resourceVersion": "201862",
        "uid": "c2ab7942-ba64-4e3f-b6e3-54f11e83082d"
      },
      "spec": {
        "podCIDR": "10.244.0.0/24",
        "podCIDRs": [
          "10.244.0.0/24"
        ]
      },
      "status": {
        "addresses": [
          {
            "address": "192.168.49.2",
            "type": "InternalIP"
          },
          {
            "address": "minikube",
            "type": "Hostname"
          }
        ],
        "allocatable": {
          "cpu": "2",
          "ephemeral-storage": "61255492Ki",
          "hugepages-1Gi": "0",
          "hugepages-2Mi": "0",
          "memory": "2035604Ki",
          "pods": "110"
        },
        "capacity": {
          "cpu": "2",
          "ephemeral-storage": "61255492Ki",
          "hugepages-1Gi": "0",
          "hugepages-2Mi": "0",
          "memory": "2035604Ki",
          "pods": "110"
        },
        "conditions": [
          {
            "lastHeartbeatTime": "2021-09-29T08:05:47Z",
            "lastTransitionTime": "2021-09-29T08:05:47Z",
            "message": "Weave pod has set this",
            "reason": "WeaveIsUp",
            "status": "False",
            "type": "NetworkUnavailable"
          },
          {
            "lastHeartbeatTime": "2021-09-29T08:05:28Z",
            "lastTransitionTime": "2021-09-24T12:52:32Z",
            "message": "kubelet has sufficient memory available",
            "reason": "KubeletHasSufficientMemory",
            "status": "False",
            "type": "MemoryPressure"
          },
          {
            "lastHeartbeatTime": "2021-09-29T08:05:28Z",
            "lastTransitionTime": "2021-09-24T12:52:32Z",
            "message": "kubelet has no disk pressure",
            "reason": "KubeletHasNoDiskPressure",
            "status": "False",
            "type": "DiskPressure"
          },
          {
            "lastHeartbeatTime": "2021-09-29T08:05:28Z",
            "lastTransitionTime": "2021-09-24T12:52:32Z",
            "message": "kubelet has sufficient PID available",
            "reason": "KubeletHasSufficientPID",
            "status": "False",
            "type": "PIDPressure"
          },
          {
            "lastHeartbeatTime": "2021-09-29T08:05:28Z",
            "lastTransitionTime": "2021-09-24T12:52:32Z",
            "message": "kubelet is posting ready status",
            "reason": "KubeletReady",
            "status": "True",
            "type": "Ready"
          }
        ],
        "daemonEndpoints": {
          "kubeletEndpoint": {
            "Port": 10250
          }
        },
        "images": [
          {
            "names": [
              "k8s.gcr.io/etcd@sha256:4ad90a11b55313b182afc186b9876c8e891531b8db4c9bf1541953021618d0e2",
              "k8s.gcr.io/etcd:3.4.13-0"
            ],
            "sizeBytes": 253392289
          },
          {
            "names": [
              "kubernetesui/dashboard@sha256:7f80b5ba141bead69c4fee8661464857af300d7d7ed0274cf7beecedc00322e6",
              "kubernetesui/dashboard:v2.1.0"
            ],
            "sizeBytes": 225733746
          },
          {
            "names": [
              "nginx@sha256:853b221d3341add7aaadf5f81dd088ea943ab9c918766e295321294b035f3f3e",
              "nginx:latest"
            ],
            "sizeBytes": 133283279
          },
          {
            "names": [
              "<none>@<none>",
              "<none>:<none>"
            ],
            "sizeBytes": 133175493
          },
          {
            "names": [
              "k8s.gcr.io/kube-apiserver@sha256:465ba895d578fbc1c6e299e45689381fd01c54400beba9e8f1d7456077411411",
              "k8s.gcr.io/kube-apiserver:v1.20.2"
            ],
            "sizeBytes": 121669114
          },
          {
            "names": [
              "k8s.gcr.io/kube-proxy@sha256:326fe8a4508a5db91cf234c4867eff5ba458bc4107c2a7e15c827a74faa19be9",
              "k8s.gcr.io/kube-proxy:v1.20.2"
            ],
            "sizeBytes": 118400203
          },
          {
            "names": [
              "k8s.gcr.io/kube-controller-manager@sha256:842a071d4ad49b0018f7f7404ac8a4ddfc2bce2ce15b3f8131d89563fda36c9b",
              "k8s.gcr.io/kube-controller-manager:v1.20.2"
            ],
            "sizeBytes": 115852794
          },
          {
            "names": [
              "<none>@<none>",
              "<none>:<none>"
            ],
            "sizeBytes": 105408201
          },
          {
            "names": [
              "weaveworks/weave-kube@sha256:d797338e7beb17222e10757b71400d8471bdbd9be13b5da38ce2ebf597fb4e63",
              "weaveworks/weave-kube:2.8.1"
            ],
            "sizeBytes": 89037656
          },
          {
            "names": [
              "kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423",
              "kodekloud/webapp-color:latest"
            ],
            "sizeBytes": 84848908
          },
          {
            "names": [
              "<none>@<none>",
              "<none>:<none>"
            ],
            "sizeBytes": 84758750
          },
          {
            "names": [
              "kodekloud/event-simulator@sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9",
              "kodekloud/event-simulator:latest"
            ],
            "sizeBytes": 78221917
          },
          {
            "names": [
              "ubuntu@sha256:9d6a8699fb5c9c39cf08a0871bd6219f0400981c570894cd8cbea30d3424a31f",
              "ubuntu:latest"
            ],
            "sizeBytes": 72776725
          },
          {
            "names": [
              "k8s.gcr.io/metrics-server/metrics-server@sha256:dbc33d7d35d2a9cc5ab402005aa7a0d13be6192f3550c7d42cba8d2d5e3a5d62"
            ],
            "sizeBytes": 60547543
          },
          {
            "names": [
              "k8s.gcr.io/kube-scheduler@sha256:304b3d70497bd62498f19f82f9ef164d38948e5ae94966690abfe9d1858867e2",
              "k8s.gcr.io/kube-scheduler:v1.20.2"
            ],
            "sizeBytes": 46384634
          },
          {
            "names": [
              "k8s.gcr.io/coredns@sha256:73ca82b4ce829766d4f1f10947c3a338888f876fbed0540dc849c89ff256e90c",
              "k8s.gcr.io/coredns:1.7.0"
            ],
            "sizeBytes": 45227747
          },
          {
            "names": [
              "weaveworks/weave-npc@sha256:38d3e30a97a2260558f8deb0fc4c079442f7347f27c86660dbfc8ca91674f14c",
              "weaveworks/weave-npc:2.8.1"
            ],
            "sizeBytes": 39273789
          },
          {
            "names": [
              "kubernetesui/metrics-scraper@sha256:555981a24f184420f3be0c79d4efb6c948a85cfce84034f85a563f4151a81cbf",
              "kubernetesui/metrics-scraper:v1.0.4"
            ],
            "sizeBytes": 36937728
          },
          {
            "names": [
              "gcr.io/k8s-minikube/storage-provisioner@sha256:18eb69d1418e854ad5a19e399310e52808a8321e4c441c1dddad8977a0d7a944",
              "gcr.io/k8s-minikube/storage-provisioner:v5"
            ],
            "sizeBytes": 31465472
          },
          {
            "names": [
              "busybox@sha256:52f73a0a43a16cf37cd0720c90887ce972fe60ee06a687ee71fb93a7ca601df7",
              "busybox:latest"
            ],
            "sizeBytes": 1235724
          },
          {
            "names": [
              "k8s.gcr.io/pause@sha256:927d98197ec1141a368550822d18fa1c60bdae27b78b0c004f705f548c07814f",
              "k8s.gcr.io/pause:3.2"
            ],
            "sizeBytes": 682696
          }
        ],
        "nodeInfo": {
          "architecture": "amd64",
          "bootID": "ec127cba-1d71-4eda-9296-fe1fe4abb570",
          "containerRuntimeVersion": "docker://20.10.6",
          "kernelVersion": "5.4.39-linuxkit",
          "kubeProxyVersion": "v1.20.2",
          "kubeletVersion": "v1.20.2",
          "machineID": "822f5ed6656e44929f6c2cc5d6881453",
          "operatingSystem": "linux",
          "osImage": "Ubuntu 20.04.2 LTS",
          "systemUUID": "182b1b5d-793c-4026-88b4-599941ba1cae"
        }
      }
    }
  ],
  "kind": "List",
  "metadata": {
    "resourceVersion": "",
    "selfLink": ""
  }
}
MacBook-Pro:11.Troubleshooting bharathdasaraju$


MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=jsonpath='{.items[*].metadata.name}' 
minikube
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 

MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=jsonpath='{.items[*].status.nodeInfo}'
{"architecture":"amd64","bootID":"ec127cba-1d71-4eda-9296-fe1fe4abb570","containerRuntimeVersion":"docker://20.10.6","kernelVersion":"5.4.39-linuxkit","kubeProxyVersion":"v1.20.2","kubeletVersion":"v1.20.2","machineID":"822f5ed6656e44929f6c2cc5d6881453","operatingSystem":"linux","osImage":"Ubuntu 20.04.2 LTS","systemUUID":"182b1b5d-793c-4026-88b4-599941ba1cae"}

MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=jsonpath='{.items[*].status.nodeInfo.architecture}'
amd64
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 


amd64MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=jsonpath='{.items[*].status.capacity}'
{"cpu":"2","ephemeral-storage":"61255492Ki","hugepages-1Gi":"0","hugepages-2Mi":"0","memory":"2035604Ki","pods":"110"}
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 

MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=jsonpath='{.items[*].status.capacity.cpu}'
2
MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=jsonpath='{.items[*].metadata.name}{.items[*].status.capacity.cpu}'
minikube2
MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {.items[*].status.capacity.cpu}'
minikube 2
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 

loops in json path:
------------------------>
MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.capacity.cpu}{"\n"}{end}'
minikube        2
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 

cutom columns in jsonpath:
--------------------------------->
acBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=custom-columns=NODE:.metadata.name
NODE
minikube
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 


MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes -o=custom-columns=NODE:.metadata.name,CPU:.status.capacity.cpu
NODE       CPU
minikube   2
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 


kubectl with --sort-by options:
----------------------------------------------------------------------------------------------------->
MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes --sort-by=.metadata.name
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   25d   v1.20.2
MacBook-Pro:11.Troubleshooting bharathdasaraju$ kubectl get nodes --sort-by=.status.capacity.cpu
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   25d   v1.20.2
MacBook-Pro:11.Troubleshooting bharathdasaraju$ 
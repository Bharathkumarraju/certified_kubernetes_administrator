"docker run  --network none nginx" 

"docker run --network host nginx"


"docker run --network bridge nginx"


MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ docker network ls
NETWORK ID          NAME                                    DRIVER              SCOPE
76ff759a8f8f        bridge                                  bridge              local
dba422f82c6e        compose_docker_default                  bridge              local
3ce9a8ffc984        composetest_default                     bridge              local
b8740a40ef89        docker_coins_app_default                bridge              local
37736ae8c361        host                                    host                local
e79bde1e0995        kind                                    bridge              local
d6ebcb25937c        minikube                                bridge              local
955cbfa0ef47        urlrag_default                          bridge              local
MacBook-Pro:certified_kubernetes_administrator bharathdasaraju$ 


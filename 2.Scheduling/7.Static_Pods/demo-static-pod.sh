Q: Create a static pod named static-busybox that uses the busybox image and the command sleep 1000?

master $ kubectl run --restart=Never --image=busybox static-busybox --dry-run -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-busybox.yaml
master $


curl https://my-kube-playground:6443/api/v1/pods --key admin.key --cert admin.crt --cacert ca.crt

kubectl get pods --server my-kube-playground:6443/api/v1/pods \
                 --client-key admin.key \
                 --client-certificate admin.crt \
                 --certificate-authority ca.crt

                 
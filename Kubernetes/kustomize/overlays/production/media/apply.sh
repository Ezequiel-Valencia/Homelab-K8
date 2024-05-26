kubectl kustomize \
    ./production \
    | kubectl apply --kubeconfig=/home/zek/.kube/config_prd -f -
kubectl kustomize \
    ./ \
    | kubectl delete --kubeconfig=/home/zek/.kube/config_prd -f -
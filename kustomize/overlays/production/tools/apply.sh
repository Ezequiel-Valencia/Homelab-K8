kubectl kustomize \
    ./ \
    | kubectl apply --kubeconfig=/home/zek/.kube/config_prd -f -
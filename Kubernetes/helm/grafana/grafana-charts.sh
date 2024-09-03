read -p "Install Promethous (y/n): " INSTALL


if [ "$INSTALL" = "y" ]; then

    helm template -n monitoring prometheus \
    prometheus-community/kube-prometheus-stack -f values.yml \
    > helm-resource.yml

    kubectl kustomize . | kubectl apply --kubeconfig=/home/zek/.kube/config_prd -f -


else 
    helm template -n monitoring prometheus \
    prometheus-community/kube-prometheus-stack -f values.yml \
    > helm-resource.yml

    kubectl kustomize . | kubectl delete --kubeconfig=/home/zek/.kube/config_prd -f -

fi

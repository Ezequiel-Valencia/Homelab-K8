read -p "Install Promethous (y/n): " INSTALL


if [ "$INSTALL" = "y" ]; then

    helm upgrade --install -n monitoring homelab \
    prometheus-community/kube-prometheus-stack -f values.yml \
    --kubeconfig=/home/zek/.kube/config_prd

    kubectl patch --type merge -n monitoring Alertmanager homelab-alertmanager --patch-file patch.yml --kubeconfig=/home/zek/.kube/config_prd
    kubectl patch --type merge -n monitoring Prometheus homelab-prometheus --patch-file patch.yml --kubeconfig=/home/zek/.kube/config_prd

else 
    helm --kubeconfig=/home/zek/.kube/config_prd \
    uninstall --namespace=monitoring homelab

fi

######################################
## Old Templating Install/Uninstall ##
######################################

# Use to find out if CRDs ever change

# if [ "$INSTALL" = "y" ]; then

#     helm template -n monitoring homelab \
#     prometheus-community/kube-prometheus-stack -f values.yml \
#     > helm-resource.yml

#     kubectl kustomize . | kubectl apply --kubeconfig=/home/zek/.kube/config_prd -f -

# else 
#     helm template -n monitoring homelab \
#     prometheus-community/kube-prometheus-stack -f values.yml \
#     > helm-resource.yml

#     kubectl kustomize . | kubectl delete --kubeconfig=/home/zek/.kube/config_prd -f -

# fi


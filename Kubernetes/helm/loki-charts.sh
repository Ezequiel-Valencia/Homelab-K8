read -p "Install Loki (y/n): " INSTALL

# https://stackoverflow.com/questions/52486983/how-to-support-node-selection-when-using-helm-install
# Set desired node for deployment

if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install -n monitoring loki \
        --kubeconfig=/home/zek/.kube/config_prd \
        grafana/loki -f loki-values.yml

    else
        helm upgrade -n monitoring loki \
        --kubeconfig=/home/zek/.kube/config_prd \
        grafana/loki -f loki-values.yml
    fi


else 
    helm --kubeconfig=/home/zek/.kube/config_prd \
    uninstall --namespace=monitoring loki

fi

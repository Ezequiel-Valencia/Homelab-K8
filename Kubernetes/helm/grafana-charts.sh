read -p "Install Promethous (y/n): " INSTALL


if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install -n monitoring prometheus \
        --kubeconfig=/home/zek/.kube/config_prd \
        prometheus-community/kube-prometheus-stack -f grafana-prom-values.yml

    else
        helm upgrade -n monitoring prometheus \
        --kubeconfig=/home/zek/.kube/config_prd \
        prometheus-community/kube-prometheus-stack -f grafana-prom-values.yml
    fi


else 
    helm uninstall --namespace=monitoring prometheus

fi

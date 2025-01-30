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

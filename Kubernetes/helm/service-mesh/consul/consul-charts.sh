read -p "Install Consul (y/n): " INSTALL


if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install -n servicemesh homelab \
        --kubeconfig=/home/zek/.kube/config_prd \
        hashicorp/consul -f consul-values.yml

    else
        helm upgrade -n servicemesh homelab \
        --kubeconfig=/home/zek/.kube/config_prd \
        hashicorp/consul -f consul-values.yml
    fi


else 
    helm uninstall --kubeconfig=/home/zek/.kube/config_prd --namespace=servicemesh homelab

fi

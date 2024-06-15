read -p "Install Traefik (y/n): " INSTALL


if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install -n servicemesh traefik \
        --kubeconfig=/home/zek/.kube/config_prd \
        traefik/traefik -f traefik-values.yml

    else
        helm upgrade -n servicemesh traefik \
        --kubeconfig=/home/zek/.kube/config_prd \
        traefik/traefik -f traefik-values.yml
    fi


else 
    helm uninstall --kubeconfig=/home/zek/.kube/config_prd --namespace=servicemesh traefik

fi
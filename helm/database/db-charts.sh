read -p "Install Cloud Native PG (y/n): " INSTALL

export KUBECONFIG=/home/zek/.kube/config_prd

if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install cloudnativepg \
        -n database-system --create-namespace \
        cnpg/cloudnative-pg --version=0.25.0

    else
        helm upgrade -n database-system \
        cloudnativepg \
        cnpg/cloudnative-pg --version=0.25.0
    fi

    kubectl apply -f db-storage-class.yml
    kubectl apply -f db-cluster.yml
    kubectl apply -f pg-admin.yml

else 
    helm uninstall --namespace=database-system cloudnativepg
fi


# https://github.com/cloudnative-pg/charts

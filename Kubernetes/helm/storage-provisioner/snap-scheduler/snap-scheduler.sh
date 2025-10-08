read -p "Install Snap Scheduler provider (y/n): " INSTALL

export KUBECONFIG=/home/zek/.kube/config_prd

if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install snapscheduler \
        -n nfs-provisioner --create-namespace \
        backube/snapscheduler --version=3.5.0

    else
        helm upgrade -n nfs-provisioner \
        snapscheduler \
        backube/snapscheduler --version=3.5.0
    fi

    kubectl apply -f schedule.yml

else 
    helm uninstall --namespace=nfs-provisioner snapscheduler
fi


# https://backube.github.io/snapscheduler/

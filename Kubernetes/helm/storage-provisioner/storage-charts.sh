read -p "Install NFS storage provisioner (y/n): " INSTALL


if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install nfs-subdir-external-provisioner \
        -n nfs-provisioner --create-namespace \
        --kubeconfig=/home/zek/.kube/config_prd \
        --set nfs.server=10.0.0.146 \
        --set nfs.path=/volume1/k8data/default-storage \
        --set storageClass.defaultClass=true \
        --set replicaCount=1 \
        --set storageClass.name=nfs-01 \
        --set storageClass.provisionerName=nfs-provisioner-01  \
        nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --version=v4.0.18

    else
        helm upgrade -n nfs-provisioner \
        nfs-subdir-external-provisioner \
        --kubeconfig=/home/zek/.kube/config_prd \
        --set nfs.server=10.0.0.146 \
        --set nfs.path=/volume1/k8data/default-storage \
        --set storageClass.defaultClass=true \
        --set replicaCount=1 \
        --set storageClass.name=nfs-01 \
        --set storageClass.provisionerName=nfs-provisioner-01  \
        nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --version=v4.0.18
    fi

else 
    helm uninstall --kubeconfig=/home/zek/.kube/config_prd \
    --namespace=nfs-provisioner nfs-subdir-external-provisioner

fi
read -p "Install NFS storage provisioner (y/n): " INSTALL


if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install nfs-provisioner-db \
        -n nfs-provisioner --create-namespace \
        --kubeconfig=/home/zek/.kube/config_prd \
        --set nfs.server=10.0.0.146 \
        --set nfs.path=/volume1/ClusterDB \
        --set replicaCount=1 \
        --set storageClass.name=db-client \
        --set storageClass.provisionerName=nfs-provisioner-db  \
        nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --version=v4.0.18

    else
        helm upgrade -n nfs-provisioner \
        nfs-provisioner-db \
        --kubeconfig=/home/zek/.kube/config_prd \
        --set nfs.server=10.0.0.146 \
        --set nfs.path=/volume1/ClusterDB \
        --set replicaCount=1 \
        --set storageClass.name=db-client \
        --set storageClass.provisionerName=nfs-provisioner-db  \
        nfs-subdir-external-provisioner/nfs-subdir-external-provisioner --version=v4.0.18
    fi

else 
    helm uninstall --kubeconfig=/home/zek/.kube/config_prd \
    --namespace=nfs-provisioner nfs-provisioner-db

fi
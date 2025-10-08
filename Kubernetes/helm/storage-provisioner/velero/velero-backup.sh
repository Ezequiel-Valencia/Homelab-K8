read -p "Install Velero backup provider (y/n): " INSTALL

export KUBECONFIG=/home/zek/.kube/config_prd

if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install my-velero \
        -n nfs-provisioner --create-namespace \
        --set-file credentials.secretContents.cloud=minio-creds.txt \
        -f velero-values.yml \
        vmware-tanzu/velero --version=10.0.12

    else
        helm upgrade -n nfs-provisioner \
        my-velero \
        --set-file credentials.secretContents.cloud=minio-creds.txt \
        -f velero-values.yml \
        vmware-tanzu/velero --version=10.0.12
    fi

    kubectl apply -f velero-backup.yml

else 
    helm uninstall --namespace=nfs-provisioner my-velero
fi
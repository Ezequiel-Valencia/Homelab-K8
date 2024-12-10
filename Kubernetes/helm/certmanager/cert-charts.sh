read -p "Install Cert Manager (y/n): " INSTALL

# https://stackoverflow.com/questions/52486983/how-to-support-node-selection-when-using-helm-install
# Set desired node for deployment

if [ "$INSTALL" = "y" ]; then

    helm upgrade -n cert-manager cert-manager \
    --install \
    --kubeconfig=/home/zek/.kube/config_prd \
    jetstack/cert-manager -f certmanager-values.yml


else 
    helm --kubeconfig=/home/zek/.kube/config_prd \
    uninstall --namespace=cert-manager cert-manager

fi


read -p "Install Longhorn (y/n): " INSTALL

# https://stackoverflow.com/questions/52486983/how-to-support-node-selection-when-using-helm-install
# Set desired node for deployment

####################
## In Longhorn UI ##
#------------------#
# 1. Turn off storage usage for nonstorage nodes
# 2. Create a volume that persistent volume claim can use
# 3. Enable backup's
####################

if [ "$INSTALL" = "y" ]; then

    helm upgrade --install -n longhorn-system longhorn \
    --version 1.8.0 \
    --kubeconfig=/home/zek/.kube/config_prd \
    longhorn/longhorn -f longhorn-values.yml


else 
    helm --kubeconfig=/home/zek/.kube/config_prd \
    uninstall --namespace=longhorn-system longhorn

fi

read -p "Install Loki (y/n): " INSTALL

# https://stackoverflow.com/questions/52486983/how-to-support-node-selection-when-using-helm-install
# Set desired node for deployment

export KUBECONFIG=/home/zek/.kube/config_prd

if [ "$INSTALL" = "y" ]; then

    kubectl apply -f ./secrets/loki-htpasswd.yml
    kubectl apply -f ./secrets/loki-login-secret-logging.yml

    helm upgrade -n monitoring loki \
    --install \
    --version=6.40.0 \
    grafana/loki -f loki-values.yml


else 
    helm uninstall --namespace=monitoring loki

    kubectl delete -f ./secrets/loki-htpasswd.yml
    kubectl delete -f ./secrets/loki-login-secret-logging.yml

fi

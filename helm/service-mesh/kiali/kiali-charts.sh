read -p "Install Kiali (y/n): " INSTALL

export KUBECONFIG=/home/zek/.kube/config_prd

if [ "$INSTALL" = "y" ]; then

    helm upgrade --install \
    --namespace istio-system \
    --set auth.strategy="anonymous" \
    --repo https://kiali.org/helm-charts \
    -f config.yaml \
    kiali-server \
    kiali-server


else 
    helm uninstall --namespace=istio-system kiali-server

fi

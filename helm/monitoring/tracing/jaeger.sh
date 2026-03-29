read -p "Install Jaeger (y/n): " INSTALL
# https://artifacthub.io/packages/helm/jaegertracing/jaeger

if [ "$INSTALL" = "y" ]; then

    helm upgrade --install -n monitoring jaeger \
    --version 4.6.0 \
    --kubeconfig=/home/zek/.kube/config_prd \
    jaegertracing/jaeger -f values.yml \
    

else 
    helm --kubeconfig=/home/zek/.kube/config_prd \
    uninstall --namespace=monitoring jaeger

fi

read -p "Install Fluentbit (y/n): " INSTALL

export KUBECONFIG=/home/zek/.kube/config_prd


if [ "$INSTALL" = "y" ]; then

    helm upgrade --install --namespace monitoring \
    --version=0.53.0 \
    fluent-bit fluent/fluent-bit \
    -f fluent-values.yml

else 
    helm uninstall --namespace=monitoring fluent-bit

fi
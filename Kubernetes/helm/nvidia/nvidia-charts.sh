read -p "Install GPU Operator (y/n): " INSTALL

# For Debian systems you need to install the drivers manually instead of doing
# the container drivers.
# And set containerd to work with NVidia
# https://docs.nvidia.com/datacenter/cloud-native/gpu-operator/latest/getting-started.html
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

# Fix docker hanging problem (Containerd is not starting due to a config with "cri")
# https://serverfault.com/questions/1085068/containerd-failed-to-start-after-nvidia-config
# https://github.com/flatcar/Flatcar/issues/283


if [ "$INSTALL" = "y" ]; then

    read -p "Fresh Install (y/n): " FRESH

    if [ "$FRESH" = "y" ]; then
        helm install --wait gpu-operator \
        -n nvidia-gpu-operator --create-namespace \
        --kubeconfig=/home/zek/.kube/config_prd \
        -f nvidia-values.yml \
        nvidia/gpu-operator --version=v25.3.0

    else
        helm upgrade -n nvidia-gpu-operator \
        gpu-operator \
        --kubeconfig=/home/zek/.kube/config_prd \
        -f nvidia-values.yml \
        nvidia/gpu-operator --version=v25.3.0
    fi


else 
    helm uninstall --kubeconfig=/home/zek/.kube/config_prd \
    --namespace=nvidia-gpu-operator gpu-operator

fi
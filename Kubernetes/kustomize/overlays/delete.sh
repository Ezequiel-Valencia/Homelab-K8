

read -p "Delete Production (y/n): " PRODUCTION

if [ "$PRODUCTION" = "y" ]; then
kubectl kustomize \
    ./production \
    | kubectl delete --kubeconfig=/home/zek/.kube/config_prd -f -

else

kubectl kustomize \
    ./minikube \
    | kubectl delete -f -
fi

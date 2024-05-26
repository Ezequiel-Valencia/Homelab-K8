

read -s -p "Apply to Production (y/n): " PRODUCTION

if [PRODUCTION -eq "y"]; then
kubectl kustomize \
    ./production \
    | kubectl apply --kubeconfig=/home/zek/.kube/config_prd -f -

else

kubectl kustomize \
    ./minikube \
    | kubectl apply -f -
fi

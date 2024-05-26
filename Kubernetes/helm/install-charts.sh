#!/bin/bash

# Kustomize does allow for healm charts to be integrated, however, it seems that best practice
# is to treat the two seperately for now while helm integration in Kustomize is improved.

helm repo add traefik https://traefik.github.io/charts

helm install traefik traefik/traefik --version 28.1.0 --namespace traefik-ingress --values=/home/zek/Documents/Code/Homelab/Kubernetes/helm/minikube/traefik-values.yml

helm install cert-manager jetstack/cert-manager \
 --version v1.14.5 --create-namespace \
 --namespace cert-manager  \
 --values=/home/zek/Documents/Code/Homelab/Kubernetes/helm/minikube/certmanager-values.yml \
 --kubeconfig=/home/zek/.kube/config_prd

helm uninstall --namespace=traefik-ingress traefik

helm list --namespace=traefik-ingress --output yaml

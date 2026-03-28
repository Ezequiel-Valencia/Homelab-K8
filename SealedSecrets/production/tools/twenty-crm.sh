#!/usr/bin/env bash

SECRET_NAME="twenty-crm-secrets"
NAMESPACE="tools"

read -s -p "Database Password: " DB_PASSWORD
echo
read -s -p "Secret Key: " APP_SECRET # Generated via: head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo ''
echo

# specifying sslmode prevents connection from freezing
kubectl create secret generic ${SECRET_NAME} --dry-run=client \
      --from-literal=PG_DATABASE_URL="postgresql://twenty-crm:${DB_PASSWORD}@postgres.database.homelab.ezequielvalencia.com:5432/twenty-crm?sslmode=require" \
      --from-literal=APP_SECRET=${APP_SECRET} \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > twenty-crm.yml

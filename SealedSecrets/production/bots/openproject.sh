#!/usr/bin/env bash

SECRET_NAME="openproject-secrets"
NAMESPACE="bots"
read -s -p "Database Username: " DB_USERNAME
echo
read -s -p "Database Password: " DB_PASSWORD
echo
read -p "Database Name: " DB_NAME
read -s -p "Secret Key: " SECRET_KEY # Generated via: head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32 ; echo ''
echo
read -s -p "Hocus Key: " HOCUS_SECRET

kubectl create secret generic ${SECRET_NAME} --dry-run=client \
      --from-literal=DATABASE_URL="postgresql://${DB_USERNAME}:${DB_PASSWORD}@postgres.database.homelab.ezequielvalencia.com:5432/${DB_NAME}" \
      --from-literal=SECRET_KEY_BASE=${SECRET_KEY} \
      --from-literal=SECRET=${HOCUS_SECRET} \
      --from-literal=OPENPROJECT_COLLABORATIVE__EDITING__HOCUSPOCUS__SECRET=${HOCUS_SECRET} \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > openproject.yml
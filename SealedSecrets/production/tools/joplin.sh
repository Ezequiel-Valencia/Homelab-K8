#!/usr/bin/env bash

SECRET_NAME="joplin-secret"
NAMESPACE="tools"

read -p "Postgres User: " POSTGRES_USER
echo

read -s -p "Postgres Password: " POSTGRES_PASSWORD
echo

read -p "Postgres Database: " POSTGRES_DATABASE
echo

kubectl create secret generic ${SECRET_NAME} --dry-run=client \
      --from-literal=POSTGRES_USER="${POSTGRES_USER}" \
      --from-literal=POSTGRES_PASSWORD="${POSTGRES_PASSWORD}" \
      --from-literal=POSTGRES_DATABASE="${POSTGRES_DATABASE}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ./joplin.yml

#!/usr/bin/env bash

# Example: ./sealed_vpn.sh wireguard_key address mullvad > output.yaml

SECRET_NAME="aws-s3-bucket-secret"
NAMESPACE="longhorn-system"
read -s -p "Aws Longhorn User Access Key ID: " AWS_ACCESS_KEY_ID
echo
read -s -p "Aws Longhorn User Access Key Secret: " AWS_SECRET_ACCESS_KEY
echo
# https://www.civo.com/learn/backup-longhorn-volumes-to-a-minio-s3-bucket
echo "Now write the url in longhorn as s3://<bucket-name>@<region>/"

# Broken on purpose since it has production configurations, remove kubconfig flag to bring it back to test

kubectl create secret generic ${SECRET_NAME} --dry-run=client --kubeconfig=/home/zek/.kube/config_prd \
      --from-literal=AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}" \
      --from-literal=AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
      --namespace="${NAMESPACE}" -o yaml | \
      kubeseal --kubeconfig=/home/zek/.kube/config_prd \
      --controller-namespace=kube-system \
      --controller-name=sealed-secrets \
      --format yaml > ../aws-longhorn.yml
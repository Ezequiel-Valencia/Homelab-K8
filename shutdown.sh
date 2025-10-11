#!/bin/bash

set -euo pipefail
export KUBECONFIG=/home/zek/.kube/config_prd

echo "🔒 Cordoning all nodes..."
for node in $(kubectl get nodes --no-headers -o custom-columns=":metadata.name"); do
  echo " - Cordoning node: $node"
  kubectl cordon "$node"
done

echo "💨 Draining all nodes..."
for node in $(kubectl get nodes --no-headers -o custom-columns=":metadata.name"); do
  echo " - Draining node: $node"
  kubectl drain "$node" \
    --ignore-daemonsets \
    --delete-emptydir-data 
done

echo "✅ All nodes cordoned and drained successfully."

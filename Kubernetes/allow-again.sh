#!/bin/bash

set -euo pipefail
export KUBECONFIG=/home/zek/.kube/config_prd

echo "🔓 Uncordoning all nodes..."
for node in $(kubectl get nodes --no-headers -o custom-columns=":metadata.name"); do
  echo " - Uncordoning node: $node"
  kubectl uncordon "$node"
done

echo "✅ All nodes uncordoned and ready to accept new pods."

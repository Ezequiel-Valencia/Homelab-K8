
REPO_URL=https://github.com/kubernetes-csi/external-snapshotter
export KUBECONFIG=/home/zek/.kube/config_prd

# Why ?ref is added https://github.com/kubernetes-sigs/kustomize/blob/master/examples/remoteBuild.md?utm_source=chatgpt.com


kubectl kustomize ${REPO_URL}/client/config/crd?ref=v8.3.0 | kubectl apply -f -

kubectl -n kube-system kustomize ${REPO_URL}/deploy/kubernetes/snapshot-controller?ref=v8.3.0 | kubectl apply -f -


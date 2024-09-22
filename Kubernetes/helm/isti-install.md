# Installs default profile which is gateway and istiod
https://istio.io/latest/docs/setup/install/istioctl/
```
!#/bin/bash
istioctl install 
```

Install in addition to istio jaeger for tracing, and prometheus for metrics.
Double check that all node selections are done for monitoring.

```
kubectl apply -f istio-1.23.2/samples/addons/jaeger.yaml --kubeconfig=/home/zek/.kube/config_prd

kubectl apply -f istio-1.23.2/samples/addons/prometheus.yaml --kubeconfig=/home/zek/.kube/config_prd
```





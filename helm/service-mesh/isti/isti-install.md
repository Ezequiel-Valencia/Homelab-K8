# Installs default profile which is gateway and istiod
https://istio.io/latest/docs/setup/install/istioctl/
```
!#/bin/bash
./istio-1.23.2/bin/istioctl install --set profile=ambient --set "components.ingressGateways[0].enabled=true" --set "components.ingressGateways[0].name=istio-ingressgateway" --set meshConfig.outboundTrafficPolicy.mode=ALLOW_ANY --kubeconfig=/home/zek/.kube/config_prd
```
[Source](https://medium.com/@SabujJanaCodes/touring-the-kubernetes-istio-ambient-mesh-part-1-setup-ztunnel-c80336fcfb2d)

Install in addition to istio prometheus for metrics.
Double check that all node selections are done for monitoring.

```

kubectl apply -f istio-1.23.2/samples/addons/prometheus.yaml --kubeconfig=/home/zek/.kube/config_prd
```





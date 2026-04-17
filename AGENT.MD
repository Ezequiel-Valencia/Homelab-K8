# Homelab-K8 — Agent Context

This document summarizes the Kubernetes responsibilities managed in this repository to help an AI agent quickly orient itself.

---

## Overview

This is a production-grade homelab Kubernetes cluster managed with **Kustomize** (primary) and **Helm** (infrastructure). It runs on **K3s** and uses **Istio** (ambient profile) as the service mesh for all traffic management.

External access is handled via a **Cloudflare Tunnel** — no ports are directly exposed to the internet.

---

## Repository Layout

```
Homelab-K8/
├── kustomize/
│   ├── base/            # Reusable per-app resource definitions
│   │   ├── ai/
│   │   ├── bots/
│   │   ├── media/
│   │   ├── monitor/
│   │   ├── public-apps/
│   │   └── tools/
│   ├── overlays/
│   │   ├── production/  # Production-specific patches, routing, certs
│   │   └── minikube/    # Local dev overrides
│   └── config/          # Shared ConfigMaps (timezone, user config, etc.)
├── helm/
│   ├── monitoring/      # Grafana, Prometheus, Loki, Fluent-Bit, Jaeger
│   └── service-mesh/    # Istio, Kiali, Consul
├── SealedSecrets/
│   ├── production/      # Encrypted secrets per app
│   └── minikube/        # Encrypted secrets for dev
├── istio-1.26.3/        # Istio distribution (active)
├── Makefile             # Deployment targets
└── Notes.md             # Operational notes and troubleshooting
```

---

## Namespaces & Applications

| Namespace | Applications |
|---|---|
| `ai` | AI and workflow related applications |
| `bots` | Headless applications that perform basic tasks automatically. |
| `media` | Anything related to media |
| `tools` | Personal tools meant to be used only by trusted individuals |
| `public-apps` | Applications to the general public, and should have stricter guidelines. |
| `monitoring` | Applications that monitor the health of the K8 cluster, and maintain it. |
| `istio-system` | Istio gateway, Cloudflare Tunnel, Kiali |
| `cert-manager` | cert-manager, ClusterIssuers (Let's Encrypt) |
| `kube-registry` | Local Docker registry (NodePort 31000) |

> **Replica 0 = disabled.** Services are disabled by setting replicas to 0 in kustomize overlays rather than removing their definitions.

---

## Infrastructure Stack

| Layer | Tool |
|---|---|
| Kubernetes distro | K3s |
| Config management | Kustomize (apps), Helm (infra) |
| Service mesh | Istio v1.26.3 (ambient profile — ztunnel + CNI) |
| Ingress | Istio Ingress Gateway + Traefik (alternative) |
| External access | Cloudflare Tunnel (`cloudflared` in `istio-system`) |
| Certificates | cert-manager + Let's Encrypt (DNS01 via Cloudflare API) |
| Secrets | SealedSecrets (encrypted at rest in git) |
| Storage | NFS (10.0.0.146), Longhorn, local hostPath |
| Database | External database already setup for every type of database |
| Monitoring | Prometheus + Grafana + AlertManager + Loki + Promtail + Fluent-Bit + Jaeger |
| GPU | NVIDIA device plugin (Helm) |

---

## Key Configuration Patterns

### Kustomize Overlay Structure (Production)
The production overlay at `kustomize/overlays/production/kustomization.yml` composes all base resources and applies patches for:
- Security hardening (`hostUsers: false`)
- Resource requests/limits
- Replica counts (enable/disable apps)
- Environment variables from sealed secrets
- NFS volume mounts

### Storage Strategy
- **NFS** (`10.0.0.146:/mnt/...`) — shared storage for AI, tools, bots, public-apps
- **hostPath** — single-node storage for media and semaphore
- **Longhorn** — distributed PVs for services needing HA storage (not currently possible)

### Networking & Routing
- All HTTP/HTTPS traffic flows through the **Istio Ingress Gateway**
- Subdomains routed via **VirtualServices**: `*.homelab.ezequielvalencia.com`
- DNS override in production CoreDNS: `ezequielvalencia.com` → internal DNS (10.0.0.6)
- SSH for Gitea exposed on port 2222 via the Istio Gateway
- **NetworkPolicies** enforce namespace isolation (media stack especially locked down)

### Secrets
- All secrets are **SealedSecrets** — safe to commit to git
- Sealed with a cluster-specific key; must be re-sealed if the key rotates
- Located in `SealedSecrets/production/<app>/`

### Monitoring
- Prometheus scrapes cluster metrics; Grafana provides dashboards
- Logs: Promtail ships pod logs → Loki; Fluent-Bit is available as an alternative collector
- Alerts: AlertManager configured alongside Prometheus

---

## Makefile Targets

| Target | What it applies |
|---|---|
| `make homelab` | Full production overlay (all namespaces) |
| `make monitor` | Monitoring stack (Helm) |
| `make tools` | `tools` namespace |
| `make media` | `media` namespace |
| `make ai` | `ai` namespace |
| `make bots` | `bots` namespace |
| `make public_apps` | `public-apps` namespace |
| `make service_mesh` | Istio + Kiali (Helm) |

---

## Domain & Certificates

- Primary domain: `ezequielvalencia.com`
- Homelab subdomain: `*.homelab.ezequielvalencia.com`
- Certificates issued by Let's Encrypt via **DNS01 challenge** (Cloudflare)
- ClusterIssuer defined in `kustomize/overlays/production/certs.yml`

---

## Agent Responsibilities When Working Here

1. **Editing an app** — find its base YAML in `kustomize/base/<category>/`, check `kustomize/overlays/production/` for patches.
2. **Enabling/disabling a service** — change `replicas` in the production overlay's kustomization patches, not in the base.
3. **Adding a secret** — create a SealedSecret in `SealedSecrets/production/<app>/` and reference it in the deployment env.
4. **Adding a new app** — create a base directory, add a `kustomization.yml`, reference it in the production overlay, add a VirtualService entry in `kustomize/overlays/production/servicemesh/`.
5. **Touching storage** — prefer NFS for apps that need shared or persistent data; use hostPath only for single-node media workloads.
6. **Monitoring changes** — Helm values live in `helm/monitoring/<tool>/values.yml`; apply with `make monitor`.
7. **Database changes** — Schema migrations are the applications responsibility.

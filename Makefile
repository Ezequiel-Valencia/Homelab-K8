.PHONY: check
check: ## Run code quality tools.
	@echo "🚀 Checking"

.PHONY: bots
bots:
	@echo "🚀 Making bots"
	@kubectl kustomize kustomize/overlays/production/bots | kubectl apply -f -

.PHONY: tools
tools:
	@echo "🚀 Making bots"
	@kubectl kustomize kustomize/overlays/production/tools | kubectl apply -f -

.PHONY: media
media:
	@echo "🚀 Making media"
	@kubectl kustomize kustomize/overlays/production/media | kubectl apply -f -

.PHONY: monitor
monitor:
	@echo "🚀 Making monitor"
	@kubectl kustomize kustomize/overlays/production/monitor | kubectl apply -f -

.PHONY: ai
ai:
	@echo "🚀 Making AI"
	@kubectl kustomize kustomize/overlays/production/ai | kubectl apply -f -

.PHONY: public_apps
public_apps:
	@echo "🚀 Making Public Apps"
	@kubectl kustomize kustomize/overlays/production/public-apps | kubectl apply -f -

.PHONY: service_mesh
service_mesh:
	@echo "🚀 Making Service Mesh"
	@kubectl kustomize kustomize/overlays/production/servicemesh | kubectl apply -f -

.PHONY: check_homelab_diff
check_homelab_diff:
	@echo "🚀 Showing Diff Between Code and Production"
	@kubectl kustomize kustomize/overlays/production | kubectl diff -f -

.PHONY: homelab
homelab:
	@echo "🚀 Making Entire Homelab"
	@kubectl kustomize kustomize/overlays/production | kubectl apply -f -


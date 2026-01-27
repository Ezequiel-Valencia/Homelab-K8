.PHONY: check
check: ## Run code quality tools.
	@echo "🚀 Checking"

.PHONY: bots
bots:
	@echo "🚀 Making bots"
	@kubectl kustomize kustomize/overlays/production/bots | kubectl apply -f -


.PHONY: media
media:
	@echo "🚀 Making bots"
	@kubectl kustomize kustomize/overlays/production/media | kubectl apply -f -

.PHONY: monitor
monitor:
	@echo "🚀 Making bots"
	@kubectl kustomize kustomize/overlays/production/monitor | kubectl apply -f -

.PHONY: ai
ai:
	@echo "🚀 Making bots"
	@kubectl kustomize kustomize/overlays/production/ai | kubectl apply -f -

.PHONY: homelab
homelab:
	@echo "🚀 Making bots"
	@kubectl kustomize kustomize/overlays/production | kubectl apply -f -


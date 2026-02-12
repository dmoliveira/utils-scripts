.PHONY: help install-mac install-unix install-debian verify

help: ## Show available commands
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z_-]+:.*## / {printf "%-16s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install-mac: ## Run macOS installer
	./install_my_programs_mac

install-unix: ## Run generic Unix installer
	./install_my_programs_unix

install-debian: ## Run Debian/Ubuntu installer
	./install_my_programs_debian

verify: ## Run post-install smoke verification
	./verify_post_install_unix

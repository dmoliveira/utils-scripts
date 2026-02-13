.PHONY: help install-mac install-unix install-debian verify verify-strict verify-json bootstrap-secrets doctor verify-linux playbook leader-pack-check

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

verify-strict: ## Run verification in strict mode
	./verify_post_install_unix --strict

verify-json: ## Run verification and print JSON summary
	./verify_post_install_unix --json

bootstrap-secrets: ## Interactive setup for shell secrets file
	./bootstrap_shell_secrets

doctor: ## Run strict verification with guided hints
	./doctor_post_install_unix

verify-linux: ## Run Linux edge-case command checks
	./verify_linux_edge_cases

playbook: ## Show terminal playbook path
	@printf "Open: TERMINAL_PLAYBOOK.md\n"

leader-pack-check: ## Validate leader-pack docs and zsh template
	@test -f TERMINAL_PLAYBOOK.md
	@zsh -n run_commands/my_zshrc
	@printf "Leader pack checks passed.\n"

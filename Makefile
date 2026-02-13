.PHONY: help install-mac install-unix install-debian verify verify-strict verify-json bootstrap-secrets doctor verify-linux playbook leader-pack-check rollback rollback-dry-run shell-lint

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

rollback: ## Restore latest installer backups
	./rollback_installer_backups

rollback-dry-run: ## Preview rollback actions without file changes
	./rollback_installer_backups --dry-run

shell-lint: ## Run shellcheck and shfmt on shell scripts
	@bash -lc 'set -euo pipefail; \
	mapfile -t files < <(git ls-files | while IFS= read -r f; do [[ -f "$$f" ]] || continue; first="$$(head -n 1 "$$f" 2>/dev/null || true)"; if [[ "$$first" =~ ^#!/usr/bin/env\ (bash|sh)$$ || "$$first" =~ ^#!/bin/(bash|sh)$$ ]]; then printf "%s\n" "$$f"; fi; done); \
	if [[ "$${#files[@]}" -eq 0 ]]; then echo "No shell files found to lint."; exit 0; fi; \
	shellcheck -S warning "$${files[@]}"; \
	shfmt -d -i 2 -ci "$${files[@]}"'

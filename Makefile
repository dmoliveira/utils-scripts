.PHONY: help install-mac install-unix install-debian verify verify-strict verify-json bootstrap-secrets doctor doctor-full verify-linux playbook docs-browse leader-pack-check rollback rollback-dry-run shell-lint hooks-install pre-commit-install pre-commit-run git-delta-config wiki-build wiki-build-check wiki-source-check wiki-sidebar-check docs-hub-check docs-make-target-check continue-tag-check release-template-check release-docs-check workflow-inventory-check core-commands-check docs-assets-check cheatsheet-index-check quick-cards-check top10-cards-check golden-path-guards-check quick-commands-sync-check smoke-guards-check ci-quick-guards-check ci-quick release-precheck

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

doctor-full: ## Run full local quality + verification suite
	@bash -lc 'set -euo pipefail; \
	make shell-lint; \
	pre-commit run --all-files; \
	bash -n install_my_programs_unix install_my_programs_mac install_my_programs_debian verify_post_install_unix install_git_hooks configure_git_delta; \
	zsh -n run_commands/my_zshrc; \
	./verify_post_install_unix --strict'

verify-linux: ## Run Linux edge-case command checks
	./verify_linux_edge_cases

playbook: ## Show terminal playbook path
	@printf "Open: TERMINAL_PLAYBOOK.md\n"

docs-browse: ## Browse markdown docs with fzf + glow preview
	@bash -lc 'if ! command -v fd >/dev/null 2>&1 || ! command -v fzf >/dev/null 2>&1 || ! command -v glow >/dev/null 2>&1; then echo "requires fd, fzf, and glow"; exit 1; fi; fd -e md docs | fzf --preview "glow -p {}" --preview-window=right:70%'

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
	files=(); \
	while IFS= read -r f; do files+=("$$f"); done < <(./scripts/list_shell_files.sh); \
	if [[ "$${#files[@]}" -eq 0 ]]; then echo "No shell files found to lint."; exit 0; fi; \
	shellcheck -S warning "$${files[@]}"; \
	shfmt -d -i 2 -ci "$${files[@]}"'

hooks-install: ## Install repo git hooks into .git/hooks
	./install_git_hooks

pre-commit-install: ## Install and activate pre-commit hooks for this repo
	pre-commit install
	pre-commit install --hook-type pre-push

pre-commit-run: ## Run all pre-commit checks on repository files
	pre-commit run --all-files

git-delta-config: ## Configure global git delta defaults
	./configure_git_delta

wiki-build: ## Build wiki payload from docs and wiki source
	./scripts/build_wiki_payload.sh

wiki-build-check: ## Build wiki payload and verify expected links/files
	./scripts/check_wiki_payload.sh

wiki-source-check: ## Validate links inside wiki source pages
	./scripts/check_wiki_source.sh

wiki-sidebar-check: ## Validate core links in wiki sidebar source
	./scripts/check_wiki_sidebar_source.sh

docs-hub-check: ## Validate docs hub files and core cross-links
	./scripts/check_docs_hub.sh

docs-make-target-check: ## Validate make targets referenced in docs
	./scripts/check_docs_make_targets.sh

continue-tag-check: ## Validate continue marker in key docs/wiki pages
	./scripts/check_continue_tag.sh

release-template-check: ## Validate release template headings/placeholders
	./scripts/check_release_template.sh

release-docs-check: ## Validate release docs command consistency
	./scripts/check_release_docs_consistency.sh

workflow-inventory-check: ## Validate required CI workflows and README references
	./scripts/check_workflow_inventory.sh

core-commands-check: ## Validate core command docs alignment
	./scripts/check_core_commands_docs.sh

docs-assets-check: ## Validate docs hero asset and references
	./scripts/check_docs_assets.sh

cheatsheet-index-check: ## Validate cheatsheets index references all cheatsheets
	./scripts/check_cheatsheet_index.sh

quick-cards-check: ## Validate quick card docs and wiki links
	./scripts/check_quick_cards.sh

top10-cards-check: ## Validate top-10 cards contain ten numbered items
	./scripts/check_top10_cards.sh

golden-path-guards-check: ## Validate golden path workflow safety guards
	./scripts/check_golden_path_guards.sh

quick-commands-sync-check: ## Validate shared quick commands across README/docs
	./scripts/check_quick_commands_sync.sh

smoke-guards-check: ## Validate smoke workflow guard coverage
	./scripts/check_smoke_guards.sh

ci-quick-guards-check: ## Validate ci-quick includes required guard steps
	./scripts/check_ci_quick_guards.sh

ci-quick: ## Run fast CI-equivalent guards (no full doctor)
	@bash -lc 'set -euo pipefail; \
	pre-commit run --all-files; \
	make docs-hub-check; \
	make docs-make-target-check; \
	make continue-tag-check; \
	make wiki-source-check; \
	make wiki-sidebar-check; \
	make wiki-build-check; \
	make release-template-check; \
	make release-docs-check; \
	make workflow-inventory-check; \
	make core-commands-check; \
	make docs-assets-check; \
	make cheatsheet-index-check; \
	make quick-cards-check; \
	make top10-cards-check; \
	make golden-path-guards-check; \
	make quick-commands-sync-check; \
	make smoke-guards-check'

release-precheck: ## Run release safety checks before tagging
	@bash -lc 'set -euo pipefail; \
	make ci-quick; \
	make ci-quick-guards-check; \
	make doctor-full'

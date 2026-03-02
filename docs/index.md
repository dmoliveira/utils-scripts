# utils-scripts Documentation

![utils-scripts hero image](assets/hero-gpt-image-1.svg)

> Build a reliable terminal workstation in minutes, then keep it healthy with repeatable checks.

[![Docs: GitHub Pages](https://img.shields.io/badge/Docs-GitHub%20Pages-2ea44f?logo=github)](https://dmoliveira.github.io/utils-scripts/)
[![Platform](https://img.shields.io/badge/Platform-Debian%20%7C%20macOS-lightgrey.svg)](../README.md#supported-platforms)
[![License: GPL-2.0](https://img.shields.io/badge/License-GPL--2.0-blue.svg)](../LICENSE)
[![Donate via Stripe](https://img.shields.io/badge/Donate-Stripe-blue?logo=stripe&logoColor=white)](https://buy.stripe.com/8x200i8bSgVe3Vl3g8bfO00)

## Pick a path

| New here | Already fast in terminal workflows |
| --- | --- |
| [Getting Started](getting-started.md) | [Power User Workflows](power-user.md) |
| [Top 10 New User Commands](top-10-new-user-commands.md) | [Cheatsheets Index](cheatsheets/index.md) |
| [Troubleshooting](troubleshooting.md) | [Terminal Playbook](../TERMINAL_PLAYBOOK.md) |
| [Support and Donate](support.md) | [Top 10 Power User Commands](top-10-power-user-commands.md) |
| [Donation Impact](donation-impact.md) | [Top 10 Release Maintainer Commands](top-10-release-maintainer-commands.md) |

## What this docs site gives you

- practical install + verify flow for macOS and Debian/Ubuntu
- command-focused references for day-to-day delivery work
- release and CI guardrails to keep docs and scripts in sync
- a mirrored wiki source in `wiki/` for GitHub Wiki publishing

## Workflow map

- **Install:** `install_my_programs_mac`, `install_my_programs_debian`, `install_my_programs_unix`
- **Verify:** `verify_post_install_unix`, `doctor_post_install_unix`, `verify_linux_edge_cases`
- **Operate:** `run_commands/` templates + `TERMINAL_PLAYBOOK.md`
- **Maintain:** CI workflows, tag-based releases, docs publishing

## Quick command deck

```bash
make help
make verify
make tmux-self-heal
make doctor
make ci-quick
make docs-browse
make release-precheck
make release-docs-check
make workflow-inventory-check
make core-commands-check
make docs-assets-check
make cheatsheet-index-check
make quick-cards-check
make top10-cards-check
make golden-path-guards-check
make ci-quick-guards-check
make wiki-sidebar-check
make docs-hub-check
```

For the full guard list, see [Release Flow](release-flow.md) and [Workflow Matrix](workflow-matrix.md).

## Continue keyword

Use `CONTINUE_TAG: #continue-utils` to mark follow-up work in release notes and issue threads.

## Wiki mirror

Repository wiki source lives in `wiki/` and is synced by `.github/workflows/wiki-sync.yml`.

# utils-scripts Documentation

![utils-scripts hero image](assets/hero-gpt-image-1.svg)

> Build a reliable terminal workstation in minutes, then keep it healthy with repeatable checks.

[![Docs: GitHub Pages](https://img.shields.io/badge/Docs-GitHub%20Pages-2ea44f?logo=github)](https://dmoliveira.github.io/utils-scripts/)
[![Platform](https://img.shields.io/badge/Platform-Debian%20%7C%20macOS-lightgrey.svg)](../README.md#supported-platforms)
[![License: GPL-2.0](https://img.shields.io/badge/License-GPL--2.0-blue.svg)](../LICENSE)
[![Donate via Stripe](https://img.shields.io/badge/Donate-Stripe-blue?logo=stripe&logoColor=white)](https://buy.stripe.com/8x200i8bSgVe3Vl3g8bfO00)

## Start in 60 seconds

```bash
git clone https://github.com/dmoliveira/utils-scripts.git
cd utils-scripts
make install-mac    # or: make install-debian / make install-unix
exec zsh
make verify
```

Like the toolkit? [Donate here](https://buy.stripe.com/8x200i8bSgVe3Vl3g8bfO00) or share it with your team.

### Choose your first action

1. Need a clean environment now? Start with [Getting Started](getting-started.md).
2. Want fast command recall? Jump to [Cheatsheets Index](cheatsheets/index.md).
3. Maintaining quality and releases? Open [Release Flow](release-flow.md).

## Pick a path

### 🚀 Start Fast

Get a clean baseline quickly.

- [Getting Started](getting-started.md)
- [Top 10 New User Commands](top-10-new-user-commands.md)
- [Troubleshooting](troubleshooting.md)
- [Support and Donate](support.md)

### ⚡ Ship Daily

Tighten loops and sharpen command muscle memory.

- [Power User Workflows](power-user.md)
- [Cheatsheets Index](cheatsheets/index.md)
- [Terminal Playbook](../TERMINAL_PLAYBOOK.md)
- [Top 10 Power User Commands](top-10-power-user-commands.md)

### 🛠️ Maintain Releases

Keep docs, checks, and release flow aligned.

- [Release Flow](release-flow.md)
- [Workflow Matrix](workflow-matrix.md)
- [Top 10 Release Maintainer Commands](top-10-release-maintainer-commands.md)
- [Donation Impact](donation-impact.md)

## What this docs site gives you

- install + verify flow for macOS and Debian/Ubuntu
- command references for daily delivery work
- release and CI guardrails that keep docs/scripts aligned
- wiki source in `wiki/` for GitHub Wiki sync

## Why teams keep this bookmarked

| You get | Why it matters |
| --- | --- |
| Repeatable bootstrap steps | New machines become productive faster with less drift |
| Practical command references | Onboarding and day-to-day work stay consistent |
| Guarded release checks | Docs, CI, and scripts stay aligned as the repo evolves |

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

Use `CONTINUE_TAG: #continue-utils` for follow-up work in release notes and issue threads.

## Wiki mirror

Wiki source lives in `wiki/` and syncs via `.github/workflows/wiki-sync.yml`.

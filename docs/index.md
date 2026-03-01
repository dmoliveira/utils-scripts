# utils-scripts Documentation

Welcome. This is the docs home for setup, workflows, and contribution paths.

![utils-scripts hero image](assets/hero-gpt-image-1.svg)

If you are new, start with `getting-started.md`. If you already ship fast in terminal workflows, jump to `power-user.md` and `cheatsheets/index.md`.

## Read by audience

### New users

1. [Getting Started](getting-started.md)
2. [Troubleshooting](troubleshooting.md)
3. [Support and Donate](support.md)
4. [Donation Impact](donation-impact.md)
5. [Workflow Matrix](workflow-matrix.md)
6. [Top 10 New User Commands](top-10-new-user-commands.md)

### Power users

1. [Power User Workflows](power-user.md)
2. [Cheatsheets Index](cheatsheets/index.md)
3. [Terminal Playbook](../TERMINAL_PLAYBOOK.md)
4. [Release Flow](release-flow.md)
5. [Workflow Matrix](workflow-matrix.md)
6. [Top 10 Power User Commands](top-10-power-user-commands.md)
7. [Top 10 Release Maintainer Commands](top-10-release-maintainer-commands.md)

## Workflow map

- **Install:** `install_my_programs_mac`, `install_my_programs_debian`, `install_my_programs_unix`
- **Verify:** `verify_post_install_unix`, `doctor_post_install_unix`, `verify_linux_edge_cases`
- **Operate:** `run_commands/` templates + `TERMINAL_PLAYBOOK.md`
- **Maintain:** CI workflows, tag-based releases, docs publishing

## Quick commands

```bash
make help
make verify
make ci-quick
make doctor
make docs-browse
make release-precheck
make release-docs-check
make docs-hub-check
```

## Continue keyword

Use `CONTINUE_TAG: #continue-utils` to mark follow-up work in release notes and issue threads.

## Wiki mirror

Repository wiki source lives in `wiki/` and is synced by `.github/workflows/wiki-sync.yml`.

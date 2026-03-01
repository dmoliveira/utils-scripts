# Getting Started

This guide helps you go from clone to verified setup quickly and safely.

## 1) Clone and inspect options

```bash
git clone https://github.com/dmoliveira/utils-scripts.git
cd utils-scripts
make help
```

## 2) Choose your installer

```bash
make install-mac
# or
make install-debian
# or
make install-unix
```

If you want a preview before changing your machine, run the installer script with `--dry-run`.

## 3) Verify your environment

```bash
make verify
make doctor
```

Use `make verify-strict` when you want warnings to fail fast.

## 4) Enable quality gates

```bash
make hooks-install
make pre-commit-install
```

## 5) First productive session

```bash
exec zsh
tmux new -s daily
nvim notes.md
```

## What you get

- shell templates (`zsh`, `starship`, `tmux`)
- practical editor defaults (`nvim`)
- verification and doctor scripts for confidence
- playbooks and cheatsheets for higher throughput

If you get blocked, go to `troubleshooting.md`.

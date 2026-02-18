# direnv Cheatsheet

Safe, repeatable per-project environment loading.

## Core workflow

1. Copy `.envrc.example` to `.envrc`.
2. Keep `.envrc` non-secret.
3. Run `direnv allow`.
4. Re-run `direnv allow` after each `.envrc` edit.

## Top commands

```bash
direnv allow
direnv deny
direnv reload
direnv status
direnv exec . env | rg APP_ENV
```

## Team template flow

```bash
cp .envrc.example .envrc
cp .env.local.example .env.local
direnv allow
```

## Secrets pattern

Use a machine-local file outside the repo:

```bash
~/.config/secrets/my-project.env
chmod 600 ~/.config/secrets/my-project.env
```

Load it from `.envrc`:

```bash
source_env_if_exists ~/.config/secrets/my-project.env
```

## Helper functions from template

```bash
da       # direnv allow .
ddeny    # direnv deny .
dstatus  # direnv status
```

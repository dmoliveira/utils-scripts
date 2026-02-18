# direnv Cheatsheet

Safe, repeatable per-project environment loading for shell workflows.

## Core workflow

1. Create `.envrc` in project root.
2. Keep `.envrc` non-secret and deterministic.
3. Run `direnv allow`.
4. Re-run `direnv allow` every time `.envrc` changes.

## Top commands

```bash
direnv allow
direnv deny
direnv reload
direnv status
direnv exec . env | rg APP_ENV
```

## Team-ready template flow

```bash
cp .envrc.example .envrc
cp .env.local.example .env.local
direnv allow
```

## Recommended `.envrc` pattern

```bash
PATH_add ./bin

if [ -f .venv/bin/activate ]; then
  source .venv/bin/activate
fi

export APP_ENV=dev
export LOG_LEVEL=info

dotenv_if_exists .env
dotenv_if_exists .env.local

source_env_if_exists ~/.config/secrets/my-project.env
```

## Security reference file

Use a machine-local file outside the repo for secrets:

```bash
~/.config/secrets/my-project.env
chmod 600 ~/.config/secrets/my-project.env
```

Example:

```bash
export OPENAI_API_KEY=...
export DATABASE_URL=...
```

## Can direnv be always allowed?

Possible, but not recommended. Default `direnv allow` checks protect you from malicious `.envrc` files.

Safer productivity helpers from this template:

```bash
da        # direnv allow .
ddeny     # direnv deny .
dstatus   # direnv status
```

## Troubleshooting

### Blocked `.envrc`

```bash
direnv allow
```

### Changes not applied

```bash
direnv reload
direnv status
exec zsh
```

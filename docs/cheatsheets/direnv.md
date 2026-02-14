# direnv Cheatsheet

Safe, repeatable per-project environment loading for shell workflows.

## Start

```bash
direnv version
direnv status
```

## Core workflow

1. create `.envrc` in project root
2. add only project-specific exports
3. run `direnv allow`
4. verify vars load when entering directory

Example:

```bash
cat > .envrc <<'EOF'
export APP_ENV=dev
export PYTHONPATH=$PWD
EOF

direnv allow
```

## Useful commands

```bash
direnv allow
direnv deny
direnv reload
direnv status
```

## Python/venv patterns

```bash
echo 'layout python3' >> .envrc
direnv allow
```

For existing virtualenv:

```bash
echo 'source .venv/bin/activate' >> .envrc
direnv allow
```

## Secrets hygiene pattern

Keep secrets outside repo and source them from a safe path:

```bash
echo 'source_env "$HOME/.config/secrets/shell.env"' >> .envrc
direnv allow
```

Use with repo convention:

```bash
chmod 600 ~/.config/secrets/shell.env
```

## Practical workflows

### Flow 1: project bootstrap

```bash
cp .envrc.example .envrc
direnv allow
make verify
```

### Flow 2: fast context switching

```bash
z project-a
z project-b
```

`direnv` auto-loads each project environment on directory change.

### Flow 3: temporary debug flags

```bash
echo 'export DEBUG=true' >> .envrc
direnv reload
```

Remove the line after debugging and reload again.

## Troubleshooting

### Changes not applied

```bash
direnv reload
direnv status
```

### "blocked" .envrc

```bash
direnv allow
```

### verify shell hook loaded

This repo template includes:

```zsh
eval "$(direnv hook zsh)"
```

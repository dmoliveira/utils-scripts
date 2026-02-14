# make Cheatsheet

Fast access to repo workflows via Make targets.

## Start

```bash
make help
```

## Core targets

```bash
make install-mac
make install-unix
make install-debian
make verify
make verify-strict
make verify-json
```

## Quality and diagnostics

```bash
make doctor
make verify-linux
make shell-lint
make leader-pack-check
```

## Workflow targets

```bash
make playbook
make rollback-dry-run
make rollback
make bootstrap-secrets
```

## Practical flows

### Flow 1: new machine bootstrap (safe)

```bash
make install-mac
make verify
make doctor
```

### Flow 2: pre-PR local gate

```bash
make shell-lint
make verify
make verify-json
```

### Flow 3: config rollback after bad apply

```bash
make rollback-dry-run
make rollback
make verify
```

## CI parity flow

Use these locally to mirror CI expectations:

```bash
make shell-lint
make verify
```

## Troubleshooting

### target not found

```bash
make help
```

### failing verification

Run guided diagnostics:

```bash
make doctor
```

# Troubleshooting

## Command variants on Linux

```bash
make verify-linux
```

## Strict verification failures

```bash
make doctor
```

## Hooks not installed

```bash
make hooks-install
make pre-commit-install
```

## Rollback after installer run

```bash
make rollback-dry-run
make rollback
```

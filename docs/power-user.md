# Power User Workflows

Use this guide to maximize signal and minimize setup drag.

## Daily flow (high leverage)

1. `br ready` and pick one issue
2. use tmux layout (`tmux-research`, `tmux-delivery`, or `tmux-incident`)
3. run tight loop with `watchexec`, `make verify`, and `lazygit`
4. close with `make doctor-full` before release/tag

## Profiled command loops

```bash
hyperfine --warmup 1 'python script.py' 'uv run python script.py'
watchexec -e py,sh,lua,md 'make verify'
```

## Reliability checks before merge

```bash
make shell-lint
pre-commit run --all-files
make verify-strict
trivy fs .
```

## Docs and discoverability loops

- keep updates in `README.md`, `docs/`, and `wiki/` aligned
- prefer short command examples that people can paste
- add the follow-up marker `CONTINUE_TAG: #continue-utils` for remaining tasks

## Incident mode checklist

```bash
tmux-incident
procs --sortd cpu
kubectl get pods -A
doggo github.com MX
```

Use `TERMINAL_PLAYBOOK.md` for scenario-specific walkthroughs.

# Terminal Playbook

This playbook turns the installed CLI stack into practical workflows for day-to-day engineering leadership.

## Quick Start

1. Open your terminal and load the repo template shell config (`run_commands/my_zshrc`).
2. Run `leader-pack-help` to see the helper shortcuts.
3. Start with one of the tmux layouts:
   - `tmux-research`
   - `tmux-delivery`
   - `tmux-incident`

Tool-specific cheatsheets:
- `docs/cheatsheets/tmux.md`
- `docs/cheatsheets/zsh.md`
- `docs/cheatsheets/nvim.md`
- `docs/cheatsheets/starship.md`
- `docs/cheatsheets/lazygit.md`

## Tool Guide

### Monitoring and system health

- `btop`: unified CPU, memory, process, network, and disk view.
  - `btop`
- `btm` (bottom): alternative monitor with compact table-heavy UI.
  - `btm`
- `asitop` (Apple Silicon when available): SoC power and thermal metrics.
  - `asitop`
- `procs`: fast process filter for troubleshooting spikes.
  - `procs --sortd cpu`
  - `procs python`

### Git and delivery

- `lazygit`: interactive staging/review/commit flow.
  - `lazygit`
- `watchexec`: rerun checks while files change.
  - `watchexec -e py,sh,lua,md 'make verify'`
- `trivy`: quick security scan for repo or container image.
  - `trivy fs .`
  - `trivy image python:3.12`

### Performance and size analysis

- `hyperfine`: benchmark command alternatives with repeatable timing.
  - `hyperfine --warmup 1 'python script.py' 'uv run python script.py'`
- `dua`: interactive disk usage explorer.
  - `dua i`
- `dust`: quick top-heavy folder summary.
  - `dust -d 3`

### API, DNS, and platform operations

- `xh`: readable HTTP client for API checks.
  - `xh GET https://api.github.com/repos/dmoliveira/utils-scripts`
- `doggo`: DNS inspection for incident/debug sessions.
  - `doggo openai.com A`
  - `doggo github.com MX`
- `kubectl`: Kubernetes CLI control plane.
  - `kubectl get pods -A`
- `k9s`: Kubernetes TUI for fast triage.
  - `k9s`
- `zellij`: optional terminal workspace manager.
  - `zellij`

## Scenario Playbooks

### Scenario 1: Performance regression in training pipeline

1. Start `tmux-research`.
2. In benchmark window, compare new and old commands:
   - `hyperfine --warmup 1 'python train_old.py' 'python train_new.py'`
3. In monitor window, track resource bottlenecks with `btop`.
4. In git window, isolate and review deltas with `lazygit`.

### Scenario 2: Release hardening before merge

1. Start `tmux-delivery`.
2. Keep `watchexec` running `make verify` on changes.
3. Run `trivy fs .` in security window before final push.
4. Use `lazygit` to stage clean commits and verify diff scope.

### Scenario 3: Production incident triage

1. Start `tmux-incident`.
2. Monitor machine pressure (`btop`) and process outliers (`procs --sortd cpu`).
3. Switch to `k9s` for cluster/pod status, then confirm via `kubectl`.
4. Use `doggo` to validate DNS when services look unreachable.

## Suggested Team Habits

- Keep one named tmux session per project stream (research, delivery, incident).
- Run `trivy fs .` at least once before opening a PR.
- Use `hyperfine` for any performance claim in reviews.
- Use `dua i` weekly to avoid disk growth surprises on data projects.

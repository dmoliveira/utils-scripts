# Workflow Matrix

Use this matrix to pick the shortest path for your goal.

## New users

| Goal | Command path | Outcome |
| --- | --- | --- |
| First install | `make help` then `make install-mac` or `make install-debian` | Working terminal stack |
| Verify setup | `make verify` then `make doctor` | Fast confidence check |
| Safe rollback | `make rollback-dry-run` then `make rollback` | Revert recent installer changes |
| Start daily use | `exec zsh` then `tmux new -s daily` | Productive baseline session |

## Power users

| Goal | Command path | Outcome |
| --- | --- | --- |
| Fast edit/verify loop | `tmux-delivery` and `watchexec -e py,sh,lua,md 'make verify'` | Tight feedback cycle |
| Incident triage | `tmux-incident`, `procs --sortd cpu`, `kubectl get pods -A` | Faster diagnosis |
| Performance claims | `hyperfine --warmup 1 '<old>' '<new>'` | Reproducible benchmarks |
| Security pass | `trivy fs .` | Early risk visibility |

## Release maintainers

| Goal | Command path | Outcome |
| --- | --- | --- |
| Pre-release gate | `make doctor-full` | Lint + verification confidence |
| Tag and publish | `git tag vX.Y.Z && git push origin vX.Y.Z` | Automated release workflow |
| Keep wiki in sync | `make wiki-build` | Preview mirrored wiki payload |

`CONTINUE_TAG: #continue-utils`

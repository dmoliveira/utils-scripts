# Workflow Matrix

Use this matrix to pick the shortest path for your goal.

## New users

| Goal | Command path | Outcome |
| --- | --- | --- |
| First install | `make help` then `make install-mac` or `make install-debian` | Working terminal stack |
| Verify setup | `make verify` then `make doctor` | Fast confidence check |
| Safe rollback | `make rollback-dry-run` then `make rollback` | Revert recent installer changes |
| Start daily use | `exec zsh` then `tmux new -s daily` | Productive baseline session |
| Memorize essentials | Read `top-10-new-user-commands.md` | Faster onboarding loop |

## Power users

| Goal | Command path | Outcome |
| --- | --- | --- |
| Fast edit/verify loop | `tmux-delivery` and `watchexec -e py,sh,lua,md 'make verify'` | Tight feedback cycle |
| Incident triage | `tmux-incident`, `procs --sortd cpu`, `kubectl get pods -A` | Faster diagnosis |
| Performance claims | `hyperfine --warmup 1 '<old>' '<new>'` | Reproducible benchmarks |
| Security pass | `trivy fs .` | Early risk visibility |
| Memorize essentials | Read `top-10-power-user-commands.md` | Higher daily throughput |

## Release maintainers

| Goal | Command path | Outcome |
| --- | --- | --- |
| Release safety gate | `make release-precheck` | Combined release readiness checks (`ci-quick` + `doctor-full`) |
| Pre-release gate | `make doctor-full` | Lint + verification confidence |
| Tag and publish | `git tag vX.Y.Z && git push origin vX.Y.Z` | Automated release workflow |
| Keep wiki in sync | `make wiki-build` | Preview mirrored wiki payload |
| Guard wiki payload | `make wiki-build-check` | Catch sidebar/index regressions |
| Guard wiki source links | `make wiki-source-check` | Catch broken links in `wiki/*.md` |
| Guard wiki sidebar source | `make wiki-sidebar-check` | Keep core wiki sidebar links consistent |
| Guard docs hub | `make docs-hub-check` | Catch docs entrypoint/link drift |
| Guard make references in docs | `make docs-make-target-check` | Catch stale `make <target>` docs |
| Guard continuation marker | `make continue-tag-check` | Keep roadmap marker consistent |
| Guard release docs commands | `make release-docs-check` | Keep release docs and quick commands consistent |
| Guard workflow inventory | `make workflow-inventory-check` | Keep required CI workflows discoverable and referenced |
| Guard core command docs | `make core-commands-check` | Keep README and docs index command lists aligned |
| Guard docs assets | `make docs-assets-check` | Keep hero asset and key references consistent |
| Guard cheatsheet index | `make cheatsheet-index-check` | Keep cheatsheet index synchronized with file set |
| Guard quick-card docs | `make quick-cards-check` | Keep quick-card links aligned across docs and wiki |
| Guard top-10 card counts | `make top10-cards-check` | Keep each top-10 card at exactly 10 items |
| Guard ci-quick composition | `make ci-quick-guards-check` | Ensure ci-quick still includes required checks |
| Fast CI-equivalent pass | `make ci-quick` | Run lint/docs/wiki/release template guards quickly |
| Memorize essentials | Read `top-10-release-maintainer-commands.md` | Safer repeatable releases |

`CONTINUE_TAG: #continue-utils`

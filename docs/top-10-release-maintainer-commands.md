# Top 10 Release Maintainer Commands

Use these to keep release flow consistent and low-risk.

1. `git status -sb` - verify branch state quickly.
2. `make doctor-full` - run full local quality gate before tagging.
3. `make wiki-build-check` - ensure wiki mirror payload is valid.
4. `pre-commit run --all-files` - run all repository hooks.
5. `git pull --rebase` - sync latest upstream before release actions.
6. `git tag vX.Y.Z` - create semantic version tag.
7. `git push origin vX.Y.Z` - trigger release-on-tag workflow.
8. `gh run list --limit 10` - monitor CI/release workflow outcomes.
9. `gh release view vX.Y.Z` - verify release publication.
10. `br ready` - check next ready work item to continue delivery.

`CONTINUE_TAG: #continue-utils`

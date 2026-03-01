# Top 10 Release Maintainer Commands

Use these to keep release flow consistent and low-risk.

1. `git status -sb` - verify branch state quickly.
2. `make release-precheck` - run release safety checks before tagging.
3. `make doctor-full` - run full local quality gate before tagging.
4. `make wiki-build-check` - ensure wiki mirror payload is valid.
5. `pre-commit run --all-files` - run all repository hooks.
6. `git pull --rebase` - sync latest upstream before release actions.
7. `git tag vX.Y.Z` - create semantic version tag.
8. `git push origin vX.Y.Z` - trigger release-on-tag workflow.
9. `gh run list --limit 10` - monitor CI/release workflow outcomes.
10. `gh release view vX.Y.Z` - verify release publication.

`CONTINUE_TAG: #continue-utils`

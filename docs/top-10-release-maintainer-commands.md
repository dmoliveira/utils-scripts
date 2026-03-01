# Top 10 Release Maintainer Commands

Use these to keep release flow consistent and low-risk.

1. `git status -sb` - verify branch state quickly.
2. `make release-precheck` - run release safety checks before tagging (doctor/template/docs/wiki).
3. `make doctor-full` - run full local quality gate before tagging.
4. `make wiki-build-check` - ensure wiki mirror payload is valid.
5. `make wiki-source-check` - validate links in `wiki/*.md` source pages.
6. `make docs-hub-check` - ensure docs entrypoints and core links stay aligned.
7. `git pull --rebase` - sync latest upstream before release actions.
8. `git tag vX.Y.Z` - create semantic version tag.
9. `git push origin vX.Y.Z` - trigger release-on-tag workflow.
10. `gh release view vX.Y.Z` - verify release publication.

`CONTINUE_TAG: #continue-utils`

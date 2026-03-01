# Top 10 Release Maintainer Commands

Use these to keep release flow consistent and low-risk.

1. `git status -sb` - verify branch state quickly.
2. `make release-precheck` - run release safety checks before tagging.
3. `make ci-quick` - run fast CI-equivalent guards before heavier checks.
4. `make wiki-build-check` - ensure wiki mirror payload is valid.
5. `make wiki-source-check` - validate links in `wiki/*.md` source pages.
6. `make docs-hub-check` - ensure docs entrypoints and core links stay aligned.
7. `make docs-make-target-check` - ensure docs reference real `make` targets.
8. `make continue-tag-check` - enforce `CONTINUE_TAG` in key docs/wiki pages.
9. `make release-docs-check` - validate release doc commands remain aligned.
10. `git tag vX.Y.Z && git push origin vX.Y.Z` - create and publish semantic version tag.

`CONTINUE_TAG: #continue-utils`

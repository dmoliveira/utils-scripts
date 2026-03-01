# Release Flow (End to End)

This project ships releases from tags (`v*`) and generates structured notes.

## E2E sequence

1. ensure working tree is clean and checks pass
2. update `.github/RELEASE_NOTES_TEMPLATE.md`
3. run local render preview
4. create and push a semantic tag
5. verify generated GitHub release

## Commands

```bash
make release-precheck
VERSION=v1.2.0
DATE_UTC="$(date -u +%Y-%m-%d)"
sed "s/{{VERSION}}/${VERSION}/g; s/{{DATE}}/${DATE_UTC}/g" .github/RELEASE_NOTES_TEMPLATE.md
git tag "${VERSION}"
git push origin "${VERSION}"
```

`make release-precheck` runs `make doctor-full`, `make release-template-check`, `make continue-tag-check`, `make docs-hub-check`, `make docs-make-target-check`, `make wiki-source-check`, and `make wiki-build-check`.

## Automation references

- `.github/workflows/release-on-tag.yml`
- `.github/RELEASE_NOTES_TEMPLATE.md`

Release notes template now includes a `Supporters Changelog` section for transparent maintenance updates.

Use `CONTINUE_TAG: #continue-utils` when a release is intentionally partial and has follow-up tasks.

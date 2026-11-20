# Lombo-Forge/.github

The organisation's front page and shared community files.

| File | What it does |
|---|---|
| [profile/README.md](profile/README.md) | The page shown at github.com/Lombo-Forge |
| [CONTRIBUTING.md](CONTRIBUTING.md), [SECURITY.md](SECURITY.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) | Default for every repo here that has no file of its own |
| [ISSUE_TEMPLATE/](ISSUE_TEMPLATE), [PULL_REQUEST_TEMPLATE.md](PULL_REQUEST_TEMPLATE.md) | Default issue forms and pull request template |
| [rulesets/protect-main.json](rulesets/protect-main.json), [scripts/apply-repo-defaults.sh](scripts/apply-repo-defaults.sh) | The repo defaults (see below) and the script that puts them on every repo |

## Repo defaults

Every repo gets the same two defaults:

- **Protect main:** `main` cannot be deleted or force-pushed, history stays linear, and changes need a pull request with one approval and resolved review threads. The organisation owner bypasses it. Outside contributors can only fork and send pull requests.
- **Automatically delete head branches:** a pull request's branch is deleted when it is merged. Deleted branches can still be restored from the pull request.

Organisation-wide rulesets and defaults need the paid GitHub Team plan, so on the Free plan the script copies them onto each repo. **Run it after creating any repo**, and again after editing the JSON; it never duplicates:

```sh
scripts/apply-repo-defaults.sh                          # every repo in the organisation
scripts/apply-repo-defaults.sh lombo-tier --checks test,leak-check   # one repo, plus required CI jobs
```

A repo can override any of these by having its own copy. `scripts/leak-check.sh` runs in CI like in every other Lombo repo. Licensed under [GPL-3.0](LICENSE); the Code of Conduct is the Contributor Covenant 2.1 (CC BY 4.0).

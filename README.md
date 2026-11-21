# Lombo-Forge/.github

The organisation's front page and shared community files.

| File | What it does |
|---|---|
| [profile/README.md](profile/README.md) | The page shown at github.com/Lombo-Forge |
| [CONTRIBUTING.md](CONTRIBUTING.md), [SECURITY.md](SECURITY.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) | Default for every repo here that has no file of its own |
| [ISSUE_TEMPLATE/](ISSUE_TEMPLATE), [PULL_REQUEST_TEMPLATE.md](PULL_REQUEST_TEMPLATE.md) | Default issue forms and pull request template |
| [rulesets/protect-main.json](rulesets/protect-main.json), [scripts/apply-repo-defaults.sh](scripts/apply-repo-defaults.sh) | The repo defaults (see below) and the script that puts them on every repo |

## Repo defaults

Every repo gets the same three defaults:

- **Protect main:** `main` cannot be deleted or force-pushed, history stays linear, and changes need a pull request that passes the required CI checks, with review threads resolved. No approval count is required (one maintainer cannot approve their own pull request), and the organisation owner can bypass the rules. Outside contributors can only fork and send pull requests.
- **Outside contributors' workflows wait for approval:** a fork's pull request cannot run any Actions code until the owner approves the run. Workflows use the plain `pull_request` event, no secrets and a read-only token, so a hostile pull request has nothing to take.
- **Automatically delete head branches:** a pull request's branch is deleted when it is merged. Deleted branches can still be restored from the pull request.

Organisation-wide rulesets and defaults need the paid GitHub Team plan, so on the Free plan the script copies them onto each repo. **Run it after creating any repo**, and again after editing the JSON; it never duplicates, and without `--checks` it keeps the repo's existing required checks:

```sh
scripts/apply-repo-defaults.sh                          # every repo in the organisation
scripts/apply-repo-defaults.sh lombo-tier --checks test,leak-check   # one repo, plus required CI jobs
```

A repo can override any of these by having its own copy. `scripts/leak-check.sh` runs in CI like in every other Lombo repo. Licensed under [GPL-3.0](LICENSE); the Code of Conduct is the Contributor Covenant 2.1 (CC BY 4.0).

## Before merging a pull request

`sh scripts/pr-check.sh <repo> <number>` shows who sent it (the owner and Dependabot are trusted, by account, not by what the title says), whether it comes from a fork, which sensitive files it touches (workflows, scripts, Dockerfiles, dependency files, the manifest, the ruleset) and what CI says. An outside author gets a read-the-whole-diff verdict, and CI passing is never enough on its own, since a pull request can edit the workflow that checks it.

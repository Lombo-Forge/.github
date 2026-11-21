<p align="center"><img src="banner.png" alt="Lombo Forge: small, sharp tools for self-hosted media" width="100%"></p>

**Lombo Forge** makes small, open-source tools for people who run their own media server. Each tool does one job, works on its own, and comes with the files an AI coding agent needs to install it into *your* setup, not just ours.

Everything here is [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html). None of it is affiliated with or endorsed by the Jellyfin project; "for Jellyfin" only says what it works with.

## The tools

Every tool is **dry-run by default**, has a `doctor` command that checks your setup, and lists in its README exactly what has and has not been tested on real systems. These are early releases: read that list before you rely on one.

| Tool | What it does | Release | Tested on real systems |
|---|---|---|---|
| [**LomboTier**](https://github.com/Lombo-Forge/lombo-tier) | Moves movies and seasons between SSD and HDD based on what people actually watch (mergerfs). | 0.1.0 | Plan checked against a real pool and Jellyfin; no real move yet |
| [**LomboShrink**](https://github.com/Lombo-Forge/lombo-shrink) | Uses the discrete graphics card in your main PC to re-encode a library to H.265, then swaps the smaller files in safely. | 0.1.1 | NVIDIA encodes checked on a real card; AMD, Intel, native Windows not yet |
| [**LomboNudge**](https://github.com/Lombo-Forge/lombo-nudge) | Finds requests that were approved but never arrived, and says why. | 0.1.1 | Checked read-only against real Seerr, Sonarr, Radarr and Jellyfin |
| [**LomboNap**](https://github.com/Lombo-Forge/lombo-nap) | Asks "Still watching?" and stops playback nobody is watching; reports what woke your sleeping disks. | 0.1.1 | Not yet run with real clients |
| [**LomboShelf**](https://github.com/Lombo-Forge/jellyfin-plugin-lomboshelf) | A streaming-style home screen, collection rows and theme for Jellyfin's web client, as a plugin. | none yet | Builds and passes unit tests; never loaded in a real Jellyfin |
| [**LomboFarewell**](https://github.com/Lombo-Forge/lombo-farewell) | Mirrors titles scheduled for deletion into a "Leaving soon" collection and postpones them on request. | 0.1.0 | Not yet run on a real server |
| [**LomboVisa**](https://github.com/Lombo-Forge/lombo-visa) | Blocks new Jellyfin sign-ins from abroad, with travel windows; fails open. | 0.1.0 | Security-audited; not yet run on a real server |
| [**LomboVault**](https://github.com/Lombo-Forge/lombo-vault) | Age-encrypted config backups and a restore drill that proves they restore. | 0.1.0 | Real `age` round trip tested; not yet run on a real stack |
| [**lombo-jellyfin-template**](https://github.com/Lombo-Forge/lombo-jellyfin-template) | Starting point for your own small Jellyfin companion app: tested, containerised, renames itself in one command. | 1.1.0 | The base every tool above was built from |
| [**lombo**](https://github.com/Lombo-Forge/lombo) | The hub: plugin repository manifest, brand assets, testing checklists and a one-page site. | n/a | n/a |

Found something that does not match? A report of what you ran and what happened is the most useful contribution: each repo has an issue template for it, and `lombo/docs/testing-checklists.md` lists what is still unproven.

## Make your own

Start from the [template](https://github.com/Lombo-Forge/lombo-jellyfin-template): click **Use this template**, run one script, replace one function. It is the same base the tools above are built from, with ruff, strict mypy, pre-commit, tests and CI already set up.

## Working with an AI coding agent

Every repo has an `AGENTS.md` and a `CLAUDE.md`, plus skills for installing the tool, troubleshooting it and changing it. Point your agent at the repo and ask it to set the tool up for your stack.

## Contributing

Bug reports, ideas and pull requests are welcome in any repo. The rules are short: [CONTRIBUTING](https://github.com/Lombo-Forge/.github/blob/main/CONTRIBUTING.md), [security reports](https://github.com/Lombo-Forge/.github/blob/main/SECURITY.md) and the [code of conduct](https://github.com/Lombo-Forge/.github/blob/main/CODE_OF_CONDUCT.md).

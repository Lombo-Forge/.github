<p align="center"><img src="banner.png" alt="Lombo Forge: small, sharp tools for self-hosted media" width="100%"></p>

**Lombo Forge** makes small, open-source tools for people who run their own media server. Each tool does one job, works on its own, and comes with the files an AI coding agent needs to install it into *your* setup, not just ours.

Everything here is [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html). None of it is affiliated with or endorsed by the Jellyfin project; "for Jellyfin" only says what it works with.

## The tools

Every tool is **dry-run by default**, has a `doctor` command that checks your setup, and lists in its README exactly what has and has not been tested on real systems. These are early releases: read that list before you rely on one.

| Tool | What it does | Release | Install as | End-to-end tested | On my server |
|---|---|---|---|:---:|:---:|
| [**LomboTier**](https://github.com/Lombo-Forge/lombo-tier) | Moves movies and seasons between SSD and HDD based on what people actually watch (mergerfs). Pins titles to the SSD, moves one title on request, and writes where everything lives for other tools. | 0.4.2 | Docker container | ✅ | ✅ |
| [**LomboShrink**](https://github.com/Lombo-Forge/lombo-shrink) | Uses the discrete graphics card in your main PC to re-encode a library to H.265, then swaps the smaller files in safely. | 0.2.3 | Python, on your PC | ✅ | ✅ swaps only |
| [**LomboNudge**](https://github.com/Lombo-Forge/lombo-nudge) | Finds requests that were approved but never arrived, and says why. Writes what it found to a file and offers a token-guarded retry call, so your own page can show it. Can also watch a second 4K Radarr, and decline requests that never arrive. | 0.4.1 | Docker container | ✅ | ✅ |
| [**LomboGate**](https://github.com/Lombo-Forge/lombo-gate) | Approves small Seerr requests by itself and holds TV requests with too many seasons or too large an estimated size for the admin. Run against a real Seerr in dry run only. | 0.1.1 | Docker container | ❌ | ❌ |
| [**LomboSaga**](https://github.com/Lombo-Forge/lombo-saga) | Keeps Kavita collections for book series filled from rules you write; only ever adds. Checked on a small test library, and with one write run on a real one. | 0.1.2 | Docker container | ✅ | ❌ |
| [**LomboHangup**](https://github.com/Lombo-Forge/lombo-hangup) | Frees Live TV streams that Jellyfin keeps open after the viewer has gone, including a stuck viewer on a shared channel. Checked with a fake channel, not yet with real TV apps. | 0.1.0 | Docker container | ✅ | ❌ |
| [**LomboNap**](https://github.com/Lombo-Forge/lombo-nap) | Asks "Still watching?" and stops playback nobody is watching; reports what woke your sleeping disks. Each person can have their own limit, changed without a restart through a small file, and it writes a status file for your own page. | 0.3.1 | Docker container | ❌ | ✅ |
| [**LomboShelf**](https://github.com/Lombo-Forge/jellyfin-plugin-lomboshelf) | A streaming-style home screen, collection rows and theme for Jellyfin's web client, as a plugin; optional storage badges, Keep and Travelling buttons. | 0.2.0 | Jellyfin plugin | ✅ | ❌ |
| [**LomboFarewell**](https://github.com/Lombo-Forge/lombo-farewell) | Mirrors titles scheduled for deletion into a "Leaving soon" collection and postpones them on request, through a small token-guarded keep call, with keep history and optional per-person limits. | 0.3.1 | Docker container | ❌ | ❌ |
| [**LomboVisa**](https://github.com/Lombo-Forge/lombo-visa) | Blocks new Jellyfin sign-ins from abroad, with travel windows; fails open. Works after the fact or as a gateway that refuses before sign-in, people can open their own window, and your dashboard can manage trips. | 0.6.1 | Docker container | ✅ | ✅ |
| [**LomboVault**](https://github.com/Lombo-Forge/lombo-vault) | Age-encrypted config backups and a restore drill that proves they restore. Refuses to back up onto the same disk, can run your own command around a backup (for a consistent database copy), and writes a status file for monitoring. | 0.3.1 | Docker container | ❌ | ❌ |
| [**lombo-jellyfin-template**](https://github.com/Lombo-Forge/lombo-jellyfin-template) | Starting point for your own small Jellyfin companion app: tested, containerised, renames itself in one command. | 1.1.2 | Docker container | – | – |
| [**lombo**](https://github.com/Lombo-Forge/lombo) | The hub: plugin repository manifest, brand assets, testing checklists and a one-page site. | n/a | – | – | – |

**End-to-end tested:** the tool's main job has been run from start to finish against the real software it works with. **On my server:** it is doing that job on a live server today, not only watching in dry run. None of the tools has had an independent review.

Found something that does not match? A report of what you ran and what happened is the most useful contribution: open an issue in the tool's repo, and see `lombo/docs/testing-checklists.md` for what is still unproven.

## Make your own

Start from the [template](https://github.com/Lombo-Forge/lombo-jellyfin-template): click **Use this template**, run one script, replace one function. It is the same base the tools above are built from, with ruff, strict mypy, pre-commit, tests and CI already set up.

## Working with an AI coding agent

Every repo has an `AGENTS.md` and a `CLAUDE.md`, plus skills for installing the tool, troubleshooting it and changing it. Point your agent at the repo and ask it to set the tool up for your stack.

## Contributing

Bug reports, ideas and pull requests are welcome in any repo. The rules are short: [CONTRIBUTING](https://github.com/Lombo-Forge/.github/blob/main/CONTRIBUTING.md), [security reports](https://github.com/Lombo-Forge/.github/blob/main/SECURITY.md) and the [code of conduct](https://github.com/Lombo-Forge/.github/blob/main/CODE_OF_CONDUCT.md).

<p align="center"><img src="banner.png" alt="Lombo Forge: small, sharp tools for self-hosted media" width="100%"></p>

**Lombo Forge** makes small, open-source tools for people who run their own media server. Each tool does one job, works on its own, and comes with the files an AI coding agent needs to install it into *your* setup, not just ours.

Everything here is [GPL-3.0](https://www.gnu.org/licenses/gpl-3.0.html). None of it is affiliated with or endorsed by the Jellyfin project; "for Jellyfin" only says what it works with.

## The tools

| Tool | What it does | Status |
|---|---|---|
| [**lombo-jellyfin-template**](https://github.com/Lombo-Forge/lombo-jellyfin-template) | Starting point for your own small Jellyfin companion app: tested, containerised, renames itself in one command. | Released, 1.0.0 |
| **LomboTier** | Moves movies and seasons between SSD and HDD based on what people actually watch (mergerfs). | In progress |
| **LomboShrink** | Uses the discrete graphics card in your main PC to re-encode a library to H.265, then swaps the smaller files in safely. | In progress |
| **LomboShelf** | A streaming-style home screen and theme for Jellyfin, as a plugin. | In progress (skeleton) |
| **LomboNudge** | Finds requests that were approved but never arrived, and says why. | In progress |
| **LomboNap** | Asks "Still watching?" and stops playback nobody is watching; reports what woke your sleeping disks. | In progress |

More are planned. Each gets its own repository, its own releases and its own issues.

## Make your own

Start from the [template](https://github.com/Lombo-Forge/lombo-jellyfin-template): click **Use this template**, run one script, replace one function. It is the same base the tools above are built from.

## Working with an AI coding agent

Every repo has an `AGENTS.md` and a `CLAUDE.md`, plus skills for installing the tool, troubleshooting it and changing it. Point your agent at the repo and ask it to set the tool up for your stack.

## Contributing

Bug reports, ideas and pull requests are welcome in any repo. The rules are short: [CONTRIBUTING](https://github.com/Lombo-Forge/.github/blob/main/CONTRIBUTING.md), [security reports](https://github.com/Lombo-Forge/.github/blob/main/SECURITY.md) and the [code of conduct](https://github.com/Lombo-Forge/.github/blob/main/CODE_OF_CONDUCT.md).

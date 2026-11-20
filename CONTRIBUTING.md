# Contributing to Lombo Forge

Thanks for helping. This file applies to every Lombo Forge repository that does not have its own.

## Contents

- [Before you start](#before-you-start)
- [Reporting a bug](#reporting-a-bug)
- [Suggesting something](#suggesting-something)
- [Sending a change](#sending-a-change)
- [Checks every change must pass](#checks-every-change-must-pass)
- [Using AI coding agents](#using-ai-coding-agents)
- [Licence](#licence)

## Before you start

For anything bigger than a small fix, open an issue first and say what you want to change. It saves you from writing something that does not fit. Small fixes (typos, a clearer message, a failing edge case) can go straight to a pull request.

## Reporting a bug

Use the bug report form in the repository. The most useful reports include the version, how you run it (Docker, bare metal), your Jellyfin version, and the output of the app's `doctor` command. **Remove API keys, webhook URLs, addresses and file paths you would not want public before you paste anything.**

Security problems do not go in public issues. See [SECURITY.md](SECURITY.md).

## Suggesting something

Use the feature request form. Describe the problem first, then your idea. "I want X because Y keeps happening" gets a better answer than "add X".

## Sending a change

1. Fork the repository and make a branch.
2. Keep the change small and focused. One topic per pull request.
3. Add or update a test for the behaviour you changed.
4. Write commit messages in plain language: what changed and why.
5. Open the pull request against `main` and fill in the template.

## Checks every change must pass

- The tests (`pytest -q` for Python apps).
- The leak check (`sh scripts/leak-check.sh`): no private hostnames, addresses, webhook URLs or personal details in the repo.
- Docs in plain language, one topic per file with a contents list at the top.

CI runs these on every pull request.

## Using AI coding agents

Welcome, with the same bar as any other change: you read it, you ran it, you stand behind it. Say in the pull request how you checked that it works. Do not paste secrets or private data into an agent.

## Licence

By contributing you agree that your contribution is licensed under the repository's licence (GPL-3.0 unless the repo says otherwise).

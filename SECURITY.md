# Security policy

This policy applies to every Lombo Forge repository that does not have its own.

## Reporting a vulnerability

Please report it privately, not in a public issue:

1. Open the **Security** tab of the repository concerned.
2. Choose **Report a vulnerability** and describe the problem.

Include the version, what you did, what happened, and what you expected. Remove real API keys, addresses and personal data from anything you attach.

You will get a reply within a week. These are small projects maintained by one person, so fixes are best-effort, but a real vulnerability is looked at first. When a fix is released, you will be credited unless you prefer not to be.

## What counts

Anything that lets someone read, change or delete what they should not be able to, run code on the host, or leak a secret. Examples: a setting that exposes an API key in logs, a script that follows a path out of its folder, a service that accepts requests from anyone on the network.

## Supported versions

The latest release of each app. Older versions get fixes only when the problem is serious and the upgrade is hard.

## Running these apps safely

- Give each app its own Jellyfin API key so you can revoke one without touching the others.
- Keep apps that can move or delete files in dry-run mode until you have read what `plan` says.
- Do not expose an app's port to the internet.
- Keep `.env` out of git and out of screenshots.

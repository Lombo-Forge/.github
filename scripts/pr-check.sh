#!/bin/sh
# What to know before merging a pull request: who sent it, whether it comes from a fork, which sensitive files it
# touches, and what CI says. Prints a verdict; exits 1 when an outside author touches a sensitive file.
#   scripts/pr-check.sh <repo> <number>          e.g. scripts/pr-check.sh lombo-tier 12
# Trusted authors: you (the account gh is logged in as, or LOMBO_OWNER) and Dependabot (the account, not a title that says "Bump"). Everything else is outside.
set -eu
ORG=${LOMBO_ORG:-Lombo-Forge}; OWNER=${LOMBO_OWNER:-$(gh api user --jq .login)}
repo=${1:?usage: pr-check.sh <repo> <number>}; n=${2:?usage: pr-check.sh <repo> <number>}
info=$(gh api "repos/$ORG/$repo/pulls/$n" --jq '[.user.login, .head.repo.full_name, .base.repo.full_name, .title, (.changed_files|tostring), (.additions|tostring), (.deletions|tostring)] | @tsv')
author=$(printf '%s' "$info" | cut -f1); head=$(printf '%s' "$info" | cut -f2); base=$(printf '%s' "$info" | cut -f3)
title=$(printf '%s' "$info" | cut -f4); files=$(printf '%s' "$info" | cut -f5)
trusted=no; case "$author" in "$OWNER"|dependabot\[bot\]) trusted=yes ;; esac
fork=no; [ "$head" = "$base" ] || fork=yes
sensitive=$(gh api "repos/$ORG/$repo/pulls/$n/files" --paginate --jq '.[].filename' |
  grep -E '^(\.github/|scripts/|rulesets/|Dockerfile|compose|pyproject\.toml$|package(-lock)?\.json$|manifest\.json$|\.pre-commit-config\.yaml$|.*\.sh$)' || true)
echo "PR $repo#$n: $title"
echo "author: $author ($([ $trusted = yes ] && echo trusted || echo OUTSIDE)); from a fork: $fork; $files files, +$(printf '%s' "$info" | cut -f6) -$(printf '%s' "$info" | cut -f7)"
echo "CI: $(gh pr checks "$n" --repo "$ORG/$repo" 2>/dev/null | awk '{print $1"="$2}' | tr '\n' ' ')"
if [ -n "$sensitive" ]; then echo "sensitive files touched:"; printf '%s\n' "$sensitive" | sed 's/^/  /'; else echo "sensitive files touched: none"; fi
if [ "$trusted" = no ] && [ -n "$sensitive" ]; then echo "VERDICT: outside author touching sensitive files. Read the whole diff before anything else."; exit 1; fi
if [ "$trusted" = no ]; then echo "VERDICT: outside author. Read the diff; do not merge on CI alone."; else echo "VERDICT: trusted author."; fi

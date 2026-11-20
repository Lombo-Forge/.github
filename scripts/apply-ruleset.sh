#!/bin/sh
# Put the "Protect main" ruleset (rulesets/protect-main.json) on every repo in the organisation.
# Safe to run again: a repo that already has it is updated, never duplicated.
#
#   scripts/apply-ruleset.sh                       every non-archived repo
#   scripts/apply-ruleset.sh lombo-tier            one repo
#   scripts/apply-ruleset.sh lombo-tier --checks test,leak-check
#                                                  one repo, plus required CI checks (job names)
#   add --dry-run to see what would happen
#
# Why a script: organisation-wide rulesets need the paid GitHub Team plan, so on the Free plan each
# repo gets its own copy. Run this after creating a repo. Needs `gh` logged in as an org admin.
set -eu
cd "$(dirname "$0")/.."
ORG=${LOMBO_ORG:-Lombo-Forge}
NAME="Protect main"
repo="" checks="" dry=""

while [ $# -gt 0 ]; do
  case "$1" in
    --checks) checks=${2:?--checks needs a comma-separated list}; shift 2 ;;
    --dry-run) dry=1; shift ;;
    -h|--help) sed -n '2,14p' "$0"; exit 0 ;;
    -*) echo "unknown option: $1" >&2; exit 2 ;;
    *) repo=$1; shift ;;
  esac
done
[ -z "$checks" ] || [ -n "$repo" ] || { echo "--checks needs a single repo name" >&2; exit 2; }

body=$(CHECKS="$checks" python3 - <<'EOF'
import json, os
d = json.load(open("rulesets/protect-main.json"))
checks = [c for c in os.environ["CHECKS"].split(",") if c]
if checks:
    d["rules"].append({"type": "required_status_checks", "parameters": {
        "strict_required_status_checks_policy": False,
        "required_status_checks": [{"context": c} for c in checks]}})
print(json.dumps(d))
EOF
)

repos=${repo:-$(gh repo list "$ORG" --no-archived --limit 200 --json name --jq '.[].name')}
for r in $repos; do
  id=$(gh api "repos/$ORG/$r/rulesets" --jq ".[] | select(.name==\"$NAME\") | .id" | head -n1)
  if [ -n "$id" ]; then verb=PUT; url="repos/$ORG/$r/rulesets/$id"; word=update
  else verb=POST; url="repos/$ORG/$r/rulesets"; word=create; fi
  if [ -n "$dry" ]; then echo "[dry run] would $word '$NAME' on $r"; continue; fi
  printf '%s' "$body" | gh api -X "$verb" "$url" --input - --jq '"\(.name): ok"' | sed "s|^|$word $r: |"
done

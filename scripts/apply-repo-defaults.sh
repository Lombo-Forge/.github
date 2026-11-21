#!/bin/sh
# Give every repo in the organisation the standard defaults:
#   - the "Protect main" ruleset (rulesets/protect-main.json)
#   - "Automatically delete head branches" after a pull request is merged (restorable from the PR)
# Safe to run again: a repo that already has them is updated, never duplicated.
#
#   scripts/apply-repo-defaults.sh                       every non-archived repo
#   scripts/apply-repo-defaults.sh lombo-tier            one repo
#   scripts/apply-repo-defaults.sh lombo-tier --checks test,leak-check
#                                                  one repo, plus required CI checks (job names)
#   add --dry-run to see what would happen
#
# Why a script: organisation-wide rulesets and defaults need the paid GitHub Team plan, so on the Free
# plan each repo gets its own copy. Run this after creating a repo. Needs `gh` logged in as an org admin.
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

repos=${repo:-$(gh repo list "$ORG" --no-archived --limit 200 --json name --jq '.[].name')}
for r in $repos; do
  id=$(gh api "repos/$ORG/$r/rulesets" --jq ".[] | select(.name==\"$NAME\") | .id" | head -n1)
  existing=""
  [ -z "$id" ] || existing=$(gh api "repos/$ORG/$r/rulesets/$id")
  # Required CI checks: the ones given with --checks, else the ones this repo's ruleset already has (never dropped).
  body=$(CHECKS="$checks" EXISTING="$existing" python3 - <<'EOF'
import json, os
d = json.load(open("rulesets/protect-main.json"))
checks = [c for c in os.environ["CHECKS"].split(",") if c]
if checks:
    d["rules"].append({"type": "required_status_checks", "parameters": {
        "strict_required_status_checks_policy": False,
        "required_status_checks": [{"context": c} for c in checks]}})
elif os.environ["EXISTING"]:
    d["rules"] += [r for r in json.loads(os.environ["EXISTING"]).get("rules", []) if r["type"] == "required_status_checks"]
print(json.dumps(d))
EOF
)
  if [ -n "$id" ]; then verb=PUT; url="repos/$ORG/$r/rulesets/$id"; word=update
  else verb=POST; url="repos/$ORG/$r/rulesets"; word=create; fi
  if [ -n "$dry" ]; then echo "[dry run] would $word '$NAME' and turn on branch deletion on $r"; continue; fi
  printf '%s' "$body" | gh api -X "$verb" "$url" --input - --jq '"\(.name): ok"' | sed "s|^|$word $r: |"
  gh api -X PATCH "repos/$ORG/$r" -F delete_branch_on_merge=true --jq '"set \(.name): delete_branch_on_merge=\(.delete_branch_on_merge)"'
done

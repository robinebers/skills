#!/usr/bin/env bash
#
# Validate every skill in skills/ against the skills.sh conventions.
# Hard invariants only — structure, frontmatter, name match, kebab-case,
# and that references/ links resolve. Complements the CLI parse check:
#
#     npx skills add . --list      # should report "Found N skills"
#
# Usage: scripts/validate-skills.sh
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$ROOT/skills"
KEBAB='^[a-z][a-z0-9]*(-[a-z0-9]+)*$'

errors=0
count=0

for dir in "$SKILLS_DIR"/*/; do
  [ -d "$dir" ] || continue
  name="$(basename "$dir")"
  count=$((count + 1))
  skill="$dir/SKILL.md"

  if [ ! -f "$skill" ]; then
    echo "✗ $name: missing SKILL.md"; errors=$((errors + 1)); continue
  fi

  if [ "$(head -1 "$skill")" != "---" ]; then
    echo "✗ $name: SKILL.md must start with a '---' frontmatter block"; errors=$((errors + 1))
  fi

  fm_name="$(grep -m1 '^name:' "$skill" | sed 's/^name:[[:space:]]*//; s/["'\'']//g; s/[[:space:]]*$//')"
  fm_desc="$(grep -m1 '^description:' "$skill" | sed 's/^description:[[:space:]]*//; s/[[:space:]]*$//')"

  if [ -z "$fm_name" ]; then
    echo "✗ $name: frontmatter missing 'name:'"; errors=$((errors + 1))
  else
    [ "$fm_name" = "$name" ] || { echo "✗ $name: frontmatter name '$fm_name' != folder name"; errors=$((errors + 1)); }
    printf '%s' "$fm_name" | grep -Eq "$KEBAB" || { echo "✗ $name: name '$fm_name' is not kebab-case"; errors=$((errors + 1)); }
  fi

  [ -n "$fm_desc" ] || { echo "✗ $name: frontmatter missing 'description:'"; errors=$((errors + 1)); }

  # references/X.md links in SKILL.md must resolve within this skill's own folder
  for ref in $(grep -oE 'references/[A-Za-z0-9_./-]+\.md' "$skill" | sort -u); do
    [ -f "$dir/$ref" ] || { echo "✗ $name: SKILL.md links '$ref' which does not exist in this skill"; errors=$((errors + 1)); }
  done
done

echo ""
if [ "$errors" -eq 0 ]; then
  echo "✓ $count skills valid"
  exit 0
fi
echo "✗ $errors problem(s) across $count skills"
exit 1

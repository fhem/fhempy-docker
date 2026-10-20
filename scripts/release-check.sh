#!/bin/bash
# Decides whether the scheduled patch release is due.
#
# Usage: scripts/release-check.sh [ref]    (default: HEAD)
#
# A release is due if there are commits since the last release tag (vX.Y.Z,
# reachable from ref). The README update commits of the release workflow are
# ignored. If one of the commits is a major update, no patch release is made,
# the next release has to be created manually with a new major version.
#
# A commit counts as major update if
#   - its pull request has the label $MAJOR_LABEL (Renovate sets it, see renovate.json)
#   - it is a breaking conventional commit ("feat!: ..." or "BREAKING CHANGE:" in the body)
#   - it is a Renovate major update of the image content
#     ("update dependency foo to v2", "update python docker tag to v4"),
#     major updates of GitHub actions don't change the image and are ignored
#
# Pull request labels are only checked if GH_TOKEN and GITHUB_REPOSITORY are set.
#
# Results are printed as key=value and appended to $GITHUB_OUTPUT if set:
#   last_tag, next_tag, sha, commits, major, release, reason

set -euo pipefail

REF="${1:-HEAD}"
MAJOR_LABEL="${MAJOR_LABEL:-major-update}"
IGNORE_SUBJECT='README.md: Update Versions'

out() {
  echo "$1=$2"
  if [ -n "${GITHUB_OUTPUT:-}" ]; then
    echo "$1=$2" >> "$GITHUB_OUTPUT"
  fi
}

summary() {
  if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
    echo "$1" >> "$GITHUB_STEP_SUMMARY"
  fi
}

check_labels=false
if [ -n "${GH_TOKEN:-}" ] && [ -n "${GITHUB_REPOSITORY:-}" ]; then
  check_labels=true
fi

sha=$(git rev-parse "${REF}^{commit}")
last_tag=$(git tag --merged "$sha" | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1 || true)
if [ -z "$last_tag" ]; then
  echo "::error::No release tag (vX.Y.Z) found in the history of ${REF}"
  exit 1
fi

IFS=. read -r major minor patch <<< "${last_tag#v}"
next_tag="v${major}.${minor}.$((10#$patch + 1))"
if git rev-parse -q --verify "refs/tags/${next_tag}" > /dev/null; then
  echo "::error::Tag ${next_tag} already exists, but is not reachable from ${REF}"
  exit 1
fi

commits=0
major_commits=()
commit_list=()
while read -r commit; do
  subject=$(git log -1 --format=%s "$commit")
  if [ "$subject" == "$IGNORE_SUBJECT" ] \
    && [ "$(git diff-tree --no-commit-id --name-only -r "$commit")" == "README.md" ]; then
    continue
  fi
  commits=$((commits + 1))
  commit_list+=("${commit:0:7} ${subject}")

  body=$(git log -1 --format=%b "$commit")
  is_major=false
  if [[ "$subject" =~ ^[a-zA-Z]+(\([^\)]*\))?!: ]] \
    || grep -qE '^BREAKING[ -]CHANGE:' <<< "$body" \
    || [[ "$subject" =~ ^(chore|fix)\(deps\):\ update\ (dependency\ .+|.+\ docker\ tag)\ to\ v[0-9]+(\ \[(SECURITY|security)\])?(\ \(#[0-9]+\))?$ ]]; then
    is_major=true
  elif $check_labels; then
    labels=$(gh api "repos/${GITHUB_REPOSITORY}/commits/${commit}/pulls" --jq '.[].labels[].name' < /dev/null)
    if grep -qxF "$MAJOR_LABEL" <<< "$labels"; then
      is_major=true
    fi
  fi
  if $is_major; then
    major_commits+=("${commit:0:7} ${subject}")
  fi
done < <(git rev-list --no-merges "${last_tag}..${sha}")

out last_tag "$last_tag"
out next_tag "$next_tag"
out sha "$sha"
out commits "$commits"

if [ "$commits" -eq 0 ]; then
  reason="No changes since ${last_tag}, no release needed"
  out major false
  out release false
elif [ "${#major_commits[@]}" -gt 0 ]; then
  reason="Major update since ${last_tag}, a patch release is not appropriate. Please create the release manually with a new major version."
  echo "::warning::${reason}"
  out major true
  out release false
else
  reason="${commits} change(s) since ${last_tag}, releasing ${next_tag}"
  out major false
  out release true
fi
out reason "$reason"

summary "### Scheduled release"
summary ""
summary "$reason"
if [ "$commits" -gt 0 ]; then
  summary ""
  summary "Changes since ${last_tag}:"
  for line in "${commit_list[@]}"; do
    summary "- ${line}"
  done
fi
if [ "${#major_commits[@]}" -gt 0 ]; then
  summary ""
  summary "Major updates:"
  for line in "${major_commits[@]}"; do
    summary "- ${line}"
  done
fi

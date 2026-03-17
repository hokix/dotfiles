#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
scratch_dir="$(mktemp -d)"
trap 'rm -rf "$scratch_dir"' EXIT

package_root="$scratch_dir/dotfiles"
target_root="$scratch_dir/target"

mkdir -p \
  "$package_root/demo/.agents/skills" \
  "$package_root/demo/.copilot" \
  "$package_root/demo/.config/opencode" \
  "$target_root"

cat > "$package_root/demo/.stow-post-links" <<'EOF'
.copilot/skills:.agents/skills
.config/opencode/skills:.agents/skills
EOF

touch "$package_root/demo/.agents/skills/example.md"

success_output="$(
  DOTFILES_DIR="$package_root" TARGET_DIR="$target_root" \
    bash "$repo_root/stow-with-dirs.sh" demo 2>&1
)"

expected_success_tag=$'[0;32m[INFO][0m'
old_success_tag=$'[0;32m[SUCC][0m'
legacy_success_tag=$'[0;32m[SUCCESS][0m'

[[ "$success_output" == *"$expected_success_tag"* ]] || {
  echo "expected success logs to use green [INFO]" >&2
  echo "$success_output" | cat -v >&2
  exit 1
}

[[ "$success_output" != *"$old_success_tag"* && "$success_output" != *"$legacy_success_tag"* ]] || {
  echo "expected success logs to stop using green [SUCC]/[SUCCESS]" >&2
  echo "$success_output" | cat -v >&2
  exit 1
}

echo "success log label matches info/warn style"

DOTFILES_DIR="$package_root" TARGET_DIR="$target_root" \
  bash "$repo_root/stow-with-dirs.sh" demo >/dev/null

copilot_link="$target_root/.copilot/skills"
opencode_link="$target_root/.config/opencode/skills"
expected_target="$target_root/.agents/skills"

[[ -L "$copilot_link" ]] || {
  echo "expected $copilot_link to be a symlink" >&2
  exit 1
}

[[ -L "$opencode_link" ]] || {
  echo "expected $opencode_link to be a symlink" >&2
  exit 1
}

[[ "$(cd "$(dirname "$copilot_link")" && cd "$(readlink "$copilot_link")" && pwd)" == "$expected_target" ]] || {
  echo "expected $copilot_link to resolve to $expected_target" >&2
  exit 1
}

[[ "$(cd "$(dirname "$opencode_link")" && cd "$(readlink "$opencode_link")" && pwd)" == "$expected_target" ]] || {
  echo "expected $opencode_link to resolve to $expected_target" >&2
  exit 1
}

echo "post-link support works"

missing_target_root="$scratch_dir/missing-target"
missing_package_root="$scratch_dir/missing-dotfiles"

mkdir -p \
  "$missing_package_root/demo/.copilot" \
  "$missing_target_root"

cat > "$missing_package_root/demo/.stow-post-links" <<'EOF'
.copilot/skills:.agents/skills
EOF

DOTFILES_DIR="$missing_package_root" TARGET_DIR="$missing_target_root" \
  bash "$repo_root/stow-with-dirs.sh" demo >/dev/null

missing_link="$missing_target_root/.copilot/skills"
expected_missing_target="$missing_target_root/.agents/skills"

[[ -L "$missing_link" ]] || {
  echo "expected $missing_link to be a symlink even when target is absent" >&2
  exit 1
}

[[ "$(readlink "$missing_link")" == "$expected_missing_target" ]] || {
  echo "expected $missing_link to point to $expected_missing_target" >&2
  exit 1
}

echo "missing-target post-link support works"

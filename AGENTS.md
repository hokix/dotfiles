<!-- gitnexus:start -->
# GitNexus — Code Intelligence

This project is indexed by GitNexus as **dotfiles** (50 symbols, 44 relationships, 0 execution flows). Use the GitNexus MCP tools to understand code, assess impact, and navigate safely.

> Index stale? Run `node .gitnexus/run.cjs analyze` from the project root — it auto-selects an available runner. No `.gitnexus/run.cjs` yet? `npx gitnexus analyze` (npm 11 crash → `npm i -g gitnexus`; #1939).

## Always Do

- **MUST run impact analysis before editing any symbol.** Before modifying a function, class, or method, run `impact({target: "symbolName", direction: "upstream"})` and report the blast radius (direct callers, affected processes, risk level) to the user.
- **MUST run `detect_changes()` before committing** to verify your changes only affect expected symbols and execution flows. For regression review, compare against the default branch: `detect_changes({scope: "compare", base_ref: "master"})`.
- **MUST warn the user** if impact analysis returns HIGH or CRITICAL risk before proceeding with edits.
- When exploring unfamiliar code, use `query({query: "concept"})` to find execution flows instead of grepping. It returns process-grouped results ranked by relevance.
- When you need full context on a specific symbol — callers, callees, which execution flows it participates in — use `context({name: "symbolName"})`.

## Never Do

- NEVER edit a function, class, or method without first running `impact` on it.
- NEVER ignore HIGH or CRITICAL risk warnings from impact analysis.
- NEVER rename symbols with find-and-replace — use `rename` which understands the call graph.
- NEVER commit changes without running `detect_changes()` to check affected scope.

## Resources

| Resource | Use for |
|----------|---------|
| `gitnexus://repo/dotfiles/context` | Codebase overview, check index freshness |
| `gitnexus://repo/dotfiles/clusters` | All functional areas |
| `gitnexus://repo/dotfiles/processes` | All execution flows |
| `gitnexus://repo/dotfiles/process/{name}` | Step-by-step execution trace |

## CLI

| Task | Read this skill file |
|------|---------------------|
| Understand architecture / "How does X work?" | `.claude/skills/gitnexus/gitnexus-exploring/SKILL.md` |
| Blast radius / "What breaks if I change X?" | `.claude/skills/gitnexus/gitnexus-impact-analysis/SKILL.md` |
| Trace bugs / "Why is X failing?" | `.claude/skills/gitnexus/gitnexus-debugging/SKILL.md` |
| Rename / extract / split / refactor | `.claude/skills/gitnexus/gitnexus-refactoring/SKILL.md` |
| Tools, resources, schema reference | `.claude/skills/gitnexus/gitnexus-guide/SKILL.md` |
| Index, status, clean, wiki CLI commands | `.claude/skills/gitnexus/gitnexus-cli/SKILL.md` |

<!-- gitnexus:end -->

# Repository Guide

## Project Overview

This repository stores cross-platform personal configuration managed as GNU
Stow packages. Top-level package directories mirror paths below the target home
directory; for example, `nvim/.config/nvim/init.lua` is deployed as
`~/.config/nvim/init.lua`.

- Shell and terminal packages include `bash`, `zsh`, `tmux`, `alacritty`,
  `ghostty`, `kitty`, and `wezterm`.
- Editor and language-tool packages include `nvim`, `vim`, `git`, `go`,
  `clang`, `gdb`, `python`, and `taplo`.
- `ai` centralizes configuration shared by several AI coding tools.
- `stow-with-dirs.sh` is the main executable: it creates target directories,
  invokes Stow, and applies optional package-specific post-links.
- `tests/stow-with-dirs-post-links.sh` is the focused regression test for the
  wrapper. There is no application server, database, or compiled build output.

## Repository Layout

- Treat each top-level configuration directory as an independent Stow package.
  Preserve the exact home-relative directory structure inside it.
- `nvim/.config/nvim/` is a LazyVim-based Lua configuration. Keep reusable
  behavior in `lua/config/`, feature modules in `lua/plugins/`, and custom
  tasks in `lua/overseer/`.
- Package-local `.stow-local-ignore` files exclude files that must not be
  deployed. The root `.stow-local-ignore` provides the shared defaults.
- A package may define `.stow-post-links` entries as
  `<link-path>:<target-path>`, both relative to the target home. Blank lines
  and lines beginning with `#` are ignored.
- `.github/workflows/` contains configuration linting, Stow smoke tests,
  CodeQL analysis, and automated README statistics.

## Setup and Deployment

The wrapper requires GNU Stow and Bash 4 or newer because it uses `mapfile`.

```bash
# macOS
brew install bash stow

# Debian/Ubuntu
sudo apt install bash stow
```

The default checkout location is `$HOME/dotfiles`. For another location, set
`DOTFILES_DIR` explicitly.

```bash
git clone https://github.com/hokix/dotfiles "$HOME/dotfiles"
cd "$HOME/dotfiles"

# Preview selected packages without writing to the target.
DRY_RUN=true ./stow-with-dirs.sh git nvim zsh

# Deploy only packages explicitly requested by the user.
./stow-with-dirs.sh git nvim zsh
```

Prefer the wrapper over bare `stow`: pre-creating nested directories avoids
coarse directory symlinks. Always use it for `ai`, whose `.stow-post-links`
also creates the cross-tool links. Use `DOTFILES_DIR` and `TARGET_DIR` to test
against a temporary tree:

```bash
scratch_dir="$(mktemp -d)"
trap 'rm -rf "$scratch_dir"' EXIT
DOTFILES_DIR="$PWD" TARGET_DIR="$scratch_dir" \
  bash ./stow-with-dirs.sh ai
```

Do not deploy into the real `$HOME`, remove links, or overwrite an existing
non-symlink path unless the user explicitly requests that operation. An
inspection, documentation, or validation task does not authorize deployment.

## Development Workflow

- Make the smallest package-local change possible and preserve unrelated
  machine-specific configuration.
- Before changing link behavior, read `stow-with-dirs.sh`, the affected
  package's `.stow-local-ignore`, and `.stow-post-links` if present.
- Validate link changes with a temporary `TARGET_DIR`; never use a populated
  home directory as a test fixture.
- When adding a package, reproduce its intended `$HOME` layout beneath one new
  top-level directory and dry-run that package independently.
- Keep optional or machine-specific values in local files or environment
  variables. Existing Git includes such files through `.gitconfig-local`,
  `.gitconfig-url`, and `.gitconfig-job`.
- Do not edit the generated statistics between `<!-- STATS_START -->` and
  `<!-- STATS_END -->` in `README.md`; the `readme-update.yml` workflow owns
  that block.

## Testing and Validation

Run the checks relevant to the files changed. The focused wrapper test uses a
temporary directory and requires GNU Stow:

```bash
bash --version
for file in stow-with-dirs.sh tests/stow-with-dirs-post-links.sh; do
  bash -n "$file"
done
shellcheck stow-with-dirs.sh tests/stow-with-dirs-post-links.sh
bash tests/stow-with-dirs-post-links.sh
```

For configuration files, follow the repository-owned formatter and linter
settings:

```bash
find nvim -name '*.lua' -type f -print0 |
  xargs -0 luacheck --config .luacheckrc
stylua --check nvim/.config/nvim
git ls-files '*.toml' -z |
  xargs -0 taplo check --config taplo/.taplo.toml
git ls-files '*.json' -z | xargs -0 -n1 jq empty
zsh -n zsh/.zshrc
```

Before handoff, always run:

```bash
git diff --check
git status --short
find . -type l ! -exec test -e {} \; -print
```

The CI Stow workflow smoke-tests all packages on Ubuntu and macOS, then
actually deploys `git`, `tmux`, and `vim` into a temporary home. The lint
workflow checks Neovim Lua, shell files, YAML, JSON, TOML, and broken symlinks.

## Code Style

- Shell: retain `set -euo pipefail` in executable Bash scripts, quote path and
  variable expansions, use `local` inside functions, and keep operations safe
  for paths containing spaces. Add regression coverage for behavior changes.
- Lua: use the local `stylua.toml` settings (two spaces and 120 columns) and
  keep `.luacheckrc` globals in sync when introducing framework globals.
- C/C++: use `clang/.clang-format`; do not reformat unrelated templates or
  editor settings.
- TOML: use `taplo/.taplo.toml`. Keep JSON strict and YAML parseable by
  PyYAML, matching CI.
- Preserve the style and ordering of declarative application configuration
  unless a tool-owned formatter defines a canonical result.

## Security and Change Hygiene

- Never commit access tokens, API keys, cookies, private host credentials, or
  generated application state. Reference secrets through environment
  variables, as the AI tool configuration already does.
- Review changes for absolute home paths, usernames, and OS-specific
  assumptions before committing.
- Do not modify ignored local state merely to make the working tree look
  clean, and do not revert unrelated user changes.
- Use concise commit subjects consistent with repository history, such as
  `feat: update nvim`, `fix: ...`, or `chore: ...`.
- Pull requests target `master`. Run focused tests plus `git diff --check`
  before submission and describe any platform-specific validation not run
  locally.

#!/usr/bin/env bash
#
# stow-with-dirs.sh - Intelligent stow wrapper that creates parent directories
#                     to force file-level symlinks instead of directory-level.
#
# Usage:
#   ./stow-with-dirs.sh <package> [<package> ...]
#   ./stow-with-dirs.sh ai git nvim
#
# What it does:
#   1. Scans the package for nested directories
#   2. Creates parent directories in $HOME before stowing
#   3. Runs stow to create file-level symlinks
#   4. Applies optional package-specific post-link rules
#
# Why this matters:
#   Without pre-creating directories, stow creates directory symlinks.
#   Pre-creating them forces stow to descend and symlink individual files.

set -euo pipefail

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
TARGET_DIR="${TARGET_DIR:-$HOME}"
DRY_RUN="${DRY_RUN:-false}"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $*"
}
log_success() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*"
}

apply_post_links() {
    local package="$1"
    local config_path="$package/.stow-post-links"

    if [[ ! -f "$config_path" ]]; then
        return
    fi

    log_info "  Applying post-links from: $config_path"

    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]]; then
            continue
        fi

        if [[ "$line" != *:* ]]; then
            log_error "  Invalid post-link entry: $line"
            log_error "  Expected format: <link-path>:<target-path>"
            exit 1
        fi

        local link_rel="${line%%:*}"
        local target_rel="${line#*:}"
        local link_path="$TARGET_DIR/$link_rel"
        local target_path="$TARGET_DIR/$target_rel"
        local link_parent
        link_parent="$(dirname "$link_path")"

        if [[ -z "$link_rel" || -z "$target_rel" ]]; then
            log_error "  Invalid post-link entry: $line"
            log_error "  Both link path and target path are required"
            exit 1
        fi

        if [[ ! -e "$target_path" ]]; then
            log_warn "  Post-link target does not exist yet: $target_rel"
            log_warn "  Creating link anyway: $link_rel -> $target_rel"
        fi

        if [[ -e "$link_path" && ! -L "$link_path" ]]; then
            log_error "  Cannot replace existing non-symlink path: $link_rel"
            log_error "  Existing path: $link_path"
            exit 1
        fi

        if [[ "$DRY_RUN" == "true" ]]; then
            log_info "  [DRY] Would link: $link_rel -> $target_rel"
            continue
        fi

        mkdir -p "$link_parent"
        ln -sfn "$target_path" "$link_path"
        log_success "  ✓ Linked: $link_rel -> $target_rel"
    done <"$config_path"
}

# Check if stow is installed
if ! command -v stow &>/dev/null; then
    log_error "GNU Stow is not installed. Please install it first."
    log_info "macOS: brew install stow"
    log_info "Linux: sudo apt install stow / sudo dnf install stow"
    exit 1
fi

# Validate dotfiles directory
if [[ ! -d "$DOTFILES_DIR" ]]; then
    log_error "Dotfiles directory not found: $DOTFILES_DIR"
    log_info "Set DOTFILES_DIR environment variable to your dotfiles path"
    exit 1
fi

# Show usage if no packages specified
if [[ $# -eq 0 ]]; then
    log_error "No packages specified"
    echo
    echo "Usage: $0 <package> [<package> ...]"
    echo
    echo "Available packages in $DOTFILES_DIR:"
    find "$DOTFILES_DIR" -maxdepth 1 -type d -not -path "$DOTFILES_DIR" -not -name ".*" |
        xargs -n1 basename | sort | sed 's/^/  - /'
    echo
    echo "Examples:"
    echo "  $0 ai git nvim"
    echo "  $0 zsh tmux"
    echo "  DOTFILES_DIR=/path/to/dotfiles $0 ai"
    echo "  DRY_RUN=true $0 ai  # Preview without making changes"
    exit 1
fi

cd "$DOTFILES_DIR"

# Process each package
for package in "$@"; do
    if [[ ! -d "$package" ]]; then
        log_warn "Package not found: $package (skipping)"
        continue
    fi

    log_info "Processing package: $package"

    # Find all directories in the package (excluding .git, .github, etc.)
    mapfile -t dirs < <(
        find "$package" -type d -mindepth 1 \
            ! -path "*/.git/*" \
            ! -path "*/.github/*" \
            ! -name ".git" \
            ! -name ".github" |
            sed "s|^$package/||" |
            sort
    )

    if [[ ${#dirs[@]} -eq 0 ]]; then
        log_info "  No nested directories found"
    else
        log_info "  Found ${#dirs[@]} nested directories"

        # Create each directory in target
        for dir in "${dirs[@]}"; do
            target_path="$TARGET_DIR/$dir"

            if [[ -L "$target_path" ]]; then
                log_warn "  $dir is a symlink (will be unfolded by stow)"
            elif [[ -d "$target_path" ]]; then
                log_info "  ✓ $dir (exists)"
            else
                if [[ "$DRY_RUN" == "true" ]]; then
                    log_info "  [DRY] Would create: $dir"
                else
                    mkdir -p "$target_path"
                    log_success "  ✓ Created: $dir"
                fi
            fi
        done
    fi

    # Run stow
    log_info "  Running stow for: $package"
    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "  [DRY] Would run: stow -v --target=$TARGET_DIR $package"
        stow -n -v --target="$TARGET_DIR" "$package" 2>&1 | sed 's/^/    /'
    else
        if stow -v --target="$TARGET_DIR" "$package" 2>&1 | sed 's/^/    /'; then
            log_success "  ✓ Stowed: $package"
        else
            log_error "  ✗ Failed to stow: $package"
            exit 1
        fi
    fi

    apply_post_links "$package"

    echo
done

log_success "All packages processed successfully"

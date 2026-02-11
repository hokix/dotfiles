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
    echo -e "${GREEN}[SUCCESS]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*"
}

# Check if stow is installed
if ! command -v stow &> /dev/null; then
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
    find "$DOTFILES_DIR" -maxdepth 1 -type d -not -path "$DOTFILES_DIR" -not -name ".*" | \
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
            ! -name ".github" \
            | sed "s|^$package/||" \
            | sort
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

    echo
done

log_success "All packages processed successfully"

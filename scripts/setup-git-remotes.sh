#!/bin/bash
# Set up git remotes for KServe multi-fork workflow
# Configures upstream, odh, downstream, kserve alias, and origin remotes

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1" >&2; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1" >&2; }
log_error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    log_error "Not in a git repository. Please run this script from the kserve repository root."
    exit 1
fi

log_info "=== KServe Git Remotes Setup ==="

remote_exists() { git remote | grep -q "^${1}$"; }

# Add remote if it doesn't exist
add_remote_if_missing() {
    local name=$1
    local url=$2
    if remote_exists "$name"; then
        log_info "${name} already configured: $(git remote get-url "$name")"
    else
        git remote add "$name" "$url"
        log_info "Added ${name}: ${url}"
    fi
}

# Standard remotes (fixed URLs)
add_remote_if_missing "upstream" "git@github.com:kserve/kserve.git"
add_remote_if_missing "odh" "git@github.com:opendatahub-io/kserve.git"
add_remote_if_missing "downstream" "git@github.com:red-hat-data-services/kserve.git"

# Origin (user's personal fork) - prompt only if missing
if remote_exists "origin"; then
    log_info "origin already configured: $(git remote get-url origin)"
else
    read -p "$(echo -e "${BLUE}[PROMPT]${NC} Enter your personal fork URL (e.g., git@github.com:username/kserve.git): ")" input
    if [[ -n "$input" ]]; then
        git remote add origin "$input"
        log_info "Added origin: ${input}"
    else
        log_warn "Skipping origin. Add it later with: git remote add origin <url>"
    fi
fi

echo ""
log_info "Fetching all remotes..."
git fetch --all

echo ""
log_info "=== Current remotes ==="
git remote -v

echo ""
log_info "=== Setup Complete ==="

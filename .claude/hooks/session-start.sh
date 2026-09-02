#!/bin/bash
set -euo pipefail

# Only run in Claude Code on the web (remote) sessions.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

export PATH="$HOME/.local/bin:$PATH"

if ! command -v rtk >/dev/null 2>&1; then
  # Pin a version: the installer's "latest" lookup hits the GitHub API,
  # which is prone to rate-limiting inside sandboxed/proxied environments.
  curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | RTK_VERSION="${RTK_VERSION:-v0.47.0}" sh
fi

echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$CLAUDE_ENV_FILE"

# Non-interactive global init for Claude Code.
rtk init -g --auto-patch

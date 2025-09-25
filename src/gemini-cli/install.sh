#!/usr/bin/env bash
set -e

echo "Activating feature 'GEMINI-CLI'"

VERSION="${VERSION:-latest}"
SET_API_KEY_ENV="${SETAPIKEYENV:-true}"

# Ensure Node.js and npm are installed
if ! command -v npm >/dev/null 2>&1; then
    echo "🔹 Installing Node.js and npm..."
    apt-get update
    apt-get install -y curl
    curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
    apt-get install -y nodejs
fi

echo "🔹 Installing Gemini CLI (version: $VERSION)"
if [ "$VERSION" = "latest" ]; then
    npm install -g @google/gemini-cli
else
    npm install -g @google/gemini-cli@"$VERSION"
fi

if [ "$SET_API_KEY_ENV" = "true" ] && [ -n "$GEMINI_API_KEY" ]; then
    echo "export GEMINI_API_KEY=${GEMINI_API_KEY}" >> /etc/profile.d/gemini-cli.sh
    echo "✅ GEMINI_API_KEY configured in container"
else
    echo "ℹ️ No GEMINI_API_KEY provided. Authenticate with 'gemini auth login'."
fi

echo "✅ Gemini CLI installation comple

#!/usr/bin/env bash
set -e

# Variables del feature
INSTALL_NODE="${INSTALL_NODE:-true}"
BMAD_VERSION="${VERSION:-latest}"

echo "🔍 Checking Node.js installation..."

if ! command -v node >/dev/null 2>&1; then
    if [ "$INSTALL_NODE" = "true" ]; then
        echo "📦 Node.js not found. Installing Node.js v20..."
        apt-get update
        apt-get install -y curl
        curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
        apt-get install -y nodejs
    else
        echo "⚠️ Node.js not found and installNode=false. Exiting."
        exit 1
    fi
else
    echo "✅ Node.js detected: $(node -v)"
fi

echo "📦 Installing BMAD METHOD..."
if [ "$BMAD_VERSION" = "latest" ]; then
    npm install -g bmad-method
else
    npm install -g bmad-method@"$BMAD_VERSION"
fi

echo "✅ Installation complete!"
echo "👉 Run 'bmad' inside the container."

#!/bin/bash
# 🚀 AetherCore v3.3.0 One-Command Installation
# Simplest installation method - just run this script

echo "🚀 Installing AetherCore v3.3.0..."
echo "Night Market Intelligence Technical Serviceization Practice"
echo ""

# Download and run the main installation script
if command -v curl &> /dev/null; then
    echo "📥 Downloading installation script..."
    curl -sSL https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install.sh -o /tmp/install_aethercore.sh
    chmod +x /tmp/install_aethercore.sh
    echo "🚀 Running installation..."
    /tmp/install_aethercore.sh
elif command -v wget &> /dev/null; then
    echo "📥 Downloading installation script..."
    wget -q https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install.sh -O /tmp/install_aethercore.sh
    chmod +x /tmp/install_aethercore.sh
    echo "🚀 Running installation..."
    /tmp/install_aethercore.sh
else
    echo "❌ Error: Neither curl nor wget found. Please install one of them."
    echo ""
    echo "Alternative installation methods:"
    echo "1. Clone repository and run install.sh:"
    echo "   git clone https://github.com/AetherClawAI/AetherCore"
    echo "   cd AetherCore && ./install.sh"
    echo ""
    echo "2. Manual installation:"
    echo "   See INSTALL.md for manual instructions"
    exit 1
fi
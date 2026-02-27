#!/bin/bash
# 🚀 AetherCore v3.3.0 One-Click Installation
# Night Market Intelligence Technical Serviceization Practice
# Smart cross-platform installation with automatic OS detection

echo "============================================================"
echo "🤖 AetherCore v3.3.0 Smart One-Click Installation"
echo "Night Market Intelligence Technical Serviceization Practice"
echo "============================================================"
echo ""
echo "🔍 Detecting your operating system..."
echo "📋 Using smart cross-platform installation system"
echo "🎯 Platform-specific optimization enabled"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Detect operating system
detect_os() {
    local os_type=$(uname -s)
    
    case "$os_type" in
        Darwin)
            echo "🍎 macOS detected - Using macOS-optimized installation"
            echo "macOS"
            ;;
        Linux)
            echo "🐧 Linux detected - Using Linux-optimized installation"
            echo "Linux"
            ;;
        *)
            echo "🌐 Unknown OS detected - Using universal installation"
            echo "Universal"
            ;;
    esac
}

# Show platform information
show_platform_info() {
    local os_type=$(uname -s)
    local os_details=""
    
    case "$os_type" in
        Darwin)
            if command -v sw_vers &> /dev/null; then
                local product_name=$(sw_vers -productName)
                local product_version=$(sw_vers -productVersion)
                os_details="$product_name $product_version ($(uname -m))"
            else
                os_details="macOS (Unknown version)"
            fi
            ;;
        Linux)
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                os_details="$NAME $VERSION_ID ($(uname -m))"
            elif [ -f /etc/lsb-release ]; then
                . /etc/lsb-release
                os_details="$DISTRIB_ID $DISTRIB_RELEASE ($(uname -m))"
            else
                os_details="Linux $(uname -r) ($(uname -m))"
            fi
            ;;
        *)
            os_details="$os_type $(uname -r) ($(uname -m))"
            ;;
    esac
    
    echo ""
    echo -e "${PURPLE}✨ Platform Detection Results:${NC}"
    echo "  🔍 Detected: $(detect_os)"
    echo "  📋 Details: $os_details"
    echo "  🚀 Installer: Smart cross-platform detection"
    echo ""
}

# Download and execute smart installer
download_and_execute() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} Downloading smart installer..."
    
    # Create temp directory for installer
    local temp_installer_dir="/tmp/aethercore-install-now-$(date +%s)"
    mkdir -p "$temp_installer_dir"
    local installer_path="$temp_installer_dir/install.sh"
    
    # Download smart installer
    if command -v curl &> /dev/null; then
        curl -sSL "https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install.sh" \
            -o "$installer_path" || {
            echo -e "${YELLOW}⚠️  Failed to download smart installer, trying alternative...${NC}"
            download_alternative
            return
        }
    elif command -v wget &> /dev/null; then
        wget -q "https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install.sh" \
            -O "$installer_path" || {
            echo -e "${YELLOW}⚠️  Failed to download smart installer, trying alternative...${NC}"
            download_alternative
            return
        }
    else
        echo -e "${RED}❌ Neither curl nor wget found. Please install one of them.${NC}"
        exit 1
    fi
    
    # Make executable and run
    chmod +x "$installer_path"
    echo -e "${GREEN}✅ Smart installer downloaded successfully${NC}"
    echo ""
    echo "============================================================"
    echo "🚀 Starting AetherCore Smart Installation..."
    echo "============================================================"
    echo ""
    exec "$installer_path"
}

# Alternative download method
download_alternative() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} Trying alternative download method..."
    
    # Try direct platform-specific installer
    local platform=$(detect_os)
    local installer_url=""
    
    case "$platform" in
        macOS)
            installer_url="https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-macos.sh"
            ;;
        Linux)
            installer_url="https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-linux.sh"
            ;;
        *)
            installer_url="https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-universal.sh"
            ;;
    esac
    
    local temp_installer_dir="/tmp/aethercore-alt-install-$(date +%s)"
    mkdir -p "$temp_installer_dir"
    local installer_path="$temp_installer_dir/install.sh"
    
    if command -v curl &> /dev/null; then
        curl -sSL "$installer_url" -o "$installer_path" || {
            echo -e "${RED}❌ All download methods failed. Please check your internet connection.${NC}"
            exit 1
        }
    elif command -v wget &> /dev/null; then
        wget -q "$installer_url" -O "$installer_path" || {
            echo -e "${RED}❌ All download methods failed. Please check your internet connection.${NC}"
            exit 1
        }
    fi
    
    chmod +x "$installer_path"
    echo -e "${GREEN}✅ Alternative installer downloaded successfully${NC}"
    echo ""
    echo "============================================================"
    echo "🚀 Starting AetherCore Installation..."
    echo "============================================================"
    echo ""
    exec "$installer_path"
}

# Handle errors
handle_error() {
    error_code=$?
    echo ""
    echo -e "${RED}❌ Installation failed with error code $error_code${NC}"
    echo ""
    echo "🔧 Troubleshooting tips:"
    echo "  1. Check network connectivity"
    echo "  2. Ensure you have curl or wget installed"
    echo "  3. Try platform-specific installer directly:"
    echo "     • macOS: curl -sSL https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-macos.sh | bash"
    echo "     • Linux: curl -sSL https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-linux.sh | bash"
    echo "     • Universal: curl -sSL https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-universal.sh | bash"
    echo ""
    exit $error_code
}

# Set error trap
trap handle_error ERR

# Show welcome message
echo -e "${PURPLE}✨ Welcome to AetherCore v3.3.0 Smart Installation!${NC}"
echo "  🎪 Night Market Intelligence Technical Serviceization Practice"
echo "  🤖 Intelligent platform detection and optimization"
echo "  🚀 One-command installation for all platforms"
echo ""

# Show platform information
show_platform_info

# Ask for confirmation
read -p "👉 Press Enter to continue with smart installation, or Ctrl+C to cancel... "
echo ""

# Start installation
download_and_execute

# This point should never be reached
echo -e "${RED}❌ Installation failed unexpectedly${NC}"
exit 1
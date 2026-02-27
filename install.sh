#!/bin/bash
# 🚀 AetherCore v3.3.0 Smart One-Click Installation
# Night Market Intelligence Technical Serviceization Practice
# Intelligent OS detection with platform-specific optimization

set -e  # Exit on error

echo "============================================================"
echo "🤖 AetherCore v3.3.0 Smart One-Click Installation"
echo "Night Market Intelligence Technical Serviceization Practice"
echo "============================================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
    exit 1
}

info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

highlight() {
    echo -e "${PURPLE}✨ $1${NC}"
}

# Detect operating system with details
detect_os_with_details() {
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
            echo "macOS|$os_details"
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
            echo "Linux|$os_details"
            ;;
        *)
            echo "Unknown|$os_type $(uname -r) ($(uname -m))"
            ;;
    esac
}

# Download and execute platform-specific installer
download_and_execute_installer() {
    local platform=$1
    local installer_url=""
    local installer_name=""
    
    case "$platform" in
        macOS)
            installer_url="https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-macos.sh"
            installer_name="install-macos.sh"
            ;;
        Linux)
            installer_url="https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-linux.sh"
            installer_name="install-linux.sh"
            ;;
        *)
            installer_url="https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-universal.sh"
            installer_name="install-universal.sh"
            ;;
    esac
    
    log "Downloading $platform-optimized installer..."
    
    # Create temp directory for installer
    local temp_installer_dir="/tmp/aethercore-smart-install-$(date +%s)"
    mkdir -p "$temp_installer_dir"
    local installer_path="$temp_installer_dir/$installer_name"
    
    # Download installer
    if command -v curl &> /dev/null; then
        curl -sSL "$installer_url" -o "$installer_path" || {
            warning "Failed to download $platform installer, falling back to universal..."
            download_and_execute_installer "Unknown"
            return
        }
    elif command -v wget &> /dev/null; then
        wget -q "$installer_url" -O "$installer_path" || {
            warning "Failed to download $platform installer, falling back to universal..."
            download_and_execute_installer "Unknown"
            return
        }
    else
        error "Neither curl nor wget found. Please install one of them."
    fi
    
    # Make executable and run
    chmod +x "$installer_path"
    log "Executing $platform-optimized installer..."
    echo ""
    exec "$installer_path"
}

# Show platform detection results
show_platform_info() {
    local detection_result=$(detect_os_with_details)
    local platform=$(echo "$detection_result" | cut -d'|' -f1)
    local details=$(echo "$detection_result" | cut -d'|' -f2)
    
    echo ""
    highlight "Platform Detection Results:"
    echo "  🔍 Detected: $platform"
    echo "  📋 Details: $details"
    echo "  🚀 Installer: $(echo "$platform" | tr '[:upper:]' '[:lower:]')-optimized"
    echo ""
    
    case "$platform" in
        macOS)
            info "🍎 macOS-optimized features:"
            echo "  • Uses rsync/tar for efficient file copying"
            echo "  • Handles .DS_Store files automatically"
            echo "  • Includes macOS-specific configurations"
            echo "  • Checks for Homebrew and Xcode tools"
            ;;
        Linux)
            info "🐧 Linux-optimized features:"
            echo "  • Uses GNU cp --parents for maximum efficiency"
            echo "  • Detects Linux distribution automatically"
            echo "  • Sets secure Unix permissions (755/644)"
            echo "  • Creates systemd service file if available"
            ;;
        *)
            info "🌐 Universal installation features:"
            echo "  • Cross-platform compatibility"
            echo "  • Simple and reliable file copying"
            echo "  • Works on any Unix-like system"
            echo "  • Includes basic error handling"
            ;;
    esac
    echo ""
}

# Main installation router
main() {
    # Show welcome message
    highlight "Welcome to AetherCore v3.3.0 Smart Installation!"
    echo "  🎪 Night Market Intelligence Technical Serviceization Practice"
    echo "  🤖 Intelligent platform detection and optimization"
    echo "  🚀 One-command installation for all platforms"
    echo ""
    
    # Detect platform
    local detection_result=$(detect_os_with_details)
    local platform=$(echo "$detection_result" | cut -d'|' -f1)
    local details=$(echo "$detection_result" | cut -d'|' -f2)
    
    # Show detection results
    show_platform_info
    
    # Ask for confirmation
    read -p "👉 Press Enter to continue with $platform-optimized installation, or Ctrl+C to cancel... "
    echo ""
    
    # Download and execute appropriate installer
    download_and_execute_installer "$platform"
}

# Handle installation options
handle_options() {
    # Check for help option
    if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]]; then
        echo ""
        highlight "AetherCore v3.3.0 Smart Installation Help"
        echo ""
        echo "Usage:"
        echo "  ./install.sh                    # Smart detection (recommended)"
        echo "  ./install.sh --macos            # Force macOS installation"
        echo "  ./install.sh --linux            # Force Linux installation"
        echo "  ./install.sh --universal        # Force universal installation"
        echo "  ./install.sh --help             # Show this help"
        echo ""
        echo "Platform-specific installers:"
        echo "  install-macos.sh    - macOS-optimized installation"
        echo "  install-linux.sh    - Linux-optimized installation"
        echo "  install-universal.sh - Universal cross-platform installation"
        echo ""
        echo "One-command installation:"
        echo "  curl -sSL https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/INSTALL_NOW.sh | bash"
        echo ""
        highlight "🎪 Night Market Intelligence Technical Serviceization Practice"
        echo "  Simple is beautiful, reliable is king, founder satisfaction is the highest honor!"
        echo ""
        exit 0
    fi
    
    # Check for platform override options
    case "$1" in
        --macos)
            log "Forcing macOS installation (override)..."
            download_and_execute_installer "macOS"
            ;;
        --linux)
            log "Forcing Linux installation (override)..."
            download_and_execute_installer "Linux"
            ;;
        --universal)
            log "Forcing universal installation (override)..."
            download_and_execute_installer "Unknown"
            ;;
        "")
            # No arguments, use smart detection
            main
            ;;
        *)
            error "Unknown option: $1. Use --help for usage information."
            ;;
    esac
}

# Handle errors
handle_error() {
    error_code=$?
    echo ""
    error "Smart installation failed with error code $error_code"
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

# Start installation with options
handle_options "$1"

# This point should never be reached due to exec in download_and_execute_installer
error "Installation failed unexpectedly"
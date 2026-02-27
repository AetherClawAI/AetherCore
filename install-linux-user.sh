#!/bin/bash
# 🚀 AetherCore v3.3.0 Linux User-Friendly Installation
# Night Market Intelligence Technical Serviceization Practice
# Linux installation without sudo requirements

set -e  # Exit on error

echo "============================================================"
echo "🐧 AetherCore v3.3.0 Linux User-Friendly Installation"
echo "Night Market Intelligence Technical Serviceization Practice"
echo "============================================================"

# Configuration
AETHERCORE_VERSION="3.3.0"
INSTALL_DIR="$HOME/.openclaw/skills/aethercore"
REPO_URL="https://github.com/AetherClawAI/AetherCore"
TEMP_DIR="/tmp/aethercore-install-linux-user-$(date +%s)"
LOG_FILE="/tmp/aethercore-install-linux-user-$(date +%Y%m%d_%H%M%S).log"

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
    echo -e "${BLUE}[$(date '+%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"
}

success() {
    echo -e "${GREEN}✅ $1${NC}" | tee -a "$LOG_FILE"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}❌ $1${NC}" | tee -a "$LOG_FILE"
    exit 1
}

info() {
    echo -e "${CYAN}ℹ️  $1${NC}" | tee -a "$LOG_FILE"
}

# Linux-specific checks (no sudo)
check_linux_prerequisites_no_sudo() {
    log "🐧 Checking Linux prerequisites (user mode)..."
    
    # Check if running on Linux
    if [ "$(uname -s)" != "Linux" ]; then
        error "This script is for Linux only. Detected: $(uname -s)"
    fi
    
    # Detect Linux distribution
    detect_linux_distro
    
    # Check for required Linux tools (user mode)
    local required_tools=("curl" "git" "python3")
    local missing_tools=()
    
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        log "Missing tools: ${missing_tools[*]}"
        log "Please install missing tools using your package manager:"
        show_install_commands_no_sudo "${missing_tools[@]}"
        error "Required tools missing. Please install them and try again."
    fi
    
    # Check Python pip (user install)
    if ! command -v pip3 &> /dev/null && ! command -v pip &> /dev/null; then
        warning "pip not found. Will use --user install or get-pip.py"
        log "To install pip: python3 -m ensurepip --user"
    fi
    
    success "Linux prerequisites check passed (user mode)"
}

# Show install commands without sudo
show_install_commands_no_sudo() {
    local tools=("$@")
    
    case "$LINUX_DISTRO" in
        *Ubuntu*|*Debian*)
            echo "  For Ubuntu/Debian:"
            echo "    sudo apt update"
            echo "    sudo apt install -y ${tools[*]}"
            ;;
        *CentOS*|*RHEL*|*Fedora*)
            if command -v dnf &> /dev/null; then
                echo "  For Fedora/RHEL 8+:"
                echo "    sudo dnf install -y ${tools[*]}"
            elif command -v yum &> /dev/null; then
                echo "  For CentOS/RHEL 7:"
                echo "    sudo yum install -y ${tools[*]}"
            fi
            ;;
        *Arch*)
            echo "  For Arch Linux:"
            echo "    sudo pacman -Sy ${tools[*]}"
            ;;
        *openSUSE*)
            echo "  For openSUSE:"
            echo "    sudo zypper install -y ${tools[*]}"
            ;;
        *)
            echo "  Please install manually: ${tools[*]}"
            ;;
    esac
    echo ""
    echo "  Or ask your system administrator for help."
}

# Detect Linux distribution
detect_linux_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        LINUX_DISTRO="$NAME"
        LINUX_VERSION="$VERSION_ID"
        log "Distribution: $LINUX_DISTRO $LINUX_VERSION"
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        LINUX_DISTRO="$DISTRIB_ID"
        LINUX_VERSION="$DISTRIB_RELEASE"
        log "Distribution: $LINUX_DISTRO $LINUX_VERSION"
    elif [ -f /etc/redhat-release ]; then
        LINUX_DISTRO=$(cat /etc/redhat-release)
        log "Distribution: $LINUX_DISTRO"
    elif [ -f /etc/debian_version ]; then
        LINUX_DISTRO="Debian $(cat /etc/debian_version)"
        log "Distribution: $LINUX_DISTRO"
    else
        LINUX_DISTRO="Unknown Linux"
        warning "Could not detect Linux distribution"
    fi
}

# User-friendly file copying (no special permissions needed)
copy_files_user_friendly() {
    log "📄 Copying files (user-friendly method)..."
    
    cd "$TEMP_DIR" || error "Failed to enter temp directory"
    
    # Simple copy method that works without special permissions
    log "Using simple copy method (user-friendly)..."
    
    # Copy all files and directories
    if cp -R . "$INSTALL_DIR" 2>/dev/null; then
        # Remove .git directory if copied
        rm -rf "$INSTALL_DIR/.git" 2>/dev/null || true
    else
        # Fallback: copy files individually
        warning "Recursive copy failed, using fallback method..."
        find . -type d -not -name ".git" -not -path "./.git/*" -exec mkdir -p "$INSTALL_DIR/{}" \; 2>/dev/null
        find . -type f -not -path "./.git/*" -exec cp {} "$INSTALL_DIR/{}" \; 2>/dev/null
    fi
    
    # Verify critical files
    verify_critical_files_user
    
    success "Files copied using user-friendly method"
}

# Verify critical files (user mode)
verify_critical_files_user() {
    log "🔍 Verifying critical files..."
    
    local critical_files=("SKILL.md" "README.md" "clawhub.json" "requirements.txt")
    local missing_files=()
    
    for file in "${critical_files[@]}"; do
        if [ ! -f "$INSTALL_DIR/$file" ]; then
            missing_files+=("$file")
            warning "Critical file missing: $file"
        fi
    done
    
    if [ ${#missing_files[@]} -gt 0 ]; then
        log "🔄 Downloading missing files from GitHub..."
        for file in "${missing_files[@]}"; do
            log "Downloading $file..."
            curl -sSL "https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/$file" \
                -o "$INSTALL_DIR/$file" 2>/dev/null || warning "Failed to download $file"
        done
    fi
    
    # Final verification
    for file in "${critical_files[@]}"; do
        if [ ! -f "$INSTALL_DIR/$file" ]; then
            error "Critical file still missing: $file"
        fi
    done
    
    log "✅ All critical files verified"
}

# Install dependencies without sudo
install_dependencies_no_sudo() {
    log "🔧 Installing Python dependencies (user mode)..."
    
    cd "$INSTALL_DIR" || error "Failed to enter installation directory"
    
    if [ -f "requirements.txt" ]; then
        log "Installing from requirements.txt (user mode)..."
        
        # Try user install first
        if command -v pip3 &> /dev/null; then
            pip3 install --user -r requirements.txt --quiet || {
                warning "Some dependencies may not have installed correctly"
                log "Trying alternative installation methods..."
                install_dependencies_alternative
            }
        elif command -v pip &> /dev/null; then
            pip install --user -r requirements.txt --quiet || {
                warning "Some dependencies may not have installed correctly"
                install_dependencies_alternative
            }
        else
            warning "pip not found, trying alternative methods..."
            install_dependencies_alternative
        fi
    else
        log "No requirements.txt found, installing core dependencies..."
        install_core_dependencies_no_sudo
    fi
    
    success "Dependencies installed (user mode)"
}

# Alternative dependency installation
install_dependencies_alternative() {
    log "Trying alternative dependency installation..."
    
    # Try without --user flag
    if command -v pip3 &> /dev/null; then
        pip3 install -r requirements.txt --quiet || true
    elif command -v pip &> /dev/null; then
        pip install -r requirements.txt --quiet || true
    fi
    
    # Install core dependencies individually
    install_core_dependencies_no_sudo
}

# Install core dependencies without sudo
install_core_dependencies_no_sudo() {
    log "Installing core dependencies (user mode)..."
    
    CORE_DEPS=("orjson" "ujson" "python-rapidjson")
    for dep in "${CORE_DEPS[@]}"; do
        log "Installing $dep..."
        if command -v pip3 &> /dev/null; then
            pip3 install --user "$dep" --quiet || warning "Failed to install $dep (user mode)"
        elif command -v pip &> /dev/null; then
            pip install --user "$dep" --quiet || warning "Failed to install $dep (user mode)"
        fi
    done
}

# User-friendly post-installation
post_install_user_friendly() {
    log "🔧 User-friendly post-installation steps..."
    
    cd "$INSTALL_DIR" || error "Failed to enter installation directory"
    
    # Set basic permissions (user mode)
    log "Setting basic permissions..."
    find . -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
    find . -type f -name "*.py" -exec chmod +x {} \; 2>/dev/null || true
    
    # Create user-friendly configuration
    log "Creating user-friendly configuration..."
    cat > "$INSTALL_DIR/.user_config" << EOF
# User Configuration for AetherCore v$AETHERCORE_VERSION
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
# Linux Distribution: $LINUX_DISTRO
# Kernel: $(uname -r)
# Architecture: $(uname -m)
# Install Method: Linux User-Friendly Installation
# User: $(whoami)

# Installation Notes
- No sudo required for installation
- User mode dependencies
- Basic permissions set
- Works without special privileges

# Night Market Intelligence Technical Serviceization Practice
# Simple is beautiful, reliable is king, founder satisfaction is the highest honor!
EOF
    
    success "User-friendly post-installation completed"
}

# Main installation function (user-friendly)
main_installation_user_friendly() {
    log "🚀 Starting Linux User-Friendly Installation..."
    
    # Record start time
    START_TIME=$(date +%s)
    
    # Execute user-friendly installation steps
    check_linux_prerequisites_no_sudo
    
    # Create installation directory
    log "📁 Creating installation directory..."
    mkdir -p "$INSTALL_DIR" || error "Failed to create installation directory"
    
    # Download AetherCore
    log "📥 Downloading AetherCore..."
    if command -v git &> /dev/null; then
        git clone --depth 1 "$REPO_URL" "$TEMP_DIR" || error "Failed to clone repository"
    else
        error "git not found. Required for installation."
    fi
    
    copy_files_user_friendly
    install_dependencies_no_sudo
    post_install_user_friendly
    
    # Calculate installation time
    END_TIME=$(date +%s)
    INSTALLATION_TIME=$((END_TIME - START_TIME))
    
    # Final success message
    echo ""
    echo "============================================================"
    echo "🎉 AetherCore v$AETHERCORE_VERSION Linux Installation Complete!"
    echo "============================================================"
    echo ""
    echo "📊 Installation Summary:"
    echo "  ✅ Platform: Linux (User-Friendly)"
    echo "  ✅ Distribution: $LINUX_DISTRO"
    echo "  ✅ Version: $AETHERCORE_VERSION"
    echo "  ✅ Time: ${INSTALLATION_TIME} seconds"
    echo "  ✅ Directory: $INSTALL_DIR"
    echo "  ✅ Log File: $LOG_FILE"
    echo "  ✅ Mode: No sudo required"
    echo ""
    echo "🚀 Next Steps:"
    echo "  1. Check installation: openclaw skills list | grep aethercore"
    echo "  2. Restart OpenClaw if needed: openclaw gateway restart"
    echo "  3. Get help: openclaw skill run aethercore --help"
    echo "  4. Configure automation: cd $INSTALL_DIR && ./CRON_SETUP.sh"
    echo ""
    echo "🐧 User-Friendly Features:"
    echo "  • No sudo required for installation"
    echo "  • User mode dependency installation"
    echo "  • Works without special privileges"
    echo "  • Basic permissions automatically set"
    echo ""
    echo "🎪 Night Market Intelligence Technical Serviceization Practice"
    echo "Linux User-Friendly installation successfully completed!"
    echo ""
    echo "😈🐾⚛️✨ Ready to create value on Linux!"
    echo "============================================================"
}

# Handle errors
handle_error() {
    error_code=$?
    error "Linux user-friendly installation failed with error code $error_code"
    echo "Check log file for details: $LOG_FILE"
    echo ""
    echo "🐧 Troubleshooting tips:"
    echo "  1. Check if you have required tools: curl, git, python3"
    echo "  2. Check disk space in your home directory"
    echo "  3. Check network connectivity"
    echo "  4. Try universal installer: curl -sSL https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-universal.sh | bash"
    echo ""
    exit $error_code
}

# Set error trap
trap handle_error ERR

# Start user-friendly installation
main_installation_user_friendly

exit 0
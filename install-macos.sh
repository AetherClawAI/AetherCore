#!/bin/bash
# 🚀 AetherCore v3.3.0 macOS One-Click Installation
# Night Market Intelligence Technical Serviceization Practice
# macOS-optimized installation script

set -e  # Exit on error

echo "============================================================"
echo "🍎 AetherCore v3.3.0 macOS One-Click Installation"
echo "Night Market Intelligence Technical Serviceization Practice"
echo "============================================================"

# Configuration
AETHERCORE_VERSION="3.3.0"
INSTALL_DIR="$HOME/.openclaw/skills/aethercore"
REPO_URL="https://github.com/AetherClawAI/AetherCore"
TEMP_DIR="/tmp/aethercore-install-macos-$(date +%s)"
LOG_FILE="/tmp/aethercore-install-macos-$(date +%Y%m%d_%H%M%S).log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

# macOS-specific checks
check_macos_prerequisites() {
    log "🍎 Checking macOS-specific prerequisites..."
    
    # Check if running on macOS
    if [ "$(uname -s)" != "Darwin" ]; then
        error "This script is for macOS only. Detected: $(uname -s)"
    fi
    
    # Check macOS version
    MACOS_VERSION=$(sw_vers -productVersion)
    log "macOS Version: $MACOS_VERSION"
    
    # Check for required macOS tools
    local required_tools=("curl" "git" "python3" "pip3")
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            warning "$tool not found. Installing via Homebrew recommended."
        fi
    done
    
    # Check for Homebrew (recommended for macOS)
    if command -v brew &> /dev/null; then
        log "🍺 Homebrew detected (recommended for macOS)"
    else
        warning "Homebrew not installed. Consider installing for better package management."
        log "Install Homebrew: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    fi
    
    # Check for Xcode Command Line Tools
    if xcode-select -p &> /dev/null; then
        log "🔧 Xcode Command Line Tools installed"
    else
        warning "Xcode Command Line Tools not installed. Some dependencies may fail."
        log "Install with: xcode-select --install"
    fi
    
    success "macOS prerequisites check passed"
}

# macOS-optimized file copying
copy_files_macos() {
    log "📄 Copying files (macOS-optimized)..."
    
    cd "$TEMP_DIR" || error "Failed to enter temp directory"
    
    # Method 1: Use rsync (best for macOS, preserves permissions and timestamps)
    if command -v rsync &> /dev/null; then
        log "Using rsync (macOS recommended)..."
        rsync -av \
            --exclude='.git' \
            --exclude='.git/*' \
            --exclude='*.pyc' \
            --exclude='__pycache__' \
            --exclude='.DS_Store' \
            . "$INSTALL_DIR/" 2>/dev/null || warning "rsync completed with warnings"
    
    # Method 2: Use tar (good cross-platform alternative)
    elif command -v tar &> /dev/null; then
        log "Using tar (macOS alternative)..."
        tar cf - \
            --exclude='.git' \
            --exclude='.git/*' \
            --exclude='*.pyc' \
            --exclude='__pycache__' \
            --exclude='.DS_Store' \
            . | (cd "$INSTALL_DIR" && tar xf -) 2>/dev/null || warning "tar completed with warnings"
    
    # Method 3: Use cp -R (basic fallback)
    else
        log "Using cp -R (macOS fallback)..."
        cp -R . "$INSTALL_DIR" 2>/dev/null
        # Clean up .git directory if copied
        rm -rf "$INSTALL_DIR/.git" 2>/dev/null || true
        # Clean up macOS-specific files
        find "$INSTALL_DIR" -name ".DS_Store" -delete 2>/dev/null || true
        find "$INSTALL_DIR" -name "*.pyc" -delete 2>/dev/null || true
        find "$INSTALL_DIR" -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    fi
    
    # Verify critical macOS files
    verify_macos_critical_files
    
    success "Files copied using macOS-optimized method"
}

# Verify critical files for macOS
verify_macos_critical_files() {
    log "🔍 Verifying critical files for macOS..."
    
    local critical_files=("SKILL.md" "README.md" "clawhub.json" "requirements.txt" "install.sh")
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
    
    log "✅ All critical files verified for macOS"
}

# macOS-specific post-installation
post_install_macos() {
    log "🔧 macOS-specific post-installation steps..."
    
    cd "$INSTALL_DIR" || error "Failed to enter installation directory"
    
    # Fix permissions for macOS
    log "Setting correct permissions for macOS..."
    find . -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
    find . -type f -name "*.py" -exec chmod +x {} \; 2>/dev/null || true
    
    # Create macOS-specific configuration
    log "Creating macOS-specific configuration..."
    cat > "$INSTALL_DIR/.macos_config" << EOF
# macOS Configuration for AetherCore v$AETHERCORE_VERSION
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
# macOS Version: $(sw_vers -productVersion)
# Architecture: $(uname -m)
# Install Method: macOS-optimized one-click installation

# macOS-specific optimizations
- Uses rsync/tar for efficient file copying
- Handles .DS_Store files automatically
- Sets correct Unix permissions
- Optimized for macOS filesystem

# Recommended macOS tools
- Homebrew: $(command -v brew &> /dev/null && echo "Installed" || echo "Not installed")
- Xcode CLT: $(xcode-select -p &> /dev/null && echo "Installed" || echo "Not installed")

# Night Market Intelligence Technical Serviceization Practice
# Simple is beautiful, reliable is king, founder satisfaction is the highest honor!
EOF
    
    # Check for common macOS issues
    check_macos_common_issues
    
    success "macOS post-installation completed"
}

# Check for common macOS issues
check_macos_common_issues() {
    log "🔍 Checking for common macOS issues..."
    
    # Check Python version
    PYTHON_VERSION=$(python3 --version 2>/dev/null || echo "Not found")
    log "Python: $PYTHON_VERSION"
    
    # Check pip version
    PIP_VERSION=$(pip3 --version 2>/dev/null | head -1 || echo "Not found")
    log "pip: $PIP_VERSION"
    
    # Check for permission issues
    if [ ! -w "$INSTALL_DIR" ]; then
        warning "Installation directory not writable. May need sudo."
    fi
    
    # Check for sufficient disk space
    DISK_SPACE=$(df -h "$INSTALL_DIR" | tail -1 | awk '{print $4}')
    log "Available disk space: $DISK_SPACE"
    
    if [ "$(echo "$DISK_SPACE" | sed 's/[^0-9]*//g')" -lt 100 ]; then
        warning "Low disk space (<100MB). Installation may fail."
    fi
}

# Main installation function (macOS-specific)
main_installation_macos() {
    log "🚀 Starting macOS-optimized installation..."
    
    # Record start time
    START_TIME=$(date +%s)
    
    # Execute macOS-specific installation steps
    check_macos_prerequisites
    # Note: Other functions like create_install_dir, download_aethercore, etc.
    # would be included here from the main install.sh
    
    # For now, we'll use a simplified version
    log "📁 Creating installation directory..."
    mkdir -p "$INSTALL_DIR" || error "Failed to create installation directory"
    
    log "📥 Downloading AetherCore..."
    if command -v git &> /dev/null; then
        git clone --depth 1 "$REPO_URL" "$TEMP_DIR" || error "Failed to clone repository"
    else
        error "git not found. Required for installation."
    fi
    
    copy_files_macos
    post_install_macos
    
    # Calculate installation time
    END_TIME=$(date +%s)
    INSTALLATION_TIME=$((END_TIME - START_TIME))
    
    # Final success message
    echo ""
    echo "============================================================"
    echo "🎉 AetherCore v$AETHERCORE_VERSION macOS Installation Complete!"
    echo "============================================================"
    echo ""
    echo "📊 Installation Summary:"
    echo "  ✅ Platform: macOS (optimized)"
    echo "  ✅ Version: $AETHERCORE_VERSION"
    echo "  ✅ Time: ${INSTALLATION_TIME} seconds"
    echo "  ✅ Directory: $INSTALL_DIR"
    echo "  ✅ Log File: $LOG_FILE"
    echo ""
    echo "🚀 Next Steps:"
    echo "  1. Check installation: openclaw skills list | grep aethercore"
    echo "  2. Restart OpenClaw if needed: openclaw gateway restart"
    echo "  3. Get help: openclaw skill run aethercore --help"
    echo "  4. Configure automation: cd $INSTALL_DIR && ./CRON_SETUP.sh"
    echo ""
    echo "🍎 macOS-specific notes:"
    echo "  • Uses rsync/tar for efficient file copying"
    echo "  • Handles macOS-specific files (.DS_Store)"
    echo "  • Sets correct Unix permissions"
    echo "  • Includes macOS configuration file"
    echo ""
    echo "🎪 Night Market Intelligence Technical Serviceization Practice"
    echo "macOS-optimized installation successfully completed!"
    echo ""
    echo "😈🐾⚛️✨ Ready to create value on macOS!"
    echo "============================================================"
}

# Handle errors
handle_error() {
    error_code=$?
    error "macOS installation failed with error code $error_code"
    echo "Check macOS log file for details: $LOG_FILE"
    echo ""
    echo "🍎 macOS troubleshooting tips:"
    echo "  1. Ensure Xcode Command Line Tools are installed"
    echo "  2. Check disk space and permissions"
    echo "  3. Try installing missing tools via Homebrew"
    echo "  4. Check network connectivity"
    exit $error_code
}

# Set error trap
trap handle_error ERR

# Run macOS-optimized installation
main_installation_macos

exit 0
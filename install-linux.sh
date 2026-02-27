#!/bin/bash
# 🚀 AetherCore v3.3.0 Linux One-Click Installation
# Night Market Intelligence Technical Serviceization Practice
# Linux-optimized installation script

set -e  # Exit on error

echo "============================================================"
echo "🐧 AetherCore v3.3.0 Linux One-Click Installation"
echo "Night Market Intelligence Technical Serviceization Practice"
echo "============================================================"

# Configuration
AETHERCORE_VERSION="3.3.0"
INSTALL_DIR="$HOME/.openclaw/skills/aethercore"
REPO_URL="https://github.com/AetherClawAI/AetherCore"
TEMP_DIR="/tmp/aethercore-install-linux-$(date +%s)"
LOG_FILE="/tmp/aethercore-install-linux-$(date +%Y%m%d_%H%M%S).log"

# Colors for output (Linux supports more colors)
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

# Linux-specific checks
check_linux_prerequisites() {
    log "🐧 Checking Linux-specific prerequisites..."
    
    # Check if running on Linux
    if [ "$(uname -s)" != "Linux" ]; then
        error "This script is for Linux only. Detected: $(uname -s)"
    fi
    
    # Detect Linux distribution
    detect_linux_distro
    
    # Check for required Linux tools
    local required_tools=("curl" "git" "python3" "pip3")
    local missing_tools=()
    
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        log "Installing missing tools for $LINUX_DISTRO..."
        install_linux_tools "${missing_tools[@]}"
    fi
    
    # Check for systemd (common on modern Linux)
    if command -v systemctl &> /dev/null; then
        log "📦 systemd detected (common on modern Linux)"
    else
        warning "systemd not detected. Service management may differ."
    fi
    
    # Check for apt/yum/dnf package managers
    if command -v apt &> /dev/null; then
        log "📦 APT package manager detected (Debian/Ubuntu)"
    elif command -v yum &> /dev/null; then
        log "📦 YUM package manager detected (RHEL/CentOS)"
    elif command -v dnf &> /dev/null; then
        log "📦 DNF package manager detected (Fedora)"
    elif command -v pacman &> /dev/null; then
        log "📦 Pacman package manager detected (Arch)"
    elif command -v zypper &> /dev/null; then
        log "📦 Zypper package manager detected (openSUSE)"
    else
        warning "Unknown package manager. Manual dependency installation may be needed."
    fi
    
    success "Linux prerequisites check passed"
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

# Install Linux tools based on distribution
install_linux_tools() {
    local tools=("$@")
    
    case "$LINUX_DISTRO" in
        *Ubuntu*|*Debian*)
            log "Installing tools using apt..."
            sudo apt update && sudo apt install -y "${tools[@]}" 2>/dev/null || warning "Some tools may not have installed"
            ;;
        *CentOS*|*RHEL*|*Fedora*)
            if command -v dnf &> /dev/null; then
                log "Installing tools using dnf..."
                sudo dnf install -y "${tools[@]}" 2>/dev/null || warning "Some tools may not have installed"
            elif command -v yum &> /dev/null; then
                log "Installing tools using yum..."
                sudo yum install -y "${tools[@]}" 2>/dev/null || warning "Some tools may not have installed"
            fi
            ;;
        *Arch*)
            log "Installing tools using pacman..."
            sudo pacman -Sy --noconfirm "${tools[@]}" 2>/dev/null || warning "Some tools may not have installed"
            ;;
        *openSUSE*)
            log "Installing tools using zypper..."
            sudo zypper install -y "${tools[@]}" 2>/dev/null || warning "Some tools may not have installed"
            ;;
        *)
            warning "Unknown distribution. Please install manually: ${tools[*]}"
            ;;
    esac
}

# Linux-optimized file copying (using GNU cp --parents)
copy_files_linux() {
    log "📄 Copying files (Linux-optimized)..."
    
    cd "$TEMP_DIR" || error "Failed to enter temp directory"
    
    # Method 1: Use GNU cp --parents (most efficient for Linux)
    if cp --version 2>/dev/null | grep -q "GNU coreutils"; then
        log "Using GNU cp --parents (Linux optimized)..."
        find . -type f -not -path "./.git/*" -exec cp --parents {} "$INSTALL_DIR" \; 2>/dev/null
        
        # Create directories (cp --parents may not create empty directories)
        find . -type d -not -name ".git" -not -path "./.git/*" -exec mkdir -p "$INSTALL_DIR/{}" \; 2>/dev/null
    
    # Method 2: Use rsync (good alternative)
    elif command -v rsync &> /dev/null; then
        log "Using rsync (Linux alternative)..."
        rsync -av --exclude='.git' --exclude='.git/*' . "$INSTALL_DIR/" 2>/dev/null
    
    # Method 3: Use tar (universal fallback)
    elif command -v tar &> /dev/null; then
        log "Using tar (Linux fallback)..."
        tar cf - --exclude='.git' --exclude='.git/*' . | (cd "$INSTALL_DIR" && tar xf -) 2>/dev/null
    
    # Method 4: Manual copying
    else
        log "Using manual copying (Linux basic)..."
        find . -type d -not -name ".git" -not -path "./.git/*" -exec mkdir -p "$INSTALL_DIR/{}" \; 2>/dev/null
        find . -type f -not -path "./.git/*" -exec cp {} "$INSTALL_DIR/{}" \; 2>/dev/null
    fi
    
    # Verify critical Linux files
    verify_linux_critical_files
    
    success "Files copied using Linux-optimized method"
}

# Verify critical files for Linux
verify_linux_critical_files() {
    log "🔍 Verifying critical files for Linux..."
    
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
    
    log "✅ All critical files verified for Linux"
}

# Linux-specific post-installation
post_install_linux() {
    log "🔧 Linux-specific post-installation steps..."
    
    cd "$INSTALL_DIR" || error "Failed to enter installation directory"
    
    # Fix permissions for Linux
    log "Setting correct permissions for Linux..."
    find . -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
    find . -type f -name "*.py" -exec chmod +x {} \; 2>/dev/null || true
    
    # Set strict permissions for security
    log "Setting security permissions..."
    chmod 755 . 2>/dev/null || true
    find . -type f -exec chmod 644 {} \; 2>/dev/null || true
    find . -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod 755 {} \; 2>/dev/null || true
    
    # Create Linux-specific configuration
    log "Creating Linux-specific configuration..."
    cat > "$INSTALL_DIR/.linux_config" << EOF
# Linux Configuration for AetherCore v$AETHERCORE_VERSION
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
# Linux Distribution: $LINUX_DISTRO
# Kernel: $(uname -r)
# Architecture: $(uname -m)
# Install Method: Linux-optimized one-click installation

# Linux-specific optimizations
- Uses GNU cp --parents for efficient file copying
- Sets secure Unix permissions (755/644)
- Handles Linux filesystem optimizations
- Includes distribution-specific configurations

# System Information
- Distribution: $LINUX_DISTRO
- Package Manager: $(command -v apt && echo "APT" || command -v yum && echo "YUM" || command -v dnf && echo "DNF" || command -v pacman && echo "Pacman" || command -v zypper && echo "Zypper" || echo "Unknown")
- Systemd: $(command -v systemctl &> /dev/null && echo "Available" || echo "Not available")

# Night Market Intelligence Technical Serviceization Practice
# Simple is beautiful, reliable is king, founder satisfaction is the highest honor!
EOF
    
    # Create systemd service file (if systemd is available)
    if command -v systemctl &> /dev/null; then
        log "Creating systemd service configuration..."
        cat > "$INSTALL_DIR/aethercore-systemd.service" << EOF
[Unit]
Description=AetherCore v$AETHERCORE_VERSION - Night Market Intelligence JSON Optimization
After=network.target

[Service]
Type=simple
User=$(whoami)
WorkingDirectory=$INSTALL_DIR
ExecStart=/usr/bin/python3 $INSTALL_DIR/src/core/json_performance_engine.py
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF
        log "ℹ️  Systemd service file created: $INSTALL_DIR/aethercore-systemd.service"
        log "To enable: sudo cp aethercore-systemd.service /etc/systemd/system/ && sudo systemctl enable aethercore-systemd.service"
    fi
    
    # Check for common Linux issues
    check_linux_common_issues
    
    success "Linux post-installation completed"
}

# Check for common Linux issues
check_linux_common_issues() {
    log "🔍 Checking for common Linux issues..."
    
    # Check Python version
    PYTHON_VERSION=$(python3 --version 2>/dev/null || echo "Not found")
    log "Python: $PYTHON_VERSION"
    
    # Check pip version
    PIP_VERSION=$(pip3 --version 2>/dev/null | head -1 || echo "Not found")
    log "pip: $PIP_VERSION"
    
    # Check SELinux status (RHEL/CentOS/Fedora)
    if command -v sestatus &> /dev/null; then
        SELINUX_STATUS=$(sestatus | grep "SELinux status" | cut -d: -f2 | tr -d ' ')
        log "SELinux: $SELINUX_STATUS"
        if [ "$SELINUX_STATUS" = "enabled" ]; then
            warning "SELinux is enabled. May need to adjust policies."
        fi
    fi
    
    # Check AppArmor status (Debian/Ubuntu)
    if command -v aa-status &> /dev/null; then
        APPARMOR_STATUS=$(aa-status 2>/dev/null | grep "apparmor module is loaded" || echo "Not loaded")
        log "AppArmor: $APPARMOR_STATUS"
    fi
    
    # Check for sufficient disk space
    DISK_SPACE=$(df -h "$INSTALL_DIR" 2>/dev/null | tail -1 | awk '{print $4}' || echo "Unknown")
    log "Available disk space: $DISK_SPACE"
    
    # Check memory
    MEMORY=$(free -h 2>/dev/null | grep Mem | awk '{print $2}' || echo "Unknown")
    log "Total memory: $MEMORY"
}

# Main installation function (Linux-specific)
main_installation_linux() {
    log "🚀 Starting Linux-optimized installation..."
    
    # Record start time
    START_TIME=$(date +%s)
    
    # Execute Linux-specific installation steps
    check_linux_prerequisites
    
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
    
    copy_files_linux
    post_install_linux
    
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
    echo "  ✅ Platform: Linux (optimized)"
    echo "  ✅ Distribution: $LINUX_DISTRO"
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
    echo "🐧 Linux-specific features:"
    echo "  • Uses GNU cp --parents for maximum efficiency"
    echo "  • Sets secure Unix permissions (755/644)"
    echo "  • Includes distribution-specific configurations"
    echo "  • Creates systemd service file (if available)"
    echo "  • Handles SELinux/AppArmor considerations"
    echo ""
    echo "🎪 Night Market Intelligence Technical Serviceization Practice"
    echo "Linux-optimized installation successfully completed!"
    echo ""
    echo "😈🐾⚛️✨ Ready to create value on Linux!"
    echo "============================================================"
}

# Handle errors
handle_error() {
    error_code=$?
    error "Linux installation failed with error code $error_code"
    echo "Check Linux log file for details: $LOG_FILE"
    echo ""
    echo "🐧 Linux troubleshooting tips:"
    echo "  1. Check package manager and install missing tools"
    echo "  2. Check disk space and permissions"
    echo "  3. Check SELinux/AppArmor if applicable"
    echo "  4. Check network connectivity"
    echo "  5. Try user-friendly installer (no sudo):"
    echo "     curl -sSL https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-linux-user.sh | bash"
    echo "  6. Try universal installer:"
    echo "     curl -sSL https://raw.githubusercontent.com/AetherClawAI/AetherCore/main/install-universal.sh | bash"
    exit $error_code
}

# Set error trap
trap handle_error ERR

# Start Linux-optimized installation
main_installation_linux

exit 0
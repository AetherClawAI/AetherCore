# English Version
*Translated from Chinese for international release*
*Date: 2026-02-27*
*Translator: AetherClaw Night Market Intelligence*
# AetherCore Installation Guide
This guide provides step-by-step instructions for installing AetherCore v3.3.
## 📋 Prerequisites
### System Requirements
- **Python**: 3.8 or higher
- **Operating System**: Windows, macOS, or Linux
- **Memory**: Minimum 2GB RAM (4GB recommended)
- **Storage**: 100MB free space
### Python Knowledge
- Basic understanding of Python
- Familiarity with pip package manager
- Knowledge of virtual environments (recommended)
## 🚀 Quick Installation
### Method 1: Install from ClawHub (Recommended)
```bash
# Install using ClawHub package manager
clawhub install aethercore
# Or using pip with ClawHub repository
pip install aethercore --extra-index-url https://clawhub.ai/packages/
```
### Method 2: Install from Source
```bash
# Clone the repository
git clone https://clawhub.ai/aethercore/aethercore.git
cd aethercore
# Install in development mode
pip install -e .
# Install with all optional dependencies
pip install -e ".[all]"
```
### Method 3: Install Specific Components
```bash
# Install core functionality only
pip install aethercore
# Install with performance dependencies
pip install "aethercore[performance]"
# Install with API dependencies
pip install "aethercore[api]"
# Install for development
pip install "aethercore[dev]"
```
## 🔧 Detailed Installation Steps
### Step 1: Verify Python Installation
```bash
# Check Python version
python --version
# Should show Python 3.8 or higher
# Check pip version
pip --version
```
### Step 2: Create Virtual Environment (Recommended)
```bash
# Create virtual environment
python -m venv aethercore-env
# Activate on macOS/Linux
source aethercore-env/bin/activate
# Activate on Windows
aethercore-env\Scripts\activate
```
### Step 3: Install AetherCore
```bash
# Install from PyPI (when available)
pip install aethercore
# Or install from ClawHub
clawhub install aethercore
```
### Step 4: Verify Installation
```bash
# Check if installed correctly
python -c "import aethercore; print(aethercore.__version__)"
# Run basic test
python -c "from aethercore.core.json_performance_engine import NightMarketJSONOptimizer; print('Installation successful!')"
```
## 🐳 Docker Installation
### Using Docker Compose
```yaml
# docker-compose.yml
version: '3.8'
services:
  aethercore:
    image: aethercore:latest
    ports:
      - "8000:8000"
    volumes:
      - ./data:/app/data
    environment:
      - AETHERCORE_ENV=production
```
```bash
# Start with Docker Compose
docker-compose up -d
# Check status
docker-compose ps
```
### Using Docker Directly
```bash
# Pull the image
docker pull aethercore/aethercore:latest
# Run container
docker run -p 8000:8000 -v $(pwd)/data:/app/data aethercore/aethercore:latest
```
## 📦 Package Manager Installation
### Using pip
```bash
# Latest stable version
pip install aethercore
# Specific version
pip install aethercore==3.3.0
# Upgrade existing installation
pip install --upgrade aethercore
```
### Using poetry
```bash
# Add to poetry project
poetry add aethercore
# With specific version
poetry add aethercore@^3.3.0
```
### Using conda
```bash
# Create conda environment
conda create -n aethercore python=3.9
conda activate aethercore
# Install from conda-forge (when available)
conda install -c conda-forge aethercore
```
## 🖥️ Platform-Specific Instructions
### macOS Installation
```bash
# Install using Homebrew (when available)
brew install aethercore
# Or using pip
pip3 install aethercore
```
### Linux Installation
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3-pip
pip3 install aethercore
# Fedora/RHEL
sudo dnf install python3-pip
pip3 install aethercore
# Arch Linux
sudo pacman -S python-pip
pip install aethercore
```
### Windows Installation
```powershell
# Using PowerShell
python -m pip install aethercore
# Or using Chocolatey (when available)
choco install aethercore
```
## 🔌 Integration with OpenClaw
### OpenClaw Skill Installation
```bash
# Copy to OpenClaw skills directory
cp -r aethercore ~/.openclaw/skills/
# Or clone directly
cd ~/.openclaw/skills/
git clone https://clawhub.ai/aethercore/aethercore.git
# Enable auto-load
echo "AetherCore v3.3" > ~/.openclaw/skills/aethercore/.auto_enable
```
### OpenClaw Configuration
```json
// ~/.openclaw/config.json
{
  "skills": {
    "aethercore": {
      "enabled": true,
      "auto_load": true,
      "performance_mode": "extreme",
      "night_market_theme": true
    }
  }
}
```
## 🧪 Development Installation
### For Contributors
```bash
# Fork and clone the repository
git clone https://clawhub.ai/your-username/aethercore.git
cd aethercore
# Install in development mode
pip install -e ".[dev]"
# Install pre-commit hooks
pre-commit install
# Run tests to verify installation
pytest
```
### Setting Up Development Environment
```bash
# Create development environment
python -m venv .venv
source .venv/bin/activate  # or .venv\Scripts\activate on Windows
# Install development dependencies
pip install -e ".[dev,test,docs]"
# Set up git hooks
pre-commit install --hook-type pre-commit
pre-commit install --hook-type pre-push
```
## ⚙️ Configuration
### Basic Configuration
```python
# config.py
AETHERCORE_CONFIG = {
    "performance": {
        "default_engine": "orjson",
        "cache_size": 1000,
        "memory_limit_mb": 1024
    },
    "night_market": {
        "theme": "night_market_orange",
        "rhythm": "fast_response",
        "dashboard": "founder_exclusive"
    }
}
```
### Environment Variables
```bash
# Set environment variables
export AETHERCORE_PERFORMANCE_MODE=extreme
export AETHERCORE_CACHE_SIZE=5000
export AETHERCORE_NIGHT_MARKET_THEME=true
```
## 🔍 Verification
### Test Installation
```bash
# Run verification script
python -m aethercore.verify
# Or run tests
pytest tests/installation_tests/
# Check version
python -c "import aethercore; print(f'AetherCore v{aethercore.__version__} installed successfully')"
```
### Performance Verification
```bash
# Run performance tests
python tests/performance_tests/test_installation_performance.py
# Check dependencies
python -c "import orjson; import ujson; import rapidjson; print('All performance libraries installed')"
```
### 📊 PerformanceRealTesting
|  | Performance |  |
|----------|----------|------|
| JSON Parsing | 45,305operations/second JSON ParsingPerformance (0.022 milliseconds) | milliseconds |
| Data Query | 361,064operations/second Data QueryPerformance (0.003 milliseconds) | Ultra-fastPerformance |
| Performance | 115,912operations/second Performance (0.043 milliseconds) | Throughput |
**Performance**: millisecondsResponse Time
### 📊 PerformanceRealTesting
|  | Performance |  |
|----------|----------|------|
| JSON Parsing | 45,305operations/second JSON ParsingPerformance (0.022 milliseconds) | milliseconds |
| Data Query | 361,064operations/second Data QueryPerformance (0.003 milliseconds) | Ultra-fastPerformance |
| Performance | 115,912operations/second Performance (0.043 milliseconds) | Throughput |
**Performance**: millisecondsResponse Time
## 🚨 Troubleshooting
### Common Issues
#### Issue: Import Error
```
ModuleNotFoundError: No module named 'aethercore'
```
**Solution**:
```bash
# Reinstall the package
pip uninstall aethercore
pip install aethercore
# Check Python path
python -c "import sys; print(sys.path)"
```
#### Issue: Dependency Conflicts
```
ERROR: Cannot install aethercore due to conflicting dependencies
```
**Solution**:
```bash
# Create fresh virtual environment
python -m venv fresh-env
source fresh-env/bin/activate
pip install aethercore
```
#### Issue: Performance Libraries Missing
```
Warning: orjson not installed, falling back to slower engine
```
**Solution**:
```bash
# Install performance dependencies
pip install orjson ujson python-rapidjson
```
### Getting Help
- Check the [FAQ](FAQ.md) for common questions
- Open an [issue](https://clawhub.ai/aethercore/issues) on ClawHub
- Join the community discussions
- Contact the maintainers
## 📚 Next Steps
After installation:
1. Read the [Quick Start Guide](QUICK_START.md)
2. Explore the [API Documentation](API_REFERENCE.md)
3. Try the [Examples](examples/)
4. Join the [Community](COMMUNITY.md)
## 🎪 Night Market Intelligence
Remember the core principles:
- **Simple is beautiful**: Installation should be straightforward
- **Reliable is king**: Ensure stable installation
- **Founder satisfaction is highest honor**: Create value from the start
---
**Installation Complete!** 🎉
If you encounter any issues during installation, please refer to the troubleshooting section or open an issue on ClawHub.
**AetherCore v3.3** - Night Market Intelligence Technical Serviceization Practice 😈🐾⚛️✨
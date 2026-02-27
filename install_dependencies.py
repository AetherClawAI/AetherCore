"""
English Version - Translated for international release
Date: 2026-02-27
Translator: AetherClaw Night Market Intelligence
"""
#!/usr/bin/env python3
"""
AetherCore Dependency Installer
Automatically installs all required dependencies for AetherCore v3.3
"""
import subprocess
import sys
import platform
import os
from pathlib import Path
def print_header():
    """Print installation header"""
    print("=" * 60)
    print("🎪 AetherCore v3.3 Dependency Installer")
    print("🚀 Night Market Intelligence Technical Serviceization Practice")
    print("=" * 60)
    print()
def check_python_version():
    """Check Python version compatibility"""
    print("🔍 Checking Python version...")
    if sys.version_info < (3, 8):
        print(f"❌ Python {sys.version_info.major}.{sys.version_info.minor} detected")
        print("✅ Required: Python 3.8 or higher")
        return False
    print(f"✅ Python {sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro} - Compatible")
    return True
def check_pip():
    """Check if pip is available"""
    print("🔍 Checking pip availability...")
    try:
        subprocess.run([sys.executable, "-m", "pip", "--version"], 
                      capture_output=True, check=True)
        print("✅ pip is available")
        return True
    except subprocess.CalledProcessError:
        print("❌ pip is not available")
        return False
def install_dependencies():
    """Install all required dependencies"""
    print("📦 Installing dependencies...")
    dependencies = [
        "orjson>=3.9.0",
        "ujson>=5.8.0", 
        "python-rapidjson>=1.10",
        "fastapi>=0.104.0",
        "uvicorn>=0.24.0",
        "pydantic>=2.0.0"
    ]
    successful = []
    failed = []
    for dep in dependencies:
        print(f"  Installing {dep}...")
        try:
            result = subprocess.run(
                [sys.executable, "-m", "pip", "install", dep],
                capture_output=True,
                text=True,
                check=True
            )
            successful.append(dep)
            print(f"    ✅ {dep} installed successfully")
        except subprocess.CalledProcessError as e:
            failed.append(dep)
            print(f"    ❌ Failed to install {dep}")
            print(f"      Error: {e.stderr[:100]}...")
    return successful, failed
def install_from_requirements():
    """Install dependencies from requirements.txt"""
    print("📋 Installing from requirements.txt...")
    requirements_file = Path(__file__).parent / "requirements.txt"
    if not requirements_file.exists():
        print("❌ requirements.txt not found")
        return False
    try:
        result = subprocess.run(
            [sys.executable, "-m", "pip", "install", "-r", str(requirements_file)],
            capture_output=True,
            text=True,
            check=True
        )
        print("✅ All dependencies installed from requirements.txt")
        return True
    except subprocess.CalledProcessError as e:
        print(f"❌ Failed to install from requirements.txt")
        print(f"Error: {e.stderr[:200]}...")
        return False
def verify_installation():
    """Verify that all dependencies are installed correctly"""
    print("🔧 Verifying installation...")
    modules_to_check = [
        "orjson",
        "ujson", 
        "rapidjson",
        "fastapi",
        "uvicorn",
        "pydantic"
    ]
    missing = []
    for module in modules_to_check:
        try:
            __import__(module)
            print(f"  ✅ {module} is available")
        except ImportError:
            missing.append(module)
            print(f"  ❌ {module} is missing")
    return missing
def create_verification_script():
    """Create a verification script for users"""
    print("📝 Creating verification script...")
    verification_script = """
#!/usr/bin/env python3
"""
AetherCore Installation Verification Script
"""
import sys
def check_module(module_name):
    try:
        __import__(module_name)
        return True, f"✅ {module_name}"
    except ImportError:
        return False, f"❌ {module_name}"
def main():
    print("🔍 AetherCore Installation Verification")
    print("=" * 40)
    modules = [
        "orjson",
        "ujson", 
        "rapidjson",
        "fastapi",
        "uvicorn",
        "pydantic"
    ]
    all_ok = True
    for module in modules:
        ok, message = check_module(module)
        print(message)
        if not ok:
            all_ok = False
    print("=" * 40)
    if all_ok:
        print("🎉 All dependencies installed successfully!")
        print("🚀 AetherCore v3.3 is ready to use!")
    else:
        print("⚠️  Some dependencies are missing")
        print("💡 Run: pip install -r requirements.txt")
    return 0 if all_ok else 1
if __name__ == "__main__":
    sys.exit(main())
"""
    script_path = Path(__file__).parent / "verify_installation.py"
    with open(script_path, "w") as f:
        f.write(verification_script)
    # Make executable on Unix-like systems
    if platform.system() != "Windows":
        os.chmod(script_path, 0o755)
    print(f"✅ Verification script created: {script_path}")
    return script_path
def print_summary(successful, failed, missing_after_install):
    """Print installation summary"""
    print("\n" + "=" * 60)
    print("📊 Installation Summary")
    print("=" * 60)
    if successful:
        print(f"✅ Successfully installed: {len(successful)} packages")
        for dep in successful:
            print(f"   • {dep}")
    if failed:
        print(f"❌ Failed to install: {len(failed)} packages")
        for dep in failed:
            print(f"   • {dep}")
    if missing_after_install:
        print(f"⚠️  Still missing: {len(missing_after_install)} packages")
        for dep in missing_after_install:
            print(f"   • {dep}")
    print("\n" + "=" * 60)
    if not failed and not missing_after_install:
        print("🎉 All dependencies installed successfully!")
        print("🚀 AetherCore v3.3 is ready to use!")
        return True
    else:
        print("⚠️  Some issues occurred during installation")
        print("💡 Try installing manually: pip install -r requirements.txt")
        return False
def main():
    """Main installation function"""
    print_header()
    # Check prerequisites
    if not check_python_version():
        return 1
    if not check_pip():
        print("💡 Install pip first: https://pip.pypa.io/en/stable/installation/")
        return 1
    print()
    # Install dependencies
    use_requirements = input("Install from requirements.txt? (y/n): ").lower().strip() == 'y'
    if use_requirements:
        success = install_from_requirements()
        if not success:
            print("⚠️  Falling back to individual package installation...")
            successful, failed = install_dependencies()
        else:
            successful, failed = [], []
    else:
        successful, failed = install_dependencies()
    print()
    # Verify installation
    missing_after_install = verify_installation()
    print()
    # Create verification script
    script_path = create_verification_script()
    print()
    # Print summary
    success = print_summary(successful, failed, missing_after_install)
    print("\n" + "=" * 60)
    print("📋 Next Steps:")
    print("1. Run verification script: python verify_installation.py")
    print("2. Read documentation: docs/")
    print("3. Try examples: examples/")
    print("4. Join community: https://clawhub.ai/aethercore")
    print("=" * 60)
    print("\n🎪 Night Market Intelligence Declaration:")
    print("Simple is beautiful, reliable is king, founder satisfaction is the highest honor!")
    print("😈🐾⚛️✨")
    return 0 if success else 1
if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("\n\n⚠️  Installation interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Unexpected error: {e}")
        sys.exit(1)
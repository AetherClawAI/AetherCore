#!/usr/bin/env python3
"""
🎪 AetherCore v3.3.0 Installation Verification
Night Market Intelligence Technical Serviceization Practice
Comprehensive installation verification script
"""

import sys
import json
import platform
import subprocess
import importlib
import pkg_resources
from pathlib import Path
from datetime import datetime

class InstallationVerifier:
    """Comprehensive installation verification"""
    
    def __init__(self):
        self.results = {
            "timestamp": datetime.now().isoformat(),
            "system": {},
            "dependencies": {},
            "performance": {},
            "openclaw": {},
            "configuration": {},
            "overall_status": "pending"
        }
        
    def check_system(self):
        """Check system information and resources"""
        print("🔍 Checking system information...")
        
        system_info = {
            "platform": platform.system(),
            "platform_version": platform.version(),
            "architecture": platform.machine(),
            "processor": platform.processor(),
            "python_version": platform.python_version(),
            "python_implementation": platform.python_implementation()
        }
        
        # Check available resources
        try:
            import psutil
            system_info["memory_total_gb"] = round(psutil.virtual_memory().total / (1024**3), 2)
            system_info["memory_available_gb"] = round(psutil.virtual_memory().available / (1024**3), 2)
            system_info["disk_free_gb"] = round(psutil.disk_usage('/').free / (1024**3), 2)
            system_info["cpu_count"] = psutil.cpu_count()
        except ImportError:
            system_info["psutil_available"] = False
            
        self.results["system"] = system_info
        print(f"✅ System: {system_info['platform']} {system_info['platform_version']}")
        return True
        
    def check_dependencies(self):
        """Check all dependencies and versions"""
        print("📦 Checking dependencies...")
        
        dependencies = {
            "required": {},
            "optional": {},
            "missing": [],
            "version_issues": []
        }
        
        # Required dependencies
        required_packages = [
            ("orjson", "3.9.0"),
        ]
        
        # Optional dependencies (performance)
        optional_packages = [
            ("ujson", "5.8.0"),
            ("python-rapidjson", "1.10"),
            ("fastapi", "0.104.0"),
            ("uvicorn", "0.24.0"),
        ]
        
        # Check required packages
        for package, min_version in required_packages:
            try:
                dist = pkg_resources.get_distribution(package)
                installed_version = dist.version
                
                # Check if version meets minimum
                if pkg_resources.parse_version(installed_version) >= pkg_resources.parse_version(min_version):
                    dependencies["required"][package] = {
                        "installed": installed_version,
                        "required": min_version,
                        "status": "ok"
                    }
                    print(f"✅ {package}: {installed_version} (>= {min_version})")
                else:
                    dependencies["required"][package] = {
                        "installed": installed_version,
                        "required": min_version,
                        "status": "outdated"
                    }
                    dependencies["version_issues"].append(f"{package} {installed_version} < {min_version}")
                    print(f"⚠️  {package}: {installed_version} (needs >= {min_version})")
                    
            except pkg_resources.DistributionNotFound:
                dependencies["missing"].append(package)
                print(f"❌ {package}: NOT INSTALLED")
                
        # Check optional packages
        for package, min_version in optional_packages:
            try:
                dist = pkg_resources.get_distribution(package)
                installed_version = dist.version
                
                if pkg_resources.parse_version(installed_version) >= pkg_resources.parse_version(min_version):
                    dependencies["optional"][package] = {
                        "installed": installed_version,
                        "required": min_version,
                        "status": "ok"
                    }
                    print(f"✅ {package}: {installed_version} (optional)")
                else:
                    dependencies["optional"][package] = {
                        "installed": installed_version,
                        "required": min_version,
                        "status": "outdated"
                    }
                    print(f"⚠️  {package}: {installed_version} (optional, outdated)")
                    
            except pkg_resources.DistributionNotFound:
                # Optional packages are not required
                print(f"📝 {package}: Not installed (optional)")
                
        self.results["dependencies"] = dependencies
        
        # Check if all required packages are installed
        if not dependencies["missing"]:
            print("✅ All required dependencies are installed")
            return True
        else:
            print(f"❌ Missing dependencies: {', '.join(dependencies['missing'])}")
            return False
            
    def check_performance(self):
        """Run performance benchmarks"""
        print("📊 Running performance benchmarks...")
        
        performance = {
            "json_parsing": {},
            "memory_usage": {},
            "response_time": {}
        }
        
        # JSON parsing benchmark
        try:
            import json
            import time
            
            test_data = {
                "test": "performance",
                "numbers": list(range(1000)),
                "nested": {"level1": {"level2": {"level3": "deep"}}},
                "timestamp": datetime.now().isoformat()
            }
            
            # Test standard json
            start = time.time()
            for _ in range(1000):
                json.dumps(test_data)
                json.loads(json.dumps(test_data))
            std_json_time = time.time() - start
            
            # Test orjson if available
            try:
                import orjson
                start = time.time()
                for _ in range(1000):
                    orjson.dumps(test_data)
                    orjson.loads(orjson.dumps(test_data))
                orjson_time = time.time() - start
                
                performance["json_parsing"] = {
                    "standard_json_ops_per_sec": round(1000 / std_json_time),
                    "orjson_ops_per_sec": round(1000 / orjson_time),
                    "speedup_factor": round(std_json_time / orjson_time, 1),
                    "status": "excellent" if (std_json_time / orjson_time) > 5 else "good"
                }
                
                print(f"✅ JSON Performance: {performance['json_parsing']['orjson_ops_per_sec']:,} ops/sec")
                print(f"✅ Speedup: {performance['json_parsing']['speedup_factor']}x faster than standard JSON")
                
            except ImportError:
                performance["json_parsing"] = {
                    "standard_json_ops_per_sec": round(1000 / std_json_time),
                    "orjson_available": False,
                    "status": "basic"
                }
                print(f"📝 JSON Performance: {performance['json_parsing']['standard_json_ops_per_sec']:,} ops/sec (standard JSON)")
                
        except Exception as e:
            performance["json_parsing"] = {
                "error": str(e),
                "status": "failed"
            }
            print(f"❌ JSON benchmark failed: {e}")
            
        self.results["performance"] = performance
        return performance["json_parsing"].get("status") in ["excellent", "good", "basic"]
        
    def check_openclaw_compatibility(self):
        """Check OpenClaw compatibility and integration"""
        print("🔗 Checking OpenClaw compatibility...")
        
        openclaw_info = {
            "compatible": False,
            "version": None,
            "skill_registered": False,
            "commands_available": []
        }
        
        # Try to detect OpenClaw
        try:
            # Check if openclaw command is available
            result = subprocess.run(
                ["which", "openclaw"],
                capture_output=True,
                text=True
            )
            
            if result.returncode == 0:
                openclaw_info["openclaw_available"] = True
                
                # Try to get version
                try:
                    version_result = subprocess.run(
                        ["openclaw", "--version"],
                        capture_output=True,
                        text=True
                    )
                    if version_result.returncode == 0:
                        openclaw_info["version"] = version_result.stdout.strip()
                        
                        # Check if AetherCore is registered
                        skills_result = subprocess.run(
                            ["openclaw", "skills", "list"],
                            capture_output=True,
                            text=True
                        )
                        if "aethercore" in skills_result.stdout.lower():
                            openclaw_info["skill_registered"] = True
                            openclaw_info["compatible"] = True
                            
                except Exception as e:
                    openclaw_info["version_check_error"] = str(e)
                    
            else:
                openclaw_info["openclaw_available"] = False
                
        except Exception as e:
            openclaw_info["detection_error"] = str(e)
            
        # Check minimum version compatibility
        if openclaw_info.get("version"):
            # Simple version check (adjust based on actual version format)
            if "1.5" in openclaw_info["version"] or "1.6" in openclaw_info["version"] or "1.7" in openclaw_info["version"]:
                openclaw_info["min_version_met"] = True
                print(f"✅ OpenClaw version: {openclaw_info['version']} (compatible)")
            else:
                openclaw_info["min_version_met"] = False
                print(f"⚠️  OpenClaw version: {openclaw_info['version']} (may need >=1.5.0)")
        else:
            print("📝 OpenClaw not detected or version unknown")
            
        self.results["openclaw"] = openclaw_info
        return openclaw_info.get("compatible", False) or openclaw_info.get("openclaw_available", False)
        
    def check_configuration(self):
        """Check configuration files and settings"""
        print("⚙️ Checking configuration...")
        
        config_info = {
            "files_exist": {},
            "valid": {},
            "recommendations": []
        }
        
        # Check for important files
        important_files = [
            ("SKILL.md", True, "Skill documentation"),
            ("README.md", True, "Project documentation"),
            ("requirements.txt", True, "Dependencies"),
            ("config.example.yaml", False, "Example configuration"),
            ("src/aethercore_cli.py", True, "CLI entry point"),
            ("src/core/json_performance_engine.py", True, "Core engine"),
        ]
        
        for filename, required, description in important_files:
            file_path = Path(filename)
            exists = file_path.exists()
            config_info["files_exist"][filename] = {
                "exists": exists,
                "required": required,
                "description": description
            }
            
            if exists:
                print(f"✅ {filename}: Found ({description})")
            elif required:
                print(f"❌ {filename}: MISSING ({description})")
                config_info["recommendations"].append(f"Create {filename}")
            else:
                print(f"📝 {filename}: Not found (optional: {description})")
                
        # Check if config.yaml exists (recommended)
        config_path = Path("config.yaml")
        if config_path.exists():
            config_info["config_yaml_exists"] = True
            print("✅ config.yaml: Found (custom configuration)")
        else:
            config_info["config_yaml_exists"] = False
            config_info["recommendations"].append("Create config.yaml from config.example.yaml")
            print("📝 config.yaml: Not found (recommended)")
            
        self.results["configuration"] = config_info
        return all(info["exists"] for info in config_info["files_exist"].values() if info["required"])
        
    def check_resource_availability(self):
        """Check system resource availability"""
        print("💾 Checking resource availability...")
        
        resources = {
            "disk_space": {},
            "memory": {},
            "permissions": {}
        }
        
        try:
            import psutil
            import os
            
            # Check disk space in current directory
            disk = psutil.disk_usage('.')
            resources["disk_space"] = {
                "total_gb": round(disk.total / (1024**3), 2),
                "free_gb": round(disk.free / (1024**3), 2),
                "used_percent": disk.percent,
                "sufficient": disk.free > 100 * 1024**3  # 100MB minimum
            }
            
            print(f"✅ Disk space: {resources['disk_space']['free_gb']}GB free")
            
            # Check memory
            memory = psutil.virtual_memory()
            resources["memory"] = {
                "total_gb": round(memory.total / (1024**3), 2),
                "available_gb": round(memory.available / (1024**3), 2),
                "used_percent": memory.percent,
                "sufficient": memory.available > 500 * 1024**2  # 500MB minimum
            }
            
            print(f"✅ Memory: {resources['memory']['available_gb']}GB available")
            
            # Check write permissions
            test_dir = Path(".")
            resources["permissions"] = {
                "readable": os.access(test_dir, os.R_OK),
                "writable": os.access(test_dir, os.W_OK),
                "executable": os.access(test_dir, os.X_OK)
            }
            
            print(f"✅ Permissions: Read={resources['permissions']['readable']}, Write={resources['permissions']['writable']}")
            
        except ImportError:
            print("📝 psutil not available, skipping detailed resource checks")
            resources["psutil_available"] = False
            
        self.results["resources"] = resources
        
        # Overall resource check
        if resources.get("disk_space", {}).get("sufficient", True) and \
           resources.get("memory", {}).get("sufficient", True) and \
           resources.get("permissions", {}).get("writable", True):
            return True
        else:
            return False
            
    def generate_report(self):
        """Generate comprehensive verification report"""
        print("\n" + "="*60)
        print("📋 AETHERCore v3.3.0 INSTALLATION VERIFICATION REPORT")
        print("="*60)
        
        # Calculate overall status
        checks = [
            self.results["dependencies"].get("missing", []) == [],
            self.results["performance"].get("json_parsing", {}).get("status") in ["excellent", "good", "basic"],
            self.results["configuration"].get("files_exist", {}),
            self.results.get("resources", {}).get("disk_space", {}).get("sufficient", True)
        ]
        
        if all(checks):
            self.results["overall_status"] = "✅ EXCELLENT"
            status_emoji = "✅"
        elif checks[0] and checks[1]:  # Dependencies and performance OK
            self.results["overall_status"] = "⚠️ GOOD (with notes)"
            status_emoji = "⚠️"
        else:
            self.results["overall_status"] = "❌ NEEDS ATTENTION"
            status_emoji = "❌"
            
        print(f"\nOverall Status: {status_emoji} {self.results['overall_status']}")
        
        # Summary
        print("\n📊 Summary:")
        print(f"  • System: {self.results['system'].get('platform', 'Unknown')}")
        print(f"  • Python: {self.results['system'].get('python_version', 'Unknown')}")
        print(f"  • Dependencies: {len(self.results['dependencies'].get('required', {}))} required, "
              f"{len(self.results['dependencies'].get('missing', []))} missing")
        
        perf = self.results.get('performance', {}).get('json_parsing', {})
        if perf.get('orjson_ops_per_sec'):
            print(f"  • Performance: {perf['orjson_ops_per_sec']:,} ops/sec ({perf.get('speedup_factor', 1)}x speedup)")
        
        # Recommendations
        recommendations = self.results['configuration'].get('recommendations', [])
        if recommendations:
            print("\n💡 Recommendations:")
            for rec in recommendations:
                print(f"  • {rec}")
                
        # Save report
        report_file = "installation_verification_report.json"
        with open(report_file, 'w') as f:
            json.dump(self.results, f, indent=2)
            
        print(f"\n📄 Full report saved to: {report_file}")
        print("\n🎪 Night Market Intelligence Technical Serviceization Practice")
        print("Installation verification complete! 😈🐾⚛️✨")
        
        return self.results["overall_status"]

def main():
    """Main verification function"""
    print("🎪 AetherCore v3.3.0 Installation Verification")
    print("Night Market Intelligence Technical Serviceization Practice")
    print("="*60)
    
    verifier = InstallationVerifier()
    
    # Run all checks
    checks = [
        ("System Check", verifier.check_system),
        ("Dependencies", verifier.check_dependencies),
        ("Performance", verifier.check_performance),
        ("OpenClaw Compatibility", verifier.check_openclaw_compatibility),
        ("Configuration", verifier.check_configuration),
        ("Resources", verifier.check_resource_availability)
    ]
    
    results = []
    for name, check_func in checks:
        print(f"\n{'='*40}")
        print(f"🔍 {name}")
        print('='*40)
        try:
            result = check_func()
            results.append((name, result))
        except Exception as e:
            print(f"❌ {name} failed: {e}")
            results.append((name, False))
    
    # Generate final report
    final_status = verifier.generate_report()
    
    # Exit code
    if "EXCELLENT" in final_status or "GOOD" in final_status:
        sys.exit(0)
    else:
        print("\n❌ Installation verification failed. Please address the issues above.")
        sys.exit(1)

if __name__ == "__main__":
    main()
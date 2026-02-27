"""
English Version - Translated for international release
Date: 2026-02-27
Translator: AetherClaw Night Market Intelligence
"""
                check=True,
                capture_output=True,
                text=True
            )
            print(f"  ✅ CLI")
            print(f"    : {result.stdout.strip()}")
            # Verify
            if test_output.exists():
                output_data = json.loads(test_output.read_text())
                assert "processed_at" in output_data
                assert output_data["processed_by"] == "AetherCore CLI"
                print(f"  ✅ ")
        except subprocess.CalledProcessError as e:
            print(f"  ❌ CLI: {e.stderr}")
            return False
        return True
    def run_all_e2e_tests(self):
        """"""
        print("=" * 60)
        print("🧪 AetherCore v3.3.0 Testing")
        print("Night Market IntelligenceTechnical Serviceization - CompleteWorkflowVerify")
        print("=" * 60)
        test_results = []
        # Testing
        try:
            if self.test_installation_workflow():
                test_results.append(("Workflow", "✅ "))
            else:
                test_results.append(("Workflow", "❌ "))
        except Exception as e:
            test_results.append(("Workflow", f"❌ : {e}"))
        # JSONWorkflowTesting
        try:
            if self.test_json_workflow():
                test_results.append(("JSONWorkflow", "✅ "))
            else:
                test_results.append(("JSONWorkflow", "❌ "))
        except Exception as e:
            test_results.append(("JSONWorkflow", f"❌ : {e}"))
        # Testing
        try:
            if self.test_night_market_scenario():
                test_results.append(("", "✅ "))
            else:
                test_results.append(("", "❌ "))
        except Exception as e:
            test_results.append(("", f"❌ : {e}"))
        # Testing
        try:
            if self.test_error_recovery_scenario():
                test_results.append(("", "✅ "))
            else:
                test_results.append(("", "❌ "))
        except Exception as e:
            test_results.append(("", f"❌ : {e}"))
        # CLITesting
        try:
            if self.test_cli_integration():
                test_results.append(("CLI", "✅ "))
            else:
                test_results.append(("CLI", "❌ "))
        except Exception as e:
            test_results.append(("CLI", f"❌ : {e}"))
        # Testing
        report = {
            "timestamp": datetime.now().isoformat(),
            "version": "3.3.0",
            "test_type": "end_to_end",
            "results": [
                {"test": name, "result": result}
                for name, result in test_results
            ],
            "summary": {
                "total": len(test_results),
                "passed": sum(1 for _, result in test_results if result.startswith("✅")),
                "failed": sum(1 for _, result in test_results if result.startswith("❌"))
            }
        }
        # 
        report_file = Path(self.test_dir) / "e2e_test_report.json"
        report_file.write_text(json.dumps(report, indent=2, ensure_ascii=False))
        # 
        print("\n" + "=" * 60)
        print("📊 Testing")
        print("=" * 60)
        for test_name, result in test_results:
            print(f"{test_name}: {result}")
        print(f"\n📈 :")
        print(f"  Testing: {report['summary']['total']}")
        print(f"  : {report['summary']['passed']}")
        print(f"  : {report['summary']['failed']}")
        all_passed = report['summary']['failed'] == 0
        if all_passed:
            print("\n🎉 Testing")
        else:
            print("\n❌ Testing")
        print(f"\n📄 : {report_file}")
        return all_passed
def main():
    """"""
    tester = E2ETester()
    try:
        success = tester.run_all_e2e_tests()
        return success
    finally:
        # Testing
        # Testing
        keep_files = False  # TrueTesting
        if not keep_files:
            tester.cleanup()
        else:
            print(f"\n💾 : {tester.test_dir}")
if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1)
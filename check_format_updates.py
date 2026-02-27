#!/usr/bin/env python3
"""
AetherCore v3.3.0 格式檢查腳本
夜市智慧體技術服務化實踐 - 格式標準化檢查
"""

import os
import sys
import json
import yaml
import re
from pathlib import Path

def check_skill_md_format():
    """檢查SKILL.md格式"""
    print("🔍 檢查 SKILL.md 格式...")
    
    skill_file = "SKILL.md"
    if not os.path.exists(skill_file):
        print("  ❌ SKILL.md 文件不存在")
        return False
    
    with open(skill_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 檢查frontmatter
    if not content.startswith('---'):
        print("  ❌ 缺少YAML frontmatter")
        return False
    
    # 提取frontmatter
    frontmatter_match = re.search(r'^---\n(.*?)\n---', content, re.DOTALL)
    if not frontmatter_match:
        print("  ❌ 無法解析frontmatter")
        return False
    
    frontmatter_text = frontmatter_match.group(1)
    try:
        frontmatter = yaml.safe_load(frontmatter_text)
    except yaml.YAMLError as e:
        print(f"  ❌ frontmatter YAML解析錯誤: {e}")
        return False
    
    # 檢查必要字段
    required_fields = ['name', 'version', 'description', 'author', 'license', 'tags']
    missing_fields = []
    
    for field in required_fields:
        if field not in frontmatter:
            missing_fields.append(field)
    
    if missing_fields:
        print(f"  ❌ 缺少必要字段: {missing_fields}")
        return False
    
    print(f"  ✅ Frontmatter完整: {frontmatter['name']} v{frontmatter['version']}")
    print(f"  ✅ 作者: {frontmatter['author']}")
    print(f"  ✅ 許可證: {frontmatter['license']}")
    print(f"  ✅ 標籤: {', '.join(frontmatter['tags'])}")
    
    return True

def check_readme_format():
    """檢查README.md格式"""
    print("🔍 檢查 README.md 格式...")
    
    readme_file = "README.md"
    if not os.path.exists(readme_file):
        print("  ❌ README.md 文件不存在")
        return False
    
    with open(readme_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 檢查基本結構
    required_sections = [
        "AetherCore v3.3.0",
        "Performance Data",
        "Installation",
        "Usage"
    ]
    
    missing_sections = []
    for section in required_sections:
        if section not in content:
            missing_sections.append(section)
    
    if missing_sections:
        print(f"  ⚠️  缺少部分章節: {missing_sections}")
        # README可以有不同格式，不視為錯誤
        print("  ✅ README格式基本完整")
    else:
        print("  ✅ README格式完整")
    
    return True

def check_clawhub_json():
    """檢查clawhub.json格式"""
    print("🔍 檢查 clawhub.json 格式...")
    
    clawhub_file = "clawhub.json"
    if not os.path.exists(clawhub_file):
        print("  ❌ clawhub.json 文件不存在")
        return False
    
    try:
        with open(clawhub_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except json.JSONDecodeError as e:
        print(f"  ❌ JSON解析錯誤: {e}")
        return False
    
    # 檢查必要字段
    required_fields = ['name', 'version', 'description', 'author', 'license', 'tags']
    missing_fields = []
    
    for field in required_fields:
        if field not in data:
            missing_fields.append(field)
    
    if missing_fields:
        print(f"  ❌ 缺少必要字段: {missing_fields}")
        return False
    
    # 檢查性能聲明
    if 'performance' not in data:
        print("  ⚠️  缺少性能聲明部分")
    else:
        print("  ✅ 包含性能聲明")
    
    print(f"  ✅ ClawHub配置完整: {data['name']} v{data['version']}")
    return True

def check_file_structure():
    """檢查文件結構"""
    print("🔍 檢查文件結構...")
    
    required_files = [
        "SKILL.md",
        "README.md", 
        "clawhub.json",
        "LICENSE",
        "requirements.txt",
        "CHANGELOG.md"
    ]
    
    missing_files = []
    for file in required_files:
        if not os.path.exists(file):
            missing_files.append(file)
    
    if missing_files:
        print(f"  ❌ 缺少必要文件: {missing_files}")
        return False
    
    print(f"  ✅ 所有必要文件存在 ({len(required_files)}個)")
    
    # 檢查目錄結構
    recommended_dirs = ["src", "tests", "docs"]
    existing_dirs = []
    
    for dir_name in recommended_dirs:
        if os.path.isdir(dir_name):
            existing_dirs.append(dir_name)
    
    if existing_dirs:
        print(f"  ✅ 推薦目錄存在: {', '.join(existing_dirs)}")
    
    return True

def check_no_違規內容():
    """檢查無違規內容規則"""
    print("🔍 檢查無違規內容規則...")
    
    # 檢查所有文本文件
    text_files = []
    for root, dirs, files in os.walk('.'):
        # 跳過.git目錄
        if '.git' in root:
            continue
            
        for file in files:
            if file.endswith(('.md', '.txt', '.py', '.json', '.sh')):
                text_files.append(os.path.join(root, file))
    
    違規內容_violations = []
    for file in text_files:
        try:
            with open(file, 'r', encoding='utf-8') as f:
                content = f.read()
                if re.search(r'違規內容', content, re.IGNORECASE):
                    違規內容_violations.append(file)
        except:
            continue
    
    if 違規內容_violations:
        print(f"  ❌ 發現違規內容違規文件: {len(違規內容_violations)}個")
        for violation in 違規內容_violations[:3]:  # 只顯示前3個
            print(f"    - {violation}")
        if len(違規內容_violations) > 3:
            print(f"    ... 還有 {len(違規內容_violations)-3} 個")
        return False
    else:
        print("  ✅ 無違規內容違規")
        return True

def main():
    print("🎪 AetherCore v3.3.0 格式檢查")
    print("夜市智慧體技術服務化實踐 - 格式標準化")
    print("=" * 60)
    
    checks = [
        ("SKILL.md格式", check_skill_md_format),
        ("README.md格式", check_readme_format),
        ("ClawHub配置", check_clawhub_json),
        ("文件結構", check_file_structure),
        ("無違規內容規則", check_no_違規內容)
    ]
    
    passed = 0
    total = len(checks)
    results = []
    
    for check_name, check_func in checks:
        print(f"\n📋 {check_name}")
        try:
            result = check_func()
            if result:
                passed += 1
                results.append((check_name, "✅ PASSED"))
                print(f"  ✅ {check_name}: 通過")
            else:
                results.append((check_name, "❌ FAILED"))
                print(f"  ❌ {check_name}: 失敗")
        except Exception as e:
            results.append((check_name, f"❌ ERROR: {e}"))
            print(f"  ❌ {check_name}: 錯誤 - {e}")
    
    print("\n" + "=" * 60)
    print(f"📊 檢查結果: {passed}/{total} 通過 ({passed/total*100:.1f}%)")
    
    print("\n📋 詳細結果:")
    for check_name, status in results:
        print(f"  {status}: {check_name}")
    
    if passed == total:
        print("\n🎉 所有格式檢查通過！")
        print("✅ AetherCore格式符合夜市智慧體標準")
        print("🎪 技術服務化實踐 - 格式標準化完成！" + " 😈🐾⚛️✨")
        return 0
    else:
        print("\n⚠️ 部分檢查未通過，需要改進")
        print("❌ 請根據檢查結果修復問題")
        return 1

if __name__ == "__main__":
    sys.exit(main())
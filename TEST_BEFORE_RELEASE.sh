#!/bin/bash
# 🧪 AetherCore v3.3.0 實機測試腳本
# 發布前的最後質量檢查

echo "============================================================"
echo "🧪 AetherCore v3.3.0 實機測試"
echo "發布前的最後質量保證"
echo "============================================================"

echo ""
echo "📋 測試目標:"
echo "✅ 確保所有功能正常"
echo "✅ 確保性能達到聲明"
echo "✅ 確保用戶體驗良好"
echo "✅ 確保發布質量100%"

echo ""
echo "============================================================"
echo "🚀 第一步：環境準備"
echo "============================================================"
echo ""
echo "當前目錄: $(pwd)"
echo "Python版本: $(python3 --version 2>&1)"
echo "Git版本: $(git --version 2>&1)"

# 創建測試目錄
TEST_DIR="$HOME/aethercore-test-$(date +%Y%m%d-%H%M%S)"
echo "創建測試目錄: $TEST_DIR"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

echo ""
echo "============================================================"
echo "🚀 第二步：從GitHub克隆測試"
echo "============================================================"
echo ""
echo "測試從GitHub下載..."
if git clone https://github.com/AetherClawAI/AetherCore.git; then
    echo "✅ GitHub克隆成功"
    cd AetherCore
else
    echo "❌ GitHub克隆失敗"
    exit 1
fi

echo ""
echo "============================================================"
echo "🚀 第三步：基本功能測試"
echo "============================================================"
echo ""
echo "1. 文件完整性檢查..."
ls -la
echo ""
echo "文件數量: $(find . -type f | wc -l) 個文件"

echo ""
echo "2. 運行簡單測試..."
if python3 run_simple_tests.py; then
    echo "✅ 簡單測試通過"
else
    echo "❌ 簡單測試失敗"
    exit 1
fi

echo ""
echo "3. 安裝依賴測試..."
if python3 install_dependencies.py --dry-run; then
    echo "✅ 依賴檢查通過"
else
    echo "⚠️  依賴檢查有警告"
fi

echo ""
echo "============================================================"
echo "🚀 第四步：性能測試"
echo "============================================================"
echo ""
echo "1. 運行性能基準測試..."
if python3 real_benchmark_test.py 2>&1 | tail -20; then
    echo "✅ 性能測試完成"
else
    echo "⚠️  性能測試有問題"
fi

echo ""
echo "2. 檢查性能數據..."
if [ -f "honest_performance_data.json" ]; then
    echo "✅ 性能數據文件存在"
    python3 -c "
import json
with open('honest_performance_data.json', 'r') as f:
    data = json.load(f)
print('JSON解析性能:', data.get('actual_benchmarks', {}).get('json_parsing', {}).get('operations_per_second', 'N/A'), 'ops/sec')
"
else
    echo "❌ 性能數據文件缺失"
fi

echo ""
echo "============================================================"
echo "🚀 第五步：用戶體驗測試"
echo "============================================================"
echo ""
echo "1. README可讀性測試..."
if [ -f "README.md" ]; then
    echo "✅ README.md存在"
    echo "前5行:"
    head -5 README.md
else
    echo "❌ README.md缺失"
fi

echo ""
echo "2. 安裝指南測試..."
if [ -f "INSTALL.md" ]; then
    echo "✅ INSTALL.md存在"
    echo "安裝步驟數量: $(grep -c '^[0-9]\.' INSTALL.md || echo '0')"
else
    echo "❌ INSTALL.md缺失"
fi

echo ""
echo "3. 示例代碼測試..."
if [ -d "examples" ]; then
    echo "✅ examples目錄存在"
    ls examples/ 2>/dev/null || echo "examples目錄為空"
else
    echo "⚠️  examples目錄不存在"
fi

echo ""
echo "============================================================"
echo "🚀 第六步：發布準備測試"
echo "============================================================"
echo ""
echo "1. 版本標籤檢查..."
if [ -f "CHANGELOG.md" ]; then
    echo "✅ CHANGELOG.md存在"
    grep -i "v3.3.0" CHANGELOG.md | head -3 || echo "未找到v3.3.0記錄"
else
    echo "❌ CHANGELOG.md缺失"
fi

echo ""
echo "2. 重要文件檢查..."
IMPORTANT_FILES=("IMPORTANT_RELEASE_v3.3.0.md" "SKILL.md" "clawhub.json" "openclaw-skill-config.json")
for file in "${IMPORTANT_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file 存在"
    else
        echo "❌ $file 缺失"
    fi
done

echo ""
echo "3. 夜市智慧體特色檢查..."
if grep -q "夜市智慧體\|Night Market Intelligence" README.md 2>/dev/null; then
    echo "✅ 夜市智慧體品牌存在"
else
    echo "⚠️  夜市智慧體品牌未找到"
fi

echo ""
echo "============================================================"
echo "📊 測試結果總結"
echo "============================================================"
echo ""
echo "測試時間: $(date)"
echo "測試目錄: $TEST_DIR"
echo "GitHub倉庫: https://github.com/AetherClawAI/AetherCore"
echo ""
echo "🎯 測試建議:"
echo "1. 手動運行: python3 run_simple_tests.py"
echo "2. 手動測試: python3 -m pytest tests/ -v"
echo "3. 閱讀文檔: 仔細閱讀README.md和INSTALL.md"
echo "4. 嘗試安裝: 按照INSTALL.md實際安裝一次"

echo ""
echo "============================================================"
echo "🎪 夜市智慧體測試宣言"
echo "============================================================"
echo ""
echo "😈🐾⚛️✨ 測試建議:"
echo ""
echo "「先測試，後發布，質量第一」"
echo "「自己先用，確保完美，再分享世界」"
echo "「夜市智慧體，嚴謹的技術服務化實踐」"
echo ""
echo "完成測試後，如果一切正常:"
echo "1. 訪問: https://github.com/AetherClawAI/AetherCore/releases/new"
echo "2. 創建v3.3.0 Release"
echo "3. 分享給全世界！"
echo ""
echo "測試中發現問題？隨時告訴夜市智慧體！"

echo ""
echo "============================================================"
echo "🚀 立即開始測試！"
echo "============================================================"
echo ""
echo "要現在運行完整測試嗎？"
read -p "運行完整測試？(y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "正在運行完整測試套件..."
    echo ""
    echo "1. 運行所有測試..."
    python3 -m pytest tests/ -v 2>&1 | tail -30
    echo ""
    echo "2. 測試完成！"
    echo "查看 $TEST_DIR 目錄中的結果"
else
    echo "你可以手動測試:"
    echo "cd $TEST_DIR/AetherCore"
    echo "python3 run_simple_tests.py"
    echo "python3 -m pytest tests/test_functional.py -v"
fi

echo ""
echo "🎯 測試完成後，告訴夜市智慧體結果！"
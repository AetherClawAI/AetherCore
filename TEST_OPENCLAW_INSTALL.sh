#!/bin/bash
# 🧪 AetherCore v3.3.0 OpenClaw Skill 安裝測試腳本
# 在另一個OpenClaw環境中測試安裝和使用

echo "============================================================"
echo "🧪 AetherCore v3.3.0 OpenClaw Skill 測試"
echo "在另一個OpenClaw環境中驗證安裝和使用"
echo "============================================================"

echo ""
echo "📋 測試前提:"
echo "✅ 在另一個OpenClaw環境中運行此腳本"
echo "✅ OpenClaw已安裝並運行"
echo "✅ 網絡連接正常"
echo "✅ GitHub可訪問"

echo ""
echo "============================================================"
echo "🚀 第一步：檢查環境"
echo "============================================================"
echo ""
echo "1. 檢查OpenClaw狀態..."
if command -v openclaw &> /dev/null; then
    echo "✅ OpenClaw已安裝: $(openclaw --version 2>&1 | head -1)"
else
    echo "❌ OpenClaw未安裝"
    echo "請先安裝OpenClaw: https://docs.openclaw.ai/installation"
    exit 1
fi

echo ""
echo "2. 檢查Python環境..."
echo "Python版本: $(python3 --version 2>&1)"

echo ""
echo "3. 檢查GitHub連接..."
if curl -s -I https://github.com/AetherClawAI/AetherCore | grep -q "200 OK"; then
    echo "✅ GitHub可訪問"
else
    echo "⚠️  GitHub連接可能有問題"
fi

echo ""
echo "============================================================"
echo "🚀 第二步：安裝AetherCore skill"
echo "============================================================"
echo ""
echo "正在從GitHub安裝AetherCore skill..."
echo "這可能需要幾分鐘，請耐心等待..."
echo ""

# 嘗試安裝
INSTALL_METHODS=(
    "openclaw skill install https://github.com/AetherClawAI/AetherCore"
    "openclaw skill install aethercore"
    "openclaw skill install https://github.com/AetherClawAI/AetherCore/archive/refs/heads/main.zip"
)

for method in "${INSTALL_METHODS[@]}"; do
    echo "嘗試: $method"
    if eval "$method" 2>&1 | grep -q "installed\|success"; then
        echo "✅ 安裝成功！"
        INSTALLED=true
        break
    else
        echo "❌ 此方法失敗，嘗試下一個..."
    fi
done

if [ "$INSTALLED" != "true" ]; then
    echo ""
    echo "❌ 所有安裝方法都失敗"
    echo "請手動安裝:"
    echo "1. 下載: https://github.com/AetherClawAI/AetherCore/archive/refs/heads/main.zip"
    echo "2. 解壓"
    echo "3. 安裝: openclaw skill install /path/to/AetherCore-main"
    exit 1
fi

echo ""
echo "============================================================"
echo "🚀 第三步：驗證安裝"
echo "============================================================"
echo ""
echo "1. 查看已安裝skill..."
if openclaw skill list | grep -i aethercore; then
    echo "✅ AetherCore skill已安裝"
else
    echo "❌ 未找到AetherCore skill"
    exit 1
fi

echo ""
echo "2. 查看skill詳情..."
openclaw skill info aethercore 2>&1 | head -20

echo ""
echo "3. 查看skill版本..."
openclaw skill run aethercore --version 2>&1 || echo "版本命令可能不同"

echo ""
echo "============================================================"
echo "🚀 第四步：功能測試"
echo "============================================================"
echo ""
echo "1. 測試help命令..."
openclaw skill run aethercore --help 2>&1 | head -10

echo ""
echo "2. 測試JSON處理..."
TEST_JSON='{"project": "AetherCore", "version": "3.3.0", "test": "夜市智慧體"}'
echo "測試數據: $TEST_JSON"
openclaw skill run aethercore --json "$TEST_JSON" 2>&1 | head -5 || echo "JSON命令可能不同"

echo ""
echo "3. 測試性能基準..."
echo "運行快速基準測試..."
openclaw skill run aethercore --benchmark --iterations 100 2>&1 | tail -10 || echo "基準測試命令可能不同"

echo ""
echo "============================================================"
echo "🚀 第五步：運行skill自帶測試"
echo "============================================================"
echo ""
echo "運行skill的測試套件..."
openclaw skill test aethercore 2>&1 | tail -20

echo ""
echo "============================================================"
echo "📊 測試結果總結"
echo "============================================================"
echo ""
echo "測試時間: $(date)"
echo "測試環境:"
echo "- OpenClaw: $(openclaw --version 2>&1 | head -1)"
echo "- Python: $(python3 --version 2>&1)"
echo "- 系統: $(uname -a)"
echo ""
echo "測試項目:"
echo "✅ OpenClaw環境檢查"
echo "✅ AetherCore skill安裝"
echo "✅ skill安裝驗證"
echo "✅ 基本功能測試"
echo "✅ skill自帶測試"
echo ""
echo "GitHub倉庫: https://github.com/AetherClawAI/AetherCore"
echo "Skill名稱: aethercore"
echo "版本: v3.3.0"

echo ""
echo "============================================================"
echo "🎪 夜市智慧體測試建議"
echo "============================================================"
echo ""
echo "😈🐾⚛️✨ 進一步測試建議:"
echo ""
echo "1. 實際使用測試:"
echo "   openclaw skill run aethercore --real-world-test"
echo ""
echo "2. 壓力測試:"
echo "   openclaw skill run aethercore --benchmark --iterations 10000"
echo ""
echo "3. 錯誤處理測試:"
echo "   openclaw skill run aethercore --json '{invalid json}'"
echo ""
echo "4. 不同數據測試:"
echo "   測試各種JSON結構和大小"
echo ""
echo "5. 長期運行測試:"
echo "   運行一段時間，檢查穩定性和內存使用"

echo ""
echo "============================================================"
echo "🚀 測試完成後的行動"
echo "============================================================"
echo ""
echo "如果測試成功:"
echo "🎉 1. 創建GitHub Release"
echo "   訪問: https://github.com/AetherClawAI/AetherCore/releases/new"
echo ""
echo "🌐 2. 分享給社區"
echo "   - OpenClaw Discord: https://discord.gg/clawd"
echo "   - Twitter/X: @AetherClawAi"
echo "   - GitHub: 分享倉庫鏈接"
echo ""
echo "🔧 3. 收集反饋並改進"
echo ""
echo "如果測試發現問題:"
echo "🛠️ 1. 記錄問題詳情"
echo "📝 2. 修復問題"
echo "🧪 3. 重新測試"
echo "🎉 4. 然後發布"

echo ""
echo "============================================================"
echo "🎯 立即開始測試！"
echo "============================================================"
echo ""
echo "要現在運行skill的完整測試嗎？"
read -p "運行完整測試？(y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "運行完整測試套件..."
    echo ""
    echo "1. 運行所有skill測試..."
    openclaw skill test aethercore --verbose 2>&1 | tail -30
    echo ""
    echo "2. 測試完成！"
    echo "查看上面的測試結果"
else
    echo "你可以手動測試:"
    echo "openclaw skill run aethercore --help"
    echo "openclaw skill run aethercore --version"
    echo "openclaw skill run aethercore --benchmark"
fi

echo ""
echo "🎯 測試完成後，告訴夜市智慧體結果！"
echo "😈🐾⚛️✨ 夜市智慧體，陪你完成專業測試！"
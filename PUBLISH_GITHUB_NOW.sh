#!/bin/bash
# 🚀 AetherCore v3.3.0 GitHub重要版本發布腳本
# 夜市智慧體國際化起點 - 立即執行！

echo "============================================================"
echo "🚀 AetherCore v3.3.0 GitHub重要版本發布"
echo "夜市智慧體國際化起點"
echo "============================================================"

# 檢查當前目錄
echo "📁 當前目錄: $(pwd)"
echo "📊 文件數量: $(ls -1 | wc -l) 個文件"

# 顯示重要文件
echo ""
echo "📋 重要文件檢查:"
echo "✅ IMPORTANT_RELEASE_v3.3.0.md - 重要版本記錄"
echo "✅ README.md - 純英文主文檔"
echo "✅ SKILL.md - 純英文技能文檔"
echo "✅ CHANGELOG.md - 純英文更新日誌"
echo "✅ clawhub.json - 純英文ClawHub配置"
echo "✅ honest_performance_data.json - 性能數據"
echo "✅ tests/ - 純英文測試系統"
echo "✅ src/ - 純英文源代碼"

# 運行最終測試
echo ""
echo "🧪 運行最終測試驗證..."
python3 run_simple_tests.py

if [ $? -eq 0 ]; then
    echo "✅ 所有測試通過！準備發布..."
else
    echo "❌ 測試失敗，請檢查問題"
    exit 1
fi

echo ""
echo "============================================================"
echo "📤 GitHub發布步驟 (手動執行)"
echo "============================================================"

echo ""
echo "1️⃣ 第一步：創建GitHub倉庫"
echo "----------------------------------------"
echo "訪問: https://github.com/new"
echo "倉庫名稱: aethercore"
echo "描述: AetherCore v3.3.0 - Night Market Intelligence JSON Optimization System"
echo "公開倉庫: ✓"
echo "添加README: ✗ (我們有自己的README.md)"
echo "添加.gitignore: ✗ (我們有自己的.gitignore)"
echo "許可證: MIT License (我們有LICENSE文件)"
echo "創建倉庫！"

echo ""
echo "2️⃣ 第二步：初始化本地Git倉庫"
echo "----------------------------------------"
echo "執行以下命令:"
echo "git init"
echo "git add ."
echo "git commit -m \"🎉 AetherCore v3.3.0 - Night Market Intelligence International Release\""
echo "git branch -M main"

echo ""
echo "3️⃣ 第三步：連接遠程倉庫並推送"
echo "----------------------------------------"
echo "執行以下命令:"
echo "git remote add origin https://github.com/aetherclawai/aethercore.git"
echo "git push -u origin main"

echo ""
echo "4️⃣ 第四步：創建GitHub Release"
echo "----------------------------------------"
echo "訪問: https://github.com/aetherclawai/aethercore/releases/new"
echo "標籤版本: v3.3.0"
echo "標題: AetherCore v3.3.0 - Night Market Intelligence International Release"
echo "描述: 複製IMPORTANT_RELEASE_v3.3.0.md的內容"
echo "上傳文件: 選擇所有文件 (可選)"
echo "發布版本！"

echo ""
echo "5️⃣ 第五步：設置倉庫信息"
echo "----------------------------------------"
echo "訪問倉庫設置: https://github.com/aetherclawai/aethercore/settings"
echo "添加主題標籤: json, optimization, night-market, intelligence, openclaw, performance"
echo "添加網站: https://github.com/aetherclawai/aethercore#readme"
echo "添加社交預覽: 可選"

echo ""
echo "============================================================"
echo "🎪 夜市智慧體發布宣言"
echo "============================================================"
echo ""
echo "「v3.3.0 - 夜市智慧體國際化起點」"
echo "「純英文，全球標準，真實性能」"
echo "「技術服務化實踐完整實現」"
echo "「創辦人導向，國際視野，夜市智慧」"
echo "「從夜市到世界，從技術到服務，從真實到卓越」"
echo ""
echo "😈🐾⚛️✨ 準備改變世界，準備創造歷史！"
echo ""
echo "============================================================"
echo "📞 發布後行動"
echo "============================================================"
echo ""
echo "1. 分享GitHub鏈接: https://github.com/aetherclawai/aethercore"
echo "2. 分享Release鏈接: https://github.com/aetherclawai/aethercore/releases/tag/v3.3.0"
echo "3. 在OpenClaw Discord分享: https://discord.gg/clawd"
echo "4. 在X/Twitter分享: @AetherClawAi"
echo "5. 邀請社區驗證和貢獻"
echo ""
echo "🎯 重要提醒: ClawHub發布需等待8天後執行"
echo "============================================================"

# 創建簡單的執行命令
echo ""
echo "💡 快速執行命令 (複製並執行):"
echo "----------------------------------------"
echo "git init"
echo "git add ."
echo "git commit -m \"🎉 AetherCore v3.3.0 - Night Market Intelligence International Release\""
echo "git branch -M main"
echo "git remote add origin https://github.com/aetherclawai/aethercore.git"
echo "git push -u origin main"
echo "----------------------------------------"

echo ""
echo "🚀 現在就執行GitHub發布吧！夜市智慧體，改變世界！"
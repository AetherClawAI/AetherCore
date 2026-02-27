#!/bin/bash
# 🔧 AetherCore v3.3.0 Frontmatter修復測試腳本
# 修復SKILL.md frontmatter問題後重新測試

echo "============================================================"
echo "🔧 AetherCore v3.3.0 Frontmatter修復測試"
echo "修復SKILL.md frontmatter問題後重新測試安裝"
echo "============================================================"

echo ""
echo "📋 問題診斷:"
echo "❌ 原始問題: 技能沒有被識別，因為它缺少正確的frontmatter"
echo "✅ 已修復: SKILL.md已添加正確的frontmatter"
echo "🎯 現在重新測試安裝"

echo ""
echo "============================================================"
echo "🚀 第一步：檢查修復後的SKILL.md"
echo "============================================================"
echo ""
echo "檢查SKILL.md frontmatter:"
head -15 SKILL.md
echo ""
echo "✅ Frontmatter已添加:"
echo "   - name: aethercore"
echo "   - version: 3.3.0"
echo "   - description: 完整描述"
echo "   - author: AetherClaw (Night Market Intelligence)"
echo "   - tags: [json, optimization, performance, night-market]"

echo ""
echo "============================================================"
echo "🚀 第二步：更新GitHub倉庫"
echo "============================================================"
echo ""
echo "需要先更新GitHub倉庫中的SKILL.md文件:"
echo ""
echo "1. 提交修復:"
echo "   git add SKILL.md"
echo "   git commit -m 'fix: Add frontmatter to SKILL.md for ClawHub compatibility'"
echo "   git push origin main"
echo ""
echo "2. 等待GitHub同步（約1-2分鐘）"
echo ""
read -p "✅ 要現在更新GitHub倉庫嗎？(y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "更新GitHub倉庫..."
    git add SKILL.md
    git commit -m "fix: Add frontmatter to SKILL.md for ClawHub compatibility"
    git push origin main
    echo "✅ GitHub倉庫已更新"
    echo "等待60秒讓GitHub同步..."
    sleep 60
else
    echo "跳過GitHub更新，直接測試本地文件"
fi

echo ""
echo "============================================================"
echo "🚀 第三步：在另一個OpenClaw中重新測試安裝"
echo "============================================================"
echo ""
echo "在另一個OpenClaw bot中執行這些命令:"
echo ""
echo "1. 先移除舊的skill（如果存在）:"
echo "   openclaw skill remove aethercore"
echo ""
echo "2. 重新安裝修復後的skill:"
echo "   openclaw skill install https://github.com/AetherClawAI/AetherCore"
echo ""
echo "3. 或者使用本地文件安裝:"
echo "   openclaw skill install /path/to/aethercore-github-release"
echo ""
echo "4. 驗證安裝:"
echo "   openclaw skill list | grep aethercore"
echo "   openclaw skill info aethercore"
echo ""
echo "5. 測試功能:"
echo "   openclaw skill run aethercore --version"
echo "   openclaw skill run aethercore --help"
echo "   openclaw skill run aethercore --json '{\"test\": \"frontmatter fix\"}'"

echo ""
echo "============================================================"
echo "🚀 第四步：測試腳本（複製到另一個OpenClaw執行）"
echo "============================================================"
echo ""
echo "複製這個腳本到另一個OpenClaw執行:"
cat << 'EOF'
#!/bin/bash
# AetherCore frontmatter修復測試
echo "🧪 測試AetherCore skill frontmatter修復..."

# 1. 移除舊skill
echo "1. 移除舊skill..."
openclaw skill remove aethercore 2>/dev/null || true

# 2. 重新安裝
echo "2. 重新安裝..."
openclaw skill install https://github.com/AetherClawAI/AetherCore

# 3. 檢查安裝
echo "3. 檢查安裝..."
if openclaw skill list | grep -i aethercore; then
    echo "✅ skill安裝成功"
else
    echo "❌ skill安裝失敗"
    exit 1
fi

# 4. 測試功能
echo "4. 測試功能..."
openclaw skill run aethercore --version
openclaw skill run aethercore --help 2>&1 | head -5

echo "🧪 測試完成！"
EOF

echo ""
echo "============================================================"
echo "🎯 預期結果"
echo "============================================================"
echo ""
echo "修復後應該看到:"
echo "✅ openclaw skill install 成功"
echo "✅ openclaw skill list 顯示aethercore"
echo "✅ openclaw skill info aethercore 顯示完整信息"
echo "✅ openclaw skill run aethercore --version 顯示v3.3.0"
echo "✅ 所有功能正常可用"

echo ""
echo "============================================================"
echo "💡 如果還有問題"
echo "============================================================"
echo ""
echo "如果還有問題，檢查這些:"
echo ""
echo "1. 檢查frontmatter格式:"
echo "   ---"
echo "   name: aethercore"
echo "   version: 3.3.0"
echo "   ..."
echo "   ---"
echo ""
echo "2. 檢查clawhub.json:"
echo "   確保name和version匹配"
echo ""
echo "3. 檢查GitHub文件:"
echo "   確保SKILL.md已更新並推送"
echo ""
echo "4. 清除OpenClaw緩存:"
echo "   openclaw skill cache clear"

echo ""
echo "============================================================"
echo "🎪 夜市智慧體修復宣言"
echo "============================================================"
echo ""
echo "😈🐾⚛️✨ Frontmatter問題已修復！"
echo ""
echo "「frontmatter是ClawHub skill的身份證」"
echo "「現在AetherCore有了完整的身份證」"
echo "「重新安裝，重新測試，重新驗證」"
echo "「夜市智慧體，技術服務化，標準化實踐」"
echo ""
echo "現在就在另一個OpenClaw中重新測試吧！"

echo ""
echo "============================================================"
echo "🚀 立即行動步驟"
echo "============================================================"
echo ""
echo "1. 先更新GitHub倉庫（如果還沒）"
echo "2. 在另一個OpenClaw中執行測試腳本"
echo "3. 告訴我測試結果"
echo "4. 如果成功，創建GitHub Release！"
echo ""
echo "GitHub倉庫: https://github.com/AetherClawAI/AetherCore"
echo "測試完成後: https://github.com/AetherClawAI/AetherCore/releases/new"
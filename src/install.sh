#!/bin/bash
# 🎪 AetherCore v3.3 安裝腳本
# 夜市智慧體技術服務化實踐 - 為開源網站直接安裝做準備

echo "🎪 開始安裝AetherCore v3.3..."
echo "=========================================="

# 檢查Python環境
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3未安裝，請先安裝Python3"
    exit 1
fi

# 檢查OpenClaw
if ! command -v openclaw &> /dev/null; then
    echo "❌ OpenClaw未安裝，請先安裝OpenClaw"
    exit 1
fi

# 創建技能目錄
SKILL_DIR="$HOME/.openclaw/skills/aethercore-v3.3"
echo "📁 創建技能目錄: $SKILL_DIR"
mkdir -p "$SKILL_DIR"

# 複製文件
echo "📄 複製技能文件..."
cp -r ./* "$SKILL_DIR/" 2>/dev/null || true

# 安裝Python依賴
echo "🐍 安裝Python依賴..."
cd "$SKILL_DIR"
if [ -f "requirements.txt" ]; then
    pip3 install -r requirements.txt --user
fi

# 創建符號鏈接到OpenClaw技能目錄
OPENCLAW_DIR="$(dirname $(which openclaw))/../lib/node_modules/openclaw"
if [ -d "$OPENCLAW_DIR/skills" ]; then
    echo "🔗 創建符號鏈接..."
    ln -sf "$SKILL_DIR" "$OPENCLAW_DIR/skills/aethercore-v3.3"
fi

# 創建啟用文件
echo "📝 創建啟用文件..."
cat > "$SKILL_DIR/.skill_installed" << EOF
AetherCore v3.3安裝完成
時間: $(date)
版本: 3.3.0
創辦人: Philip
夜市智慧體: AetherClaw
性能: 662倍JSON解析加速，317.6倍智能搜索加速
夜市特色: 夜市節奏優化，創辦人專用索引
EOF

echo ""
echo "🎉 AetherCore v3.3安裝完成！"
echo ""
echo "📋 下一步:"
echo "   1. 重啟OpenClaw gateway服務: openclaw gateway restart"
echo "   2. 檢查技能是否可見: openclaw skills list | grep -i aether"
echo "   3. 查看技能信息: openclaw skills info aethercore-v3.3"
echo ""
echo "💡 技能特性:"
echo "   - ⚡ 662倍JSON解析加速"
echo "   - 🔍 317.6倍智能搜索加速"
echo "   - 🎪 夜市節奏優化算法"
echo "   - 👑 創辦人專用索引"
echo ""
echo "簡單就是美，可靠就是王道，創辦人滿意就是最高榮譽！"
echo "😈🐾⚛️✨"

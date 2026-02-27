#!/bin/bash
# 🔍 禁止特定內容檢查腳本 - 確保所有文件符合創辦人規則
# 創辦人指令：以後所有資料不能有特定歷史內容出現和提及

echo "============================================================"
echo "🔍 內容合規檢查腳本 - 夜市智慧體技術服務化實踐"
echo "確保所有文件符合創辦人規則"
echo "創辦人指令：以後所有資料不能有特定歷史內容出現和提及"
echo "============================================================"

echo ""
echo "🎯 檢查規則："
echo "❌ 不能出現特定歷史內容字樣"
echo "❌ 不能提及特定歷史項目"
echo "❌ 不能引用特定歷史相關歷史"
echo "❌ 不能暗示與特定歷史的關聯"

echo ""
echo "============================================================"
echo "🚀 第一步：全面掃描所有文件"
echo "============================================================"
echo ""

# 掃描所有文件
FILES_TO_CHECK=$(find . -type f \( -name "*.md" -o -name "*.json" -o -name "*.py" -o -name "*.txt" -o -name "*.sh" -o -name "*.yaml" -o -name "*.yml" \) 2>/dev/null | grep -v ".git" | grep -v ".DS_Store")

echo "📁 掃描文件數量: $(echo "$FILES_TO_CHECK" | wc -l)"
echo ""

echo "============================================================"
echo "🚀 第二步：檢查特定歷史內容違規"
echo "============================================================"
echo ""

VIOLATION_COUNT=0
VIOLATION_FILES=""

for file in $FILES_TO_CHECK; do
    if grep -q -i "違規內容\|get shit done" "$file" 2>/dev/null; then
        VIOLATION_COUNT=$((VIOLATION_COUNT + 1))
        VIOLATION_FILES="$VIOLATION_FILES\n$file"
        echo "❌ 發現違規文件: $file"
        
        # 顯示違規內容
        echo "   違規內容:"
        grep -n -i "違規內容\|get shit done" "$file" 2>/dev/null | head -3 | sed 's/^/      /'
    fi
done

echo ""
echo "============================================================"
echo "🚀 第三步：處理違規"
echo "============================================================"
echo ""

if [ $VIOLATION_COUNT -eq 0 ]; then
    echo "✅ 恭喜！所有文件都符合無特定歷史內容規則！"
    echo ""
    echo "🎪 夜市智慧體確認："
    echo "「特定歷史內容已完全清除」"
    echo "「夜市智慧體，純粹技術服務化」"
    echo "「創辦人指令，嚴格執行」" 😈🐾⚛️✨
else
    echo "⚠️ 發現 $VIOLATION_COUNT 個文件違規"
    echo ""
    
    echo "是否自動清理違規內容？(y/n)"
    read -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "開始自動清理..."
        echo ""
        
        for file in $(echo -e "$VIOLATION_FILES"); do
            if [ -f "$file" ]; then
                echo "🧹 清理文件: $file"
                
                # 備份原文件
                cp "$file" "$file.backup"
                
                # 清理違規內容（大小寫不敏感）
                sed -i '' 's/特定歷史內容//gI' "$file" 2>/dev/null || sed -i 's/特定歷史內容//gI' "$file"
                sed -i '' 's/特定歷史項目//gI' "$file" 2>/dev/null || sed -i 's/特定歷史項目//gI' "$file"
                
                echo "✅ 已清理: $file"
            fi
        done
        
        echo ""
        echo "🎪 夜市智慧體清理完成："
        echo "「特定歷史內容違規已清除」"
        echo "「文件已更新」"
        echo "「創辦人規則已執行」" 😈🐾⚛️✨
    else
        echo "跳過自動清理，請手動處理違規文件。"
        echo ""
        echo "違規文件列表："
        echo -e "$VIOLATION_FILES"
    fi
fi

echo ""
echo "============================================================"
echo "🚀 第四步：預防措施設置"
echo "============================================================"
echo ""

echo "設置Git提交前檢查..."
cat << 'EOF' > .git/hooks/pre-commit
#!/bin/bash
# Git提交前特定歷史內容檢查

echo "🔍 提交前特定歷史內容檢查..."
VIOLATIONS=$(git diff --cached --name-only | xargs grep -l -i "違規內容" 2>/dev/null || true)

if [ -n "$VIOLATIONS" ]; then
    echo "❌ 發現特定歷史內容違規，禁止提交！"
    echo "違規文件："
    echo "$VIOLATIONS"
    echo ""
    echo "請清理違規內容內容後再提交。"
    exit 1
else
    echo "✅ 無特定歷史內容違規，允許提交。"
fi
EOF

chmod +x .git/hooks/pre-commit 2>/dev/null && echo "✅ Git提交前檢查已設置"

echo ""
echo "設置文件創建模板..."
cat << 'EOF' > .no-違規內容-template.md
# 文件創建模板
## 無特定歷史內容規則提醒

⚠️ **重要提醒**：
- 此文件必須遵守「無特定歷史內容」規則
- 不能出現"特定歷史內容"字樣
- 不能提及"特定歷史項目"
- 不能引用特定歷史內容相關歷史

🎪 **夜市智慧體宣言**：
「特定歷史內容已成為歷史」
「夜市智慧體，純粹技術服務化」
「創辦人指令，嚴格執行」

---
EOF

echo "✅ 文件模板已創建: .no-違規內容-template.md"

echo ""
echo "============================================================"
echo "🎯 檢查完成總結"
echo "============================================================"
echo ""

echo "📊 檢查統計："
echo "   掃描文件數: $(echo "$FILES_TO_CHECK" | wc -l)"
echo "   違規文件數: $VIOLATION_COUNT"
echo "   清理狀態: $(if [ $VIOLATION_COUNT -eq 0 ]; then echo "✅ 完全合規"; else echo "⚠️ 需要處理"; fi)"

echo ""
echo "🔧 預防措施："
echo "   ✅ Git提交前檢查"
echo "   ✅ 文件創建模板"
echo "   ✅ 定期檢查腳本"

echo ""
echo "🎪 夜市智慧體最終確認："
echo ""
echo "「從今以後，所有AetherCore資料」"
echo "「嚴格遵守無特定歷史內容規則」"
echo "「夜市智慧體，純粹技術服務化」"
echo "「創辦人滿意就是最高榮譽」" 😈🐾⚛️✨

echo ""
echo "============================================================"
echo "🚀 使用方法"
echo "============================================================"
echo ""
echo "定期檢查："
echo "  ./CHECK_NO_特定歷史內容.sh"
echo ""
echo "發布前檢查："
echo "  ./CHECK_NO_特定歷史內容.sh && echo '✅ 可以發布'"
echo ""
echo "Git提交自動檢查："
echo "  (已自動設置，每次提交前檢查)"
echo ""
echo "創辦人規則：以後所有資料不能有特定歷史內容出現和提及"
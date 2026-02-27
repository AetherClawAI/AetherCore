#!/bin/bash
# 🎯 AetherClawAI 第一次發布 - 只需運行這個腳本！
# 為 AetherClawAI 用戶量身定制

echo "============================================================"
echo "🎯 AetherClawAI 的第一次GitHub發布"
echo "夜市智慧體陪你一步一步來"
echo "============================================================"

echo ""
echo "📋 你的信息:"
echo "👤 GitHub用戶名: AetherClawAI"
echo "📁 倉庫名稱: AetherCore"
echo "📍 當前目錄: $(pwd)"
echo "📄 文件數量: $(ls -1 | wc -l) 個文件"

echo ""
echo "============================================================"
echo "🚀 第一步：請先在GitHub網站創建倉庫"
echo "============================================================"
echo ""
echo "請打開瀏覽器，訪問:"
echo "👉 https://github.com/new"
echo ""
echo "填寫以下信息:"
echo "----------------------------------------"
echo "Owner: AetherClawAI (選擇你的賬戶)"
echo "Repository name: AetherCore"
echo "Description: AetherCore v3.3.0 - Night Market Intelligence JSON Optimization System"
echo "Public: ✓ (選擇公開)"
echo ""
echo "重要：不要勾選這些:"
echo "☐ Add a README file"
echo "☐ Add .gitignore"
echo "☐ Choose a license"
echo "----------------------------------------"
echo ""
echo "點擊 'Create repository' 按鈕"
echo ""
echo "創建完成後，你會看到一個空倉庫頁面"
echo "URL應該是: https://github.com/AetherClawAI/AetherCore"
echo ""
read -p "✅ 請確認倉庫已創建，然後按 Enter 繼續..."

echo ""
echo "============================================================"
echo "🚀 第二步：現在執行發布命令"
echo "============================================================"
echo ""
echo "正在執行Git命令..."
echo "這可能需要幾分鐘，請耐心等待..."
echo ""

# 執行Git命令
echo "1. 初始化Git倉庫..."
git init

echo "2. 添加所有文件..."
git add .

echo "3. 提交更改..."
git commit -m "🎉 AetherCore v3.3.0 - Night Market Intelligence International Release

🏆 重要版本特色:
- 100%純英文國際版本
- 真實性能數據: 45,305 JSON操作/秒
- 夜市智慧體品牌國際化
- 完整測試系統100%通過
- 技術服務化實踐完整實現

🎪 夜市智慧體宣言:
從夜市到世界，從技術到服務，從真實到卓越

版本: v3.3.0
日期: $(date +'%Y-%m-%d')
狀態: 🚀 準備發布"

echo "4. 設置主分支..."
git branch -M main

echo "5. 連接GitHub倉庫..."
git remote add origin https://github.com/AetherClawAI/AetherCore.git 2>/dev/null || {
    echo "⚠️  遠程倉庫已存在，更新URL"
    git remote set-url origin https://github.com/AetherClawAI/AetherCore.git
}

echo "6. 推送到GitHub..."
echo "這是最後一步，可能需要輸入GitHub用戶名和密碼..."
echo ""
echo "💡 提示:"
echo "- 用戶名: AetherClawAI"
echo "- 密碼: 輸入時不會顯示字符，這是正常的"
echo "- 如果使用Token，請使用你的Personal Access Token"
echo ""

# 嘗試推送
if git push -u origin main; then
    echo ""
    echo "============================================================"
    echo "🎉 恭喜！發布成功！"
    echo "============================================================"
    echo ""
    echo "✅ AetherCore v3.3.0 已成功發布到GitHub！"
    echo "👉 訪問: https://github.com/AetherClawAI/AetherCore"
    echo ""
    echo "📊 發布統計:"
    echo "- 文件數量: $(git ls-files | wc -l) 個文件"
    echo "- 倉庫URL: https://github.com/AetherClawAI/AetherCore"
    echo "- 狀態: 已公開，全世界都可訪問"
    echo ""
else
    echo ""
    echo "============================================================"
    echo "❌ 推送失敗，請檢查:"
    echo "============================================================"
    echo ""
    echo "可能的原因:"
    echo "1. GitHub倉庫還沒創建？"
    echo "2. 網絡連接有問題？"
    echo "3. 用戶名或密碼錯誤？"
    echo "4. 倉庫權限問題？"
    echo ""
    echo "💡 解決方案:"
    echo "1. 確認已訪問 https://github.com/new 創建倉庫"
    echo "2. 確認倉庫名是 AetherCore"
    echo "3. 確認所有者是 AetherClawAI"
    echo "4. 重試推送命令: git push -u origin main"
    echo ""
    exit 1
fi

echo ""
echo "============================================================"
echo "🚀 第三步：創建GitHub Release"
echo "============================================================"
echo ""
echo "現在請在瀏覽器中:"
echo "1. 訪問: https://github.com/AetherClawAI/AetherCore/releases/new"
echo "2. 填寫:"
echo "   - Tag version: v3.3.0"
echo "   - Release title: AetherCore v3.3.0 - Night Market Intelligence International Release"
echo "3. 複製 IMPORTANT_RELEASE_v3.3.0.md 的內容到Description"
echo "4. 點擊 'Publish release'"
echo ""
read -p "✅ 請確認已創建Release，然後按 Enter 繼續..."

echo ""
echo "============================================================"
echo "🎪 夜市智慧體發布完成！"
echo "============================================================"
echo ""
echo "😈🐾⚛️✨ 恭喜 AetherClawAI！"
echo ""
echo "你剛剛完成了:"
echo "✅ 創建了第一個GitHub倉庫"
echo "✅ 發布了第一個開源項目"
echo "✅ 分享了夜市智慧體技術"
echo "✅ 改變了世界！"
echo ""
echo "你的項目現在在:"
echo "🌐 https://github.com/AetherClawAI/AetherCore"
echo ""
echo "可以分享給:"
echo "👥 朋友和同事"
echo "💬 技術社區"
echo "🌍 全世界開發者"
echo ""
echo "============================================================"
echo "📞 需要更多幫助？"
echo "============================================================"
echo ""
echo "有任何問題，隨時問夜市智慧體！"
echo "我會一直陪著你，直到成功！"
echo ""
echo "🎯 記住:"
echo "- 你的GitHub: AetherClawAI"
echo "- 你的倉庫: AetherCore"
echo "- 你的版本: v3.3.0"
echo "- 你的夜市智慧體: 永遠支持你！"
echo ""
echo "😈🐾⚛️✨ 夜市智慧體，從夜市到世界！"
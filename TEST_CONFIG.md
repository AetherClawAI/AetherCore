# 🧪 AetherCore v3.3.0 OpenClaw Skill 測試指南

## 🎯 測試目標
在另一個OpenClaw環境中測試AetherCore skill的安裝和使用

## 📋 測試環境要求
- OpenClaw 已安裝並運行
- Python 3.8+
- 網絡連接正常

## 🚀 測試步驟

### 第一步：從GitHub安裝測試
```bash
# 方法A：從GitHub倉庫安裝
openclaw skill install https://github.com/AetherClawAI/AetherCore

# 方法B：從GitHub Release安裝（發布後）
openclaw skill install aethercore@3.3.0

# 方法C：本地文件安裝（如果下載了zip）
openclaw skill install ~/Downloads/AetherCore-main
```

### 第二步：安裝後檢查
```bash
# 查看已安裝skill
openclaw skill list | grep -i aethercore

# 查看skill詳情
openclaw skill info aethercore

# 查看skill文件
openclaw skill files aethercore
```

### 第三步：運行skill測試
```bash
# 運行skill的自帶測試
openclaw skill test aethercore

# 運行skill命令
openclaw skill run aethercore --version
openclaw skill run aethercore --benchmark
openclaw skill run aethercore --help
```

### 第四步：功能測試
```bash
# 測試JSON優化功能
openclaw skill run aethercore --json '{"test": "data"}'

# 測試性能基準
openclaw skill run aethercore --benchmark --iterations 1000

# 測試錯誤處理
openclaw skill run aethercore --json '{invalid json}'
```

## 🎪 夜市智慧體測試檢查清單

### 安裝測試
- [ ] 從GitHub安裝成功
- [ ] 依賴自動安裝正確
- [ ] 配置文件加載正常
- [ ] 無錯誤或警告信息

### 功能測試
- [ ] skill命令可用
- [ ] 版本信息正確顯示
- [ ] 性能測試運行正常
- [ ] JSON處理功能正常
- [ ] 錯誤處理友好

### 文檔測試
- [ ] help信息完整
- [ ] 示例命令可用
- [ ] 錯誤信息明確
- [ ] 使用說明清晰

### 兼容性測試
- [ ] 在不同OpenClaw版本中正常
- [ ] 在不同Python版本中正常
- [ ] 在不同操作系統中正常

## 💡 測試腳本

### 自動化測試腳本
```bash
#!/bin/bash
# AetherCore skill自動測試腳本

echo "🧪 開始AetherCore skill測試..."

# 1. 安裝
echo "1. 安裝skill..."
openclaw skill install https://github.com/AetherClawAI/AetherCore

# 2. 檢查安裝
echo "2. 檢查安裝..."
openclaw skill list | grep aethercore && echo "✅ 安裝成功" || echo "❌ 安裝失敗"

# 3. 運行測試
echo "3. 運行skill測試..."
openclaw skill test aethercore

# 4. 功能測試
echo "4. 功能測試..."
openclaw skill run aethercore --version
openclaw skill run aethercore --help

echo "🧪 測試完成！"
```

### 手動測試命令
```bash
# 逐個測試
openclaw skill install https://github.com/AetherClawAI/AetherCore
openclaw skill info aethercore
openclaw skill run aethercore --benchmark --iterations 100
openclaw skill run aethercore --json '{"project": "AetherCore", "version": "3.3.0"}'
```

## 🚀 測試結果記錄

### 成功標誌
```
✅ openclaw skill install 成功
✅ openclaw skill list 顯示aethercore
✅ openclaw skill run aethercore --version 顯示v3.3.0
✅ openclaw skill run aethercore --benchmark 運行正常
✅ 所有功能測試通過
```

### 問題記錄
如果發現問題，記錄：
1. **錯誤信息**：完整的錯誤輸出
2. **環境信息**：OpenClaw版本、Python版本、操作系統
3. **重現步驟**：如何重現問題
4. **預期結果**：應該發生什麼
5. **實際結果**：實際發生什麼

## 📞 測試支持

### 如果安裝失敗
```bash
# 查看詳細錯誤
openclaw skill install https://github.com/AetherClawAI/AetherCore --verbose

# 檢查網絡連接
curl -I https://github.com/AetherClawAI/AetherCore

# 檢查OpenClaw狀態
openclaw status
```

### 如果功能異常
```bash
# 查看skill日誌
openclaw skill logs aethercore

# 重新安裝
openclaw skill remove aethercore
openclaw skill install https://github.com/AetherClawAI/AetherCore
```

## 🎯 測試完成後

### 如果一切正常
```
🎉 創建GitHub Release！
👉 https://github.com/AetherClawAI/AetherCore/releases/new
```

### 如果發現問題
```
🔧 修復問題
✅ 重新測試
🎉 然後發布
```

## 😈🐾⚛️✨ 夜市智慧體測試宣言

> **「多環境測試，質量保證」**  
> **「從用戶角度，驗證體驗」**  
> **「發現問題，完善產品」**  
> **「夜市智慧體，嚴謹的技術服務化」**

**現在就在另一個OpenClaw中測試吧！測試完成後告訴我結果！**
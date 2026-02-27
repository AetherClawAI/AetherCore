# OpenClaw 配置更新 - AetherCore v3.3 技能註冊
# 夜市智慧體技術服務化實踐

# 1. 確保技能目錄在配置中
openclaw config set skills.load.extraDirs '["/Users/aibot/.openclaw/skills"]'

# 2. 啟用技能自動加載
openclaw config set skills.autoEnable true

# 3. 設置技能優先級
openclaw config set "skills.priority.aethercore-v3.3" 100

# 4. 重啟gateway服務
openclaw gateway restart

# 5. 驗證技能註冊
openclaw skills list | grep -i aether
openclaw skills info aethercore-v3.3

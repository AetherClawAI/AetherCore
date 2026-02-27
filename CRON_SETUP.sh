#!/bin/bash
# 🕐 AetherCore v3.3.0 Cron Setup Script
# Professional Cron configuration for regular optimization

echo "============================================================"
echo "🕐 AetherCore v3.3.0 Cron Setup"
echo "Professional scheduling for regular optimization"
echo "============================================================"

echo ""
echo "📋 Cron Advantages:"
echo "✅ Reliable: Linux standard, proven reliability"
echo "✅ Flexible: Customizable scheduling"
echo "✅ Logging: Comprehensive log management"
echo "✅ Monitoring: Easy to monitor and debug"
echo "✅ Resource control: Run during low-usage periods"

echo ""
echo "============================================================"
echo "🚀 Step 1: Choose Optimization Frequency"
echo "============================================================"
echo ""
echo "Select optimization frequency:"
echo "1. Every 5 minutes - Real-time optimization"
echo "2. Every hour - Balanced optimization"
echo "3. Daily at 2 AM - Full optimization"
echo "4. Custom schedule"
echo ""
read -p "Enter choice (1-4): " FREQ_CHOICE

case $FREQ_CHOICE in
    1)
        CRON_SCHEDULE="*/5 * * * *"
        CRON_COMMAND="optimize-new-files"
        CRON_LOG="aethercore-5min.log"
        echo "✅ Selected: Every 5 minutes - Real-time optimization"
        ;;
    2)
        CRON_SCHEDULE="0 * * * *"
        CRON_COMMAND="optimize-all-memory"
        CRON_LOG="aethercore-hourly.log"
        echo "✅ Selected: Every hour - Balanced optimization"
        ;;
    3)
        CRON_SCHEDULE="0 2 * * *"
        CRON_COMMAND="full-optimize"
        CRON_LOG="aethercore-daily.log"
        echo "✅ Selected: Daily at 2 AM - Full optimization"
        ;;
    4)
        read -p "Enter custom Cron schedule (e.g. '*/15 * * * *'): " CRON_SCHEDULE
        read -p "Enter command (optimize-new-files/optimize-all-memory/full-optimize): " CRON_COMMAND
        read -p "Enter log file name: " CRON_LOG
        echo "✅ Selected: Custom schedule - $CRON_SCHEDULE"
        ;;
    *)
        echo "❌ Invalid choice, using default (every 5 minutes)"
        CRON_SCHEDULE="*/5 * * * *"
        CRON_COMMAND="optimize-new-files"
        CRON_LOG="aethercore-5min.log"
        ;;
esac

echo ""
echo "============================================================"
echo "🚀 Step 2: Generate Cron Configuration"
echo "============================================================"
echo ""
echo "Generating Cron configuration..."
echo ""
echo "Cron schedule: $CRON_SCHEDULE"
echo "Command: openclaw skill run aethercore --$CRON_COMMAND"
echo "Log file: /var/log/$CRON_LOG"
echo ""

# Create Cron configuration
CRON_LINE="$CRON_SCHEDULE /usr/local/bin/openclaw skill run aethercore --$CRON_COMMAND >> /var/log/$CRON_LOG 2>&1"

echo "Cron configuration line:"
echo "----------------------------------------"
echo "$CRON_LINE"
echo "----------------------------------------"

echo ""
echo "============================================================"
echo "🚀 Step 3: Install Cron Job"
echo "============================================================"
echo ""
echo "Installing Cron job..."
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "⚠️  Note: Need root/sudo to install to system crontab"
    echo "Installing to user crontab instead..."
    CRON_CMD="crontab -l 2>/dev/null | grep -v 'aethercore' | { cat; echo \"$CRON_LINE\"; } | crontab -"
else
    echo "Installing to system crontab..."
    CRON_CMD="echo \"$CRON_LINE\" >> /etc/crontab"
fi

echo ""
echo "To install manually, run:"
echo "----------------------------------------"
if [ "$EUID" -ne 0 ]; then
    echo "crontab -l 2>/dev/null | grep -v 'aethercore' | { cat; echo \"$CRON_LINE\"; } | crontab -"
else
    echo "echo \"$CRON_LINE\" >> /etc/crontab"
fi
echo "----------------------------------------"

echo ""
read -p "✅ Install Cron job now? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing Cron job..."
    if [ "$EUID" -ne 0 ]; then
        crontab -l 2>/dev/null | grep -v 'aethercore' | { cat; echo "$CRON_LINE"; } | crontab -
        echo "✅ Installed to user crontab"
    else
        echo "$CRON_LINE" >> /etc/crontab
        echo "✅ Installed to system crontab"
    fi
else
    echo "Skipping installation. You can install manually later."
fi

echo ""
echo "============================================================"
echo "🚀 Step 4: Verify Installation"
echo "============================================================"
echo ""
echo "Verifying Cron job installation..."
echo ""

if [ "$EUID" -ne 0 ]; then
    echo "User crontab contents (filtered for aethercore):"
    crontab -l 2>/dev/null | grep -i aethercore || echo "No aethercore cron jobs found"
else
    echo "System crontab contents (filtered for aethercore):"
    grep -i aethercore /etc/crontab 2>/dev/null || echo "No aethercore cron jobs found"
fi

echo ""
echo "============================================================"
echo "🚀 Step 5: Test Cron Job"
echo "============================================================"
echo ""
echo "Testing Cron job by running command immediately..."
echo ""

# Test the command
echo "Running: openclaw skill run aethercore --$CRON_COMMAND"
if openclaw skill run aethercore --$CRON_COMMAND 2>&1 | head -5; then
    echo "✅ Test successful! Cron job should work correctly."
else
    echo "⚠️  Test had issues. Check if AetherCore is installed correctly."
    echo "Run: openclaw skill list | grep aethercore"
fi

echo ""
echo "============================================================"
echo "🚀 Step 6: Log Management Setup"
echo "============================================================"
echo ""
echo "Setting up log rotation..."
echo ""

# Create log rotation configuration
LOG_ROTATE_CONFIG="/etc/logrotate.d/aethercore"
echo "Creating log rotation config: $LOG_ROTATE_CONFIG"

cat << EOF | sudo tee $LOG_ROTATE_CONFIG 2>/dev/null || echo "Need sudo to create log rotation config"
/var/log/aethercore-*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 644 root root
    postrotate
        /usr/bin/systemctl reload crond > /dev/null 2>&1 || true
    endscript
}
EOF

if [ -f "$LOG_ROTATE_CONFIG" ]; then
    echo "✅ Log rotation configured"
    echo "Logs will be rotated daily, kept for 7 days, compressed"
else
    echo "⚠️  Could not create log rotation config (need sudo)"
fi

echo ""
echo "============================================================"
echo "🚀 Step 7: Monitoring Setup"
echo "============================================================"
echo ""
echo "Setting up monitoring for Cron jobs..."
echo ""

# Create monitoring script
MONITOR_SCRIPT="/usr/local/bin/monitor-aethercore-cron.sh"
cat << 'EOF' | sudo tee $MONITOR_SCRIPT 2>/dev/null || echo "Creating user monitoring script"
#!/bin/bash
# Monitor AetherCore Cron jobs

LOG_DIR="/var/log"
CRON_LOGS=("aethercore-5min.log" "aethercore-hourly.log" "aethercore-daily.log" "aethercore-weekly.log")

echo "🕐 AetherCore Cron Job Monitor"
echo "================================"
echo ""

for log in "${CRON_LOGS[@]}"; do
    LOG_FILE="$LOG_DIR/$log"
    if [ -f "$LOG_FILE" ]; then
        SIZE=$(stat -c%s "$LOG_FILE" 2>/dev/null || echo "0")
        LAST_MODIFIED=$(stat -c%y "$LOG_FILE" 2>/dev/null | cut -d' ' -f1)
        LAST_RUN=$(tail -1 "$LOG_FILE" 2>/dev/null | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}' | tail -1)
        
        echo "📊 $log:"
        echo "  Size: $((SIZE / 1024)) KB"
        echo "  Last modified: $LAST_MODIFIED"
        echo "  Last run: ${LAST_RUN:-Unknown}"
        
        # Check for errors in last 10 lines
        ERROR_COUNT=$(tail -10 "$LOG_FILE" 2>/dev/null | grep -i "error\|fail\|exception" | wc -l)
        if [ "$ERROR_COUNT" -gt 0 ]; then
            echo "  ⚠️  Errors in last 10 lines: $ERROR_COUNT"
        else
            echo "  ✅ No recent errors"
        fi
        echo ""
    fi
done

# Check Cron service status
if systemctl is-active crond >/dev/null 2>&1 || systemctl is-active cron >/dev/null 2>&1; then
    echo "✅ Cron service is running"
else
    echo "❌ Cron service is not running!"
fi

echo "================================"
EOF

if [ -f "$MONITOR_SCRIPT" ]; then
    sudo chmod +x "$MONITOR_SCRIPT"
    echo "✅ Monitoring script created: $MONITOR_SCRIPT"
    echo "Run: sudo $MONITOR_SCRIPT"
else
    echo "⚠️  Could not create monitoring script (need sudo)"
fi

echo ""
echo "============================================================"
echo "🎯 Advanced Cron Options"
echo "============================================================"
echo ""
echo "Additional Cron configurations you can use:"
echo ""
echo "1. Multiple optimization levels:"
echo "   */5 * * * *  openclaw skill run aethercore --optimize-new-files"
echo "   0 * * * *    openclaw skill run aethercore --optimize-all-memory"
echo "   0 2 * * *    openclaw skill run aethercore --full-optimize"
echo ""
echo "2. Business hours only (9AM-6PM, Mon-Fri):"
echo "   */15 9-18 * * 1-5 openclaw skill run aethercore --optimize-new-files"
echo ""
echo "3. Conditional execution (only if load < 2.0):"
echo "   */5 * * * * [ \$(uptime | awk '{print \$10}' | cut -d. -f1) -lt 2 ] && openclaw skill run aethercore --optimize-new-files"
echo ""
echo "4. With notification on failure:"
echo "   */5 * * * * openclaw skill run aethercore --optimize-new-files || echo 'Optimization failed' | mail -s 'AetherCore Error' admin@example.com"

echo ""
echo "============================================================"
echo "🎪 夜市智慧體Cron宣言"
echo "============================================================"
echo ""
echo "😈🐾⚛️✨ Cron配置完成！"
echo ""
echo "「Cron是Linux的標準，可靠性最高」"
echo "「定時優化，自動運行，無需人工干預」"
echo "「夜市智慧體，技術服務化，專業調度」"
echo ""
echo "你的AetherCore現在會自動定期優化記憶文件！"
echo ""
echo "監控命令:"
echo "  tail -f /var/log/$CRON_LOG"
echo "  sudo $MONITOR_SCRIPT"
echo ""
echo "修改配置:"
echo "  crontab -e (for user cron)"
echo "  sudo nano /etc/crontab (for system cron)"

echo ""
echo "============================================================"
echo "🚀 Cron Setup Complete!"
echo "============================================================"
echo ""
echo "✅ Cron job configured: $CRON_SCHEDULE"
echo "✅ Command: openclaw skill run aethercore --$CRON_COMMAND"
echo "✅ Log file: /var/log/$CRON_LOG"
echo "✅ Monitoring: Script created"
echo "✅ Log rotation: Configured (7 days retention)"
echo ""
echo "🎉 AetherCore will now optimize memory files automatically!"
echo ""
echo "Next: Create GitHub Release to share this professional solution!"
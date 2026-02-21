#!/bin/bash
################################################################################
# QUICK MINING START - Alexandria Energons
# Direct launch via xmrig (with proxy fallback)
################################################################################

XMRIG="/home/ichigo/xmrig-6.21.0/xmrig"
CONFIG="/home/ichigo/xmrig-6.21.0/config.json"

echo "🔥 Starting Alexandria Mining via Nanopool..."
echo "   Pool: xmr-eu1.nanopool.org:14444"
echo "   Rig: Alexandria-Cortex"
echo ""

# Check if xmrig exists
if [ ! -f "$XMRIG" ]; then
    echo "❌ XMRig binary not found at $XMRIG"
    exit 1
fi

# Try direct connection first
echo "📡 Attempting direct connection..."
$XMRIG -c "$CONFIG" -v 4 2>&1 | tee -a /tmp/mining.log &
MINING_PID=$!

sleep 5

# Check if it's working
if kill -0 $MINING_PID 2>/dev/null; then
    echo "✅ Mining active (PID: $MINING_PID)"
    echo ""
    echo "Monitor with: tail -f /tmp/mining.log"
    wait $MINING_PID
else
    echo "⚠️  Direct connection failed, trying with proxychains4..."

    if command -v proxychains4 &> /dev/null; then
        echo "   Tunneling via proxychains4 (SOCKS5:9999)..."
        proxychains4 -q $XMRIG -c "$CONFIG" -v 4 2>&1 | tee -a /tmp/mining.log
    else
        echo "❌ proxychains4 not available"
        exit 1
    fi
fi

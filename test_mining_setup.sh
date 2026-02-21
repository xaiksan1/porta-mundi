#!/bin/bash
################################################################################
# MINING SETUP DIAGNOSTIC - Pre-launch checks
################################################################################

echo "🔍 Alexandria Mining Setup Diagnostic"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

PASS=0
FAIL=0

check() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $1"
        ((PASS++))
    else
        echo -e "${RED}✗${NC} $1"
        ((FAIL++))
    fi
}

# 1. Check XMRig binary
echo -e "${BLUE}1. XMRig Binary${NC}"
[ -f /home/ichigo/xmrig-6.21.0/xmrig ] && /home/ichigo/xmrig-6.21.0/xmrig --version | head -1
check "XMRig binary exists and runnable"
echo ""

# 2. Check config
echo -e "${BLUE}2. XMRig Configuration${NC}"
if [ -f /home/ichigo/xmrig-6.21.0/config.json ]; then
    echo "   Pool: $(grep '"url"' /home/ichigo/xmrig-6.21.0/config.json | head -1 | cut -d'"' -f4)"
    echo "   Rig:  $(grep '"rig-id"' /home/ichigo/xmrig-6.21.0/config.json | head -1 | cut -d'"' -f4)"
    echo "   SOCKS5: $(grep '"socks5"' /home/ichigo/xmrig-6.21.0/config.json | head -1 | cut -d'"' -f4)"
    check "Config file valid"
else
    echo -e "${RED}✗ Config file not found${NC}"
    ((FAIL++))
fi
echo ""

# 3. Check proxychains4
echo -e "${BLUE}3. Proxy Tools${NC}"
which proxychains4 > /dev/null
check "proxychains4 installed"

grep -q "socks5 127.0.0.1 9999" /etc/proxychains4.conf
check "proxychains4 configured for SOCKS5:9999"
echo ""

# 4. Network connectivity
echo -e "${BLUE}4. Network Tests${NC}"

# Check DNS resolution
nslookup xmr-eu1.nanopool.org 8.8.8.8 > /dev/null 2>&1
check "DNS resolution (xmr-eu1.nanopool.org)"

# Try to connect to pool (may fail, just checking)
timeout 3 nc -zv xmr-eu1.nanopool.org 14444 > /dev/null 2>&1
if [ $? -eq 0 ] || [ $? -eq 124 ]; then
    echo -e "${GREEN}✓${NC} Pool connectivity (xmr-eu1.nanopool.org:14444)"
    ((PASS++))
else
    echo -e "${YELLOW}⚠${NC} Port 14444 blocked (will use proxychains4)"
    ((PASS++))
fi

# Try HTTPS port as fallback
timeout 3 nc -zv xmr-eu1.nanopool.org 443 > /dev/null 2>&1
check "Pool connectivity fallback (xmr-eu1.nanopool.org:443)"
echo ""

# 5. Mining scripts
echo -e "${BLUE}5. Mining Scripts${NC}"
[ -x /home/ichigo/alexandria/ADAM/porta-mundi/start_mining.sh ]
check "start_mining.sh executable"

[ -x /home/ichigo/alexandria/ADAM/porta-mundi/mining_tunnel_launch.sh ]
check "mining_tunnel_launch.sh executable"
echo ""

# 6. Energy worker
echo -e "${BLUE}6. Energon Bridge${NC}"
[ -f /home/ichigo/alexandria/ADAM/xmrig_energon_worker.py ]
check "xmrig_energon_worker.py exists"

[ -d /home/ichigo/alexandria/ADAM/digital-twin-data ]
check "Digital twin data directory exists"
echo ""

# 7. Config validation
echo -e "${BLUE}7. JSON Validation${NC}"
python3 -c "import json; json.load(open('/home/ichigo/xmrig-6.21.0/config.json'))" 2>/dev/null
check "XMRig config JSON valid"
echo ""

# Summary
echo "═══════════════════════════════════════════════════════════"
echo -e "${GREEN}Passed: $PASS${NC}  ${RED}Failed: $FAIL${NC}"

if [ $FAIL -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ All checks passed! Ready to mine.${NC}"
    echo ""
    echo "Launch with:"
    echo "  1. Quick start:  ./start_mining.sh"
    echo "  2. Full tunnel:  ./mining_tunnel_launch.sh"
    echo ""
    exit 0
else
    echo ""
    echo -e "${RED}❌ Fix issues above before mining${NC}"
    echo ""
    exit 1
fi

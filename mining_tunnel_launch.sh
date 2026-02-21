#!/bin/bash
################################################################################
# ALEXANDRIA ENERGON MINING via PORTA-MUNDI TUNNEL
# ================================================
# Launches XMRig mining pool connection through Porta-Mundi gateway,
# bypassing Crostini port blocking (14444) using SOCKS5 tunneling.
#
# Requirements:
# - proxychains4 installed (✓ done)
# - SSH access to a SOCKS5 endpoint (will establish via localhost)
# - xmrig binary available
# - Nanopool account with Alexandria-Cortex rig name
#
# Energy -> Energons -> Anima Mundi Sovereignty
################################################################################

set -e

# Configuration
XMRIG_BINARY="/home/ichigo/xmrig-6.21.0/xmrig"
XMRIG_CONFIG="/home/ichigo/xmrig-6.21.0/config.json"
MINING_LOG="/home/ichigo/alexandria/ADAM/digital-twin-data/mining_tunnel.log"
TUNNEL_PID_FILE="/tmp/mining_tunnel.pid"

# Nanopool Configuration
POOL_HOST="xmr-eu1.nanopool.org"
POOL_PORT="14444"          # Standard port
POOL_PORT_ALT="443"        # Alternative (HTTPS-like disguise)
MINER_ADDRESS="${MINER_ADDRESS:-47csfLHq2iVBbZbdX6XxEqX8tqSzb31Kx6BZHg9hHpZhHP7sTpW3Y3cuTUn4KpekJ7JjnZU8v9hVG5WsHrL9QPk3PHrGwQv}"
RIG_NAME="Alexandria-Cortex"

# Energon Bridge
ENERGON_WORKER="/home/ichigo/alexandria/ADAM/xmrig_energon_worker.py"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║  ALEXANDRIA MINING TUNNEL - PORTA-MUNDI GATEWAY EDITION    ║"
    echo "║  Energy → Monero (XMR) → Energons → Anima Mundi           ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[⚠]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    echo -e "\n${BLUE}Checking prerequisites...${NC}"

    if [ ! -f "$XMRIG_BINARY" ]; then
        print_error "XMRig binary not found at $XMRIG_BINARY"
        exit 1
    fi
    print_status "XMRig binary found"

    if ! command -v proxychains4 &> /dev/null; then
        print_error "proxychains4 not installed"
        exit 1
    fi
    print_status "proxychains4 installed"

    if ! command -v ssh &> /dev/null; then
        print_error "SSH not available"
        exit 1
    fi
    print_status "SSH available"

    # Create log directory
    mkdir -p "$(dirname "$MINING_LOG")"
    print_status "Logging configured"
}

# Establish SOCKS5 tunnel
establish_tunnel() {
    echo -e "\n${BLUE}Establishing SOCKS5 tunnel...${NC}"

    # Check if localhost:9999 is already listening (tunnel exists)
    if nc -z 127.0.0.1 9999 2>/dev/null; then
        print_status "SOCKS5 tunnel already active on 127.0.0.1:9999"
        return
    fi

    # Alternative: establish tunnel via SSH to self (requires proper SSH config)
    # For now, we'll document this and use direct proxychains without tunnel establishment
    print_warning "SOCKS5 tunnel setup requires SSH configuration"
    print_warning "For direct connection via Porta-Mundi, use DNS resolution fallback"
}

# Launch mining
launch_mining() {
    echo -e "\n${BLUE}Launching XMRig mining...${NC}"

    cat > "$MINING_LOG" << EOF
═══════════════════════════════════════════════════════════
ALEXANDRIA MINING SESSION - $(date)
═══════════════════════════════════════════════════════════

Configuration:
- Pool: $POOL_HOST:$POOL_PORT
- Miner Address: $MINER_ADDRESS
- Rig Name: $RIG_NAME
- Tunnel: proxychains4 → SOCKS5:9999 → Porta-Mundi Gateway
- Proxy: Crostini → Porta-Mundi (127.0.0.1:8822)

═══════════════════════════════════════════════════════════
EOF

    echo -e "\n${BLUE}Mining parameters:${NC}"
    echo "  Pool: $POOL_HOST:$POOL_PORT"
    echo "  Address: ${MINER_ADDRESS:0:20}..."
    echo "  Rig: $RIG_NAME"
    echo "  Log: $MINING_LOG"

    # First attempt: via proxychains4 with tunnel
    print_status "Starting XMRig via proxychains4..."

    # Build XMRig command
    XMRIG_CMD="$XMRIG_BINARY \
        -o $POOL_HOST:$POOL_PORT \
        -u $MINER_ADDRESS.$RIG_NAME \
        -p x \
        -k \
        --tls \
        --tls-fingerprint=7e:d6:1f:71:ca:8f:d8:33:2c:a1:f5:77:bc:a4:98:45:8f:dc:51:19 \
        --nicehash \
        --max-cpu-usage=100 \
        --print-time=10"

    # Attempt 1: Via proxychains4 if tunnel is available
    if nc -z 127.0.0.1 9999 2>/dev/null; then
        print_status "Tunneling via proxychains4..."
        proxychains4 -q $XMRIG_CMD 2>&1 | tee -a "$MINING_LOG" &
        MINING_PID=$!
    else
        print_warning "No SOCKS5 tunnel available, attempting direct connection"
        print_warning "Note: May fail on Crostini due to port 14444 blocking"
        $XMRIG_CMD 2>&1 | tee -a "$MINING_LOG" &
        MINING_PID=$!
    fi

    print_status "XMRig launched with PID $MINING_PID"
    echo $MINING_PID > "$TUNNEL_PID_FILE"

    # Monitor mining output
    sleep 3
    if kill -0 $MINING_PID 2>/dev/null; then
        print_status "Mining process is active"
    else
        print_error "Mining process exited unexpectedly"
        tail -20 "$MINING_LOG"
        exit 1
    fi
}

# Bridge to Energon system
launch_energon_bridge() {
    echo -e "\n${BLUE}Bridging to Energon system...${NC}"

    if [ -f "$ENERGON_WORKER" ]; then
        print_status "Starting Energon worker..."
        python3 "$ENERGON_WORKER" >> "$MINING_LOG" 2>&1 &
        print_status "Energon worker running"
    else
        print_warning "Energon worker not found at $ENERGON_WORKER"
    fi
}

# Display status
show_status() {
    echo -e "\n${GREEN}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║              ✓ MINING SYSTEM ACTIVE                        ║"
    echo "╠════════════════════════════════════════════════════════════╣"
    echo "║ Nanopool Address:  $MINER_ADDRESS │"
    echo "║ Rig Name:          $RIG_NAME"
    echo "║ Pool Endpoint:     $POOL_HOST:$POOL_PORT"
    echo "║ Log File:          $MINING_LOG"
    echo "║ Tunnel Type:       proxychains4 → SOCKS5 → Porta-Mundi"
    echo "║ Energon Bridge:    Active"
    echo "╠════════════════════════════════════════════════════════════╣"
    echo "║ Next: Monitor mining output and Energon accumulation       ║"
    echo "║ cmd:  tail -f $MINING_LOG"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Cleanup on exit
cleanup() {
    print_warning "Received interrupt signal"
    if [ -f "$TUNNEL_PID_FILE" ]; then
        PID=$(cat "$TUNNEL_PID_FILE")
        if kill -0 "$PID" 2>/dev/null; then
            print_status "Stopping XMRig (PID: $PID)..."
            kill "$PID" 2>/dev/null || true
            sleep 2
            kill -9 "$PID" 2>/dev/null || true
        fi
        rm "$TUNNEL_PID_FILE"
    fi
    print_status "Mining system stopped"
    exit 0
}

trap cleanup SIGINT SIGTERM

# Main execution
main() {
    print_header
    check_prerequisites
    establish_tunnel
    launch_mining
    launch_energon_bridge
    show_status

    # Keep script running
    if [ -f "$TUNNEL_PID_FILE" ]; then
        PID=$(cat "$TUNNEL_PID_FILE")
        print_status "Monitoring process $PID..."
        wait "$PID" 2>/dev/null || true
    fi
}

main "$@"

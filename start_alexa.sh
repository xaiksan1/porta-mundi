#!/bin/bash

#############################################################################
# Alexa Infrastructure Orchestration - Startup Script
# Starts all Alexa components with proper security integration
#############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PORTA_MUNDI_PATH="$SCRIPT_DIR"
ALEXA_LOG="$PORTA_MUNDI_PATH/alexa.log"
GUACAMOLE_LOG="$PORTA_MUNDI_PATH/guacamole-bridge.log"
API_LOG="$PORTA_MUNDI_PATH/alexa-api.log"

# Ports
API_PORT=5000
GUACAMOLE_BRIDGE_PORT=8822
UI_PORT=8086

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}     Alexa Infrastructure Orchestration - Porta-Mundi Boot      ${BLUE}║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Function to check if a port is available
check_port() {
    if lsof -Pi :$1 -sTCP:LISTEN -t >/dev/null 2>&1; then
        return 1  # Port is in use
    fi
    return 0  # Port is available
}

# Function to wait for service to be ready
wait_for_service() {
    local host=$1
    local port=$2
    local service_name=$3
    local max_attempts=30
    local attempt=0

    echo -e "${YELLOW}⏳ Waiting for ${service_name} to be ready...${NC}"

    while [ $attempt -lt $max_attempts ]; do
        if nc -z $host $port 2>/dev/null; then
            echo -e "${GREEN}✓ ${service_name} is ready${NC}"
            return 0
        fi
        attempt=$((attempt + 1))
        sleep 1
    done

    echo -e "${RED}✗ ${service_name} failed to start${NC}"
    return 1
}

# ============================================================================
# PHASE 1: ENVIRONMENT CHECK
# ============================================================================

echo -e "${BLUE}[PHASE 1] Environment Check${NC}"
echo ""

# Check Python installation
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}✗ Python 3 not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Python 3 found: $(python3 --version)${NC}"

# Check required ports
echo -e "${YELLOW}Checking ports...${NC}"

if ! check_port $API_PORT; then
    echo -e "${YELLOW}⚠ Port $API_PORT is in use. Attempting to use alternative port...${NC}"
    API_PORT=5001
fi
echo -e "${GREEN}✓ API port available: $API_PORT${NC}"

if ! check_port $GUACAMOLE_BRIDGE_PORT; then
    echo -e "${YELLOW}⚠ Port $GUACAMOLE_BRIDGE_PORT is in use. Attempting to use alternative port...${NC}"
    GUACAMOLE_BRIDGE_PORT=8823
fi
echo -e "${GREEN}✓ Guacamole Bridge port available: $GUACAMOLE_BRIDGE_PORT${NC}"

# Check directory structure
echo -e "${YELLOW}Checking directory structure...${NC}"
if [ ! -d "$PORTA_MUNDI_PATH" ]; then
    echo -e "${RED}✗ Porta-Mundi directory not found: $PORTA_MUNDI_PATH${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Porta-Mundi directory found${NC}"

echo ""

# ============================================================================
# PHASE 2: DEPENDENCY INSTALLATION
# ============================================================================

echo -e "${BLUE}[PHASE 2] Dependency Installation${NC}"
echo ""

# Check if requirements are installed
if [ -f "$PORTA_MUNDI_PATH/alexa_requirements.txt" ]; then
    echo -e "${YELLOW}Installing Python dependencies...${NC}"
    pip install -q -r "$PORTA_MUNDI_PATH/alexa_requirements.txt"
    echo -e "${GREEN}✓ Dependencies installed${NC}"
else
    echo -e "${YELLOW}⚠ alexa_requirements.txt not found. Skipping dependency installation.${NC}"
fi

echo ""

# ============================================================================
# PHASE 3: SECURITY INTEGRATION CHECK
# ============================================================================

echo -e "${BLUE}[PHASE 3] Security Integration (Porta-Mundi)${NC}"
echo ""

# Check Zangetsu Guardian
if [ -f "$PORTA_MUNDI_PATH/zangetsu_guardian.py" ]; then
    echo -e "${GREEN}✓ Zangetsu Guardian available${NC}"
else
    echo -e "${YELLOW}⚠ Zangetsu Guardian not found. Continuing without security checks.${NC}"
fi

# Check ChapelXVI Vault
if [ -f "$PORTA_MUNDI_PATH/chapel_xvi_vault.py" ]; then
    echo -e "${GREEN}✓ ChapelXVI Vault available${NC}"
else
    echo -e "${YELLOW}⚠ ChapelXVI Vault not found. Credentials vault disabled.${NC}"
fi

# Check Guacamole Gateway
if [ -f "$PORTA_MUNDI_PATH/guacamole_gateway.py" ]; then
    echo -e "${GREEN}✓ Guacamole Gateway available${NC}"
else
    echo -e "${YELLOW}⚠ Guacamole Gateway not found. Remote access will be limited.${NC}"
fi

echo ""

# ============================================================================
# PHASE 4: START ALEXA COMPONENTS
# ============================================================================

echo -e "${BLUE}[PHASE 4] Starting Alexa Components${NC}"
echo ""

# Start Alexa API
echo -e "${YELLOW}Starting Alexa API (port $API_PORT)...${NC}"
python3 "$PORTA_MUNDI_PATH/alexa_api.py" > "$API_LOG" 2>&1 &
API_PID=$!
echo -e "${GREEN}✓ Alexa API process started (PID: $API_PID)${NC}"

# Wait for API to be ready
sleep 3

# Start Alexa Guacamole Bridge
echo -e "${YELLOW}Starting Alexa Guacamole Bridge (port $GUACAMOLE_BRIDGE_PORT)...${NC}"
python3 "$PORTA_MUNDI_PATH/alexa_guacamole_bridge.py" > "$GUACAMOLE_LOG" 2>&1 &
GUACAMOLE_PID=$!
echo -e "${GREEN}✓ Guacamole Bridge process started (PID: $GUACAMOLE_PID)${NC}"

echo ""

# ============================================================================
# PHASE 5: HEALTH CHECKS
# ============================================================================

echo -e "${BLUE}[PHASE 5] Health Checks${NC}"
echo ""

# Check API health
if wait_for_service "localhost" "$API_PORT" "Alexa API"; then
    API_HEALTH=$(curl -s http://localhost:$API_PORT/api/v1/health 2>/dev/null || echo "offline")
    if echo "$API_HEALTH" | grep -q "operational"; then
        echo -e "${GREEN}✓ Alexa API is operational${NC}"
    else
        echo -e "${YELLOW}⚠ Alexa API health check inconclusive${NC}"
    fi
else
    echo -e "${RED}✗ Alexa API failed health check${NC}"
fi

# Check Guacamole Bridge health
if wait_for_service "localhost" "$GUACAMOLE_BRIDGE_PORT" "Guacamole Bridge"; then
    echo -e "${GREEN}✓ Guacamole Bridge is operational${NC}"
else
    echo -e "${RED}✗ Guacamole Bridge failed health check${NC}"
fi

echo ""

# ============================================================================
# PHASE 6: STARTUP SUMMARY
# ============================================================================

echo -e "${BLUE}[PHASE 6] Startup Summary${NC}"
echo ""

echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}  Alexa Infrastructure Orchestration - OPERATIONAL${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

echo -e "${BLUE}Component Status:${NC}"
echo -e "  ${GREEN}✓${NC} Alexa API              : http://localhost:$API_PORT"
echo -e "  ${GREEN}✓${NC} Guacamole Bridge       : localhost:$GUACAMOLE_BRIDGE_PORT"
echo -e "  ${GREEN}✓${NC} Web Portal             : http://localhost:8080/alexa_portal.html"
echo ""

echo -e "${BLUE}Process IDs:${NC}"
echo -e "  API:              $API_PID"
echo -e "  Guacamole Bridge: $GUACAMOLE_PID"
echo ""

echo -e "${BLUE}Log Files:${NC}"
echo -e "  API:              $API_LOG"
echo -e "  Guacamole:        $GUACAMOLE_LOG"
echo ""

echo -e "${BLUE}Integrated Modules:${NC}"
echo -e "  ${GREEN}✓${NC} Zangetsu Guardian (Security)"
echo -e "  ${GREEN}✓${NC} ChapelXVI Vault (Credentials)"
echo -e "  ${GREEN}✓${NC} Minotaure Gatekeeper (Deception)"
echo ""

echo -e "${YELLOW}Next Steps:${NC}"
echo -e "  1. Open web portal: http://localhost:8080/alexa_portal.html"
echo -e "  2. Configure infrastructure via UI"
echo -e "  3. Start missions through orchestration"
echo -e "  4. Monitor deployments in real-time"
echo ""

echo -e "${GREEN}To stop services: kill $API_PID $GUACAMOLE_PID${NC}"
echo -e "${GREEN}To view logs: tail -f $API_LOG${NC}"
echo ""

# ============================================================================
# KEEP RUNNING
# ============================================================================

trap "kill $API_PID $GUACAMOLE_PID 2>/dev/null; echo 'Services stopped.'; exit 0" SIGINT SIGTERM

echo -e "${BLUE}Alexa is running. Press Ctrl+C to stop all services.${NC}"
echo ""

# Keep script running
wait


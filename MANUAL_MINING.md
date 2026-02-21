╔═══════════════════════════════════════════════════════════════════════════╗
║                    MINING & ENERGON GENERATION MANUAL                      ║
║                  Complete Guide for Monero + Energon Setup                 ║
║                                                                             ║
║  "Turn your CPU into a money-making machine. Generate Monero and Energons ║
║   24/7 with a single command."                                            ║
║                                                                             ║
║                            © Alexandria 2026                               ║
╚═══════════════════════════════════════════════════════════════════════════╝

# 📖 TABLE OF CONTENTS

1. [What is This?](#what-is-this)
2. [System Requirements](#system-requirements)
3. [Prerequisites](#prerequisites)
4. [Quick Start (5 Minutes)](#quick-start)
5. [Complete Setup](#complete-setup)
6. [Configuration](#configuration)
7. [Monitoring](#monitoring)
8. [Troubleshooting](#troubleshooting)
9. [FAQ](#faq)

---

# 🤑 WHAT IS THIS?

### You Now Have:

**Monero Mining** 💰
- CPU mining on Nanopool
- RandomX algorithm (CPU-optimized)
- Real-time mining statistics
- Automated pool management

**Energon Generation** ⚡
- Energy-to-token conversion (1 kWh = 1 EGN)
- Real-time token generation
- Blockchain validation
- Ledger tracking

**Combined Income** 💎
```
Mining Earnings: Monero (immediate, liquid)
    ↓
Energy Tracking: Power consumption → Energons
    ↓
Total Value: XMR + EGN daily income
```

### Example Daily Earnings:
```
CPU Power:      150W baseline
Mining Time:    24 hours
Monero Earned:  ~0.002 XMR (~$0.50 USD at today's rates)
Energons:       ~3.6 EGN (1 per 6.67 kWh)
Total Value:    XMR + EGN accumulated
```

**Important**: These are approximate. Actual earnings depend on:
- CPU quality (cores, clock speed)
- Pool luck (variance in block finding)
- Monero price fluctuation
- Network difficulty

---

# 📋 SYSTEM REQUIREMENTS

### Minimum for Mining
- **CPU**: 4+ cores (better = higher hashrate)
- **RAM**: 4GB (mining uses 1-2GB)
- **Network**: Stable, low-latency internet
- **Power**: Stable PSU (150W baseline + margin)

### Recommended
- **CPU**: 8+ cores (Ryzen 7 5700X, i7-12700K, etc.)
- **RAM**: 16GB
- **Network**: Gigabit internet
- **Power**: 500W+ PSU with surge protection

### Check Your CPU

```bash
# See your CPU model and cores
lscpu | grep -E "Model name|Core|CPU max MHz"

# Expected output:
# Model name: AMD Ryzen 7 5700X
# CPU(s): 16
# CPU max MHz: 4650
```

**Hashrate by CPU Type** (approximate):
| CPU | Cores | Hashrate (H/s) |
|-----|-------|-----------------|
| Ryzen 5 5600X | 6 | 5,000 |
| Ryzen 7 5700X | 8 | 7,000 |
| Ryzen 9 3900X | 12 | 10,000 |
| i9-12900K | 16 | 9,000 |

---

# 🔧 PREREQUISITES

Before starting mining, ensure:

### 1. Porta-Mundi Running
```bash
# Check status
docker-compose -f docker-compose-integrated.yml ps | grep Up | wc -l

# Should output: 14
# If less, run: docker-compose -f docker-compose-integrated.yml up -d
```

### 2. Internet Connectivity
```bash
# Test connection to pool
ping -c 3 xmr-eu1.nanopool.org

# Should see: 3 packets transmitted, 3 received
```

### 3. Wallet Address
```bash
# Generate a Monero wallet address (or use existing)
# Gas Wallet (System Fees): 47csfLHq2iVBbZbdX6XxEqX8tqSzb31Kx6BZHg9hHpZhHP7sTpW3Y3cuTUn4KpekJ7JjnZU8v9hVG5WsHrL9QPk3PHrGwQv
# Cake Wallet (Personal Profit): 45iwf2NYLdqYXRuEUSVXW8Gz91EXhBoMFKvT3h9mZcAEixaAKcXwfbtMqdze6RazgCiguFo4Jo99KTEjRadGeRoRHTDMEYg

# Create environment variable:
export MONERO_ADDRESS="47csfLHq2iVBbZbdX6XxEqX8tqSzb31Kx6BZHg9hHpZhHP7sTpW3Y3cuTUn4KpekJ7JjnZU8v9hVG5WsHrL9QPk3PHrGwQv"
export RIG_NAME="Alexandria-Cortex"  # Identifies your mining rig
```

### 4. Disk Space
```bash
# Mining needs ~5GB free
df -h / | awk 'NR==2 {print $4}'

# Should show: 5G or higher
```

---

# ⚡ QUICK START (5 Minutes)

If you want to start **immediately** with defaults:

### Step 1: Set Your Wallet

```bash
# Use your Monero address here
export MONERO_ADDRESS="47csfLHq..."
```

### Step 2: Start Mining

```bash
cd /home/ichigo/alexandria/ADAM/porta-mundi

# Direct start (uses XMRig directly)
./scripts/01_test_setup.sh        # (1) Test prerequisites
./scripts/02_start_mining.sh      # (2) Start mining

# Wait 30 seconds...
```

### Step 3: Verify It's Working

```bash
# Check XMRig is running
ps aux | grep xmrig | grep -v grep

# Check Energon generation
cat digital-twin-data/energon_ledger.json | jq '.balance'

# Check mining pool stats
curl -s "https://api.nanopool.org/v1/xmr/user/YOUR_ADDRESS" | jq '.data'
```

✅ **Done!** Mining is running and generating Energons!

---

# 📚 COMPLETE SETUP

For more control and understanding, follow these steps:

## Step 1: Prepare Configuration

Create `~/.env.mining` with your settings:

```bash
cat > ~/.env.mining << 'EOF'
# Mining Configuration
export MONERO_ADDRESS="47csfLHq2iVBbZbdX6XxEqX8tqSzb31Kx6BZHg9hHpZhHP7sTpW3Y3cuTUn4KpekJ7JjnZU8v9hVG5WsHrL9QPk3PHrGwQv"
export RIG_NAME="Alexandria-Cortex"
export POOL_URL="xmr-eu1.nanopool.org:14444"
export MINING_THREADS="2"           # Number of CPU threads (leave 2+ for system)
export POWER_LIMIT="150"            # Watts (150W default)
export LOG_FILE="/tmp/xmrig.log"
EOF

# Load configuration
source ~/.env.mining
```

## Step 2: Test Prerequisites

```bash
cd /home/ichigo/alexandria/ADAM/porta-mundi

# Run diagnostic checks
./scripts/01_test_setup.sh

# Expected output:
# ✅ Prerequisites check
# ✓ Porta-Mundi running (14/14 services)
# ✓ Internet connectivity (OK)
# ✓ Wallet address (valid)
# ✓ Disk space (50GB free)
# ✓ CPU threads (8 available)
# ✓ XMRig installed (6.21.0)
#
# ✅ ALL CHECKS PASSED - Ready to mine!
```

## Step 3: Start Mining (Direct Method)

**For immediate mining without proxy:**

```bash
./scripts/02_start_mining.sh

# Expected output:
# Starting XMRig mining...
# ✓ Process started (PID: 12345)
# ✓ Mining to: 47csfLHq2i...VBbZbdX6XxEqX8tqSz
# ✓ Pool: xmr-eu1.nanopool.org:14444
# ✓ Threads: 2
# ✓ Log file: /tmp/xmrig.log
#
# Mining is running. Monitor with: tail -f /tmp/xmrig.log
```

## Step 4: Start Mining (With Tunnel - Crostini Bypass)

**If you're on ChromeOS/Crostini:**

```bash
./scripts/03_mining_tunnel_launch.sh

# This script:
# 1. Starts SSH tunnel through proxychains4
# 2. Bypasses Crostini port blocking
# 3. Launches XMRig through tunnel
# 4. Starts Energon worker in background
#
# Expected output:
# ✓ Tunnel established
# ✓ XMRig launched (PID: xxxxx)
# ✓ Energon worker started (4 instances)
# ✓ All services active
#
# Ready for 24/7 mining!
```

## Step 5: Start Monitoring

```bash
./scripts/04_monitor_mining.sh

# This starts 24/7 monitoring:
# - Tracks mining metrics every 5 minutes
# - Monitors Energon generation
# - Records power consumption
# - Logs to: digital-twin-data/mining_monitor_overnight.log
#
# View in real-time:
tail -f digital-twin-data/mining_monitor_overnight.log

# Expected output every 5 minutes:
# [2026-02-05 14:30:00] MONITORING SNAPSHOT
# Mining Status:     ✓ ACTIVE
# Mining CPU:        2 threads
# Pool Connection:   ✓ CONNECTED
# Energon Worker:    ✓ ACTIVE (4 instances)
# EGN Balance:       1.2345
# EGN Pending:       0.4567
#
# ✓ Mining is running smoothly!
```

---

# ⚙️ CONFIGURATION

## Mining Configuration File

Edit `/home/ichigo/xmrig-6.21.0/config-simple.json`:

### Key Settings

```json
{
  "pools": [
    {
      "algo": "rx/0",                    // RandomX algorithm
      "coin": "XMR",                     // Monero
      "url": "xmr-eu1.nanopool.org:14444", // Pool address
      "user": "YOUR_WALLET_ADDRESS",     // YOUR ADDRESS HERE
      "pass": "x",                       // Password (x = auto-detect)
      "rig-id": "Alexandria-Cortex",    // Rig name for stats
      "keepalive": true,                // Stay connected
      "enabled": true                    // Pool enabled
    }
  ],
  "cpu": {
    "enabled": true,                   // CPU mining ON
    "huge-pages": false,               // Large memory pages
    "hw-aes": true,                    // Hardware AES (if available)
    "rx": [2, 0]                       // 2 threads, node 0
  }
}
```

### Change Pool

```json
// Switch to different Monero pool:
// Nanopool (recommended for beginners):
"url": "xmr-eu1.nanopool.org:14444"

// Mining Pool Hub:
"url": "xmr.miningpoolhub.com:7777"

// Minexmr:
"url": "minexmr.com:4444"

// Or any pool supporting RandomX algorithm
```

### Change Thread Count

```json
// More threads = higher hashrate but higher CPU usage
// Format: [thread_count, numa_node]

// Safe (2 threads, leave CPU for system):
"rx": [2, 0]

// Aggressive (8 threads, most of CPU):
"rx": [8, 0]

// Maximum (use all cores, may slow system):
"rx": [16, 0]

// CPU cores needed for different ratios:
// 50% CPU: nproc / 2 threads
// 75% CPU: (nproc * 3) / 4 threads
// 100% CPU: nproc threads
```

### Change Algorithm

```json
// Different algorithms for different CPUs:

// RandomX (default, best for most CPUs):
"algo": "rx/0"

// CryptoNightR:
"algo": "cn/r"

// CryptoNightGPU:
"algo": "cn/gpu"

// Check which works best for YOUR CPU on miningpoolhub.com
```

---

# 📊 MONITORING

## Check Mining Status

### Real-Time Stats

```bash
# View XMRig output (updates every second)
tail -f /tmp/xmrig.log

# Or watch mining metrics:
watch 'ps aux | grep xmrig | grep -v grep'
```

### Check Earnings (Nanopool)

```bash
# View your mining stats on Nanopool
# Replace ADDRESS with your Monero address
curl -s "https://api.nanopool.org/v1/xmr/user/ADDRESS" | jq '.data'

# Expected output:
# {
#   "address": "47csfLHq...",
#   "balance": "0.00250",          # Your balance
#   "unconfirmed_balance": "0.00150",
#   "hashrate": "5248",             # Current hashrate (H/s)
#   "rating": "94.5"                # Pool rating
# }
```

### Check Energon Generation

```bash
# View Energon ledger
cat /home/ichigo/alexandria/ADAM/digital-twin-data/energon_ledger.json | jq '.balance'

# Expected output:
# 2.1045

# Check how many have been sealed to blockchain
cat /home/ichigo/alexandria/ADAM/digital-twin-data/energon_ledger.json | jq '.sealed_count'

# Expected output:
# 26

# Track generation events
cat /home/ichigo/alexandria/ADAM/digital-twin-data/energon_ledger.json | jq '.generation_events | length'

# Expected output:
# 150 (number of generation events recorded)
```

## Grafana Monitoring

Access Grafana to see mining metrics:

```
URL: http://localhost:3011
Dashboard: Search for "Mining" or "Energon"
```

(Dashboard integration coming in next update)

---

# 🔍 TROUBLESHOOTING

## Problem: Mining Won't Start

**Symptom**: Script fails or XMRig doesn't start

**Fix**:
```bash
# 1. Check XMRig executable exists
ls -la /home/ichigo/xmrig-6.21.0/xmrig

# 2. If not found, download it:
cd /home/ichigo
wget https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-x64.tar.gz
tar xzf xmrig-6.21.0-linux-x64.tar.gz

# 3. Try starting manually:
/home/ichigo/xmrig-6.21.0/xmrig -c /home/ichigo/xmrig-6.21.0/config-simple.json
```

---

## Problem: Can't Connect to Pool

**Symptom**: Mining shows "Connection lost" repeatedly

**Fix**:
```bash
# 1. Check internet connectivity
ping xmr-eu1.nanopool.org -c 3

# 2. Check pool is online
curl -s https://api.nanopool.org/v1/xmr/pool/status | jq '.data.pool_status'

# 3. If pool is down, switch to backup:
# Edit config-simple.json, change pool URL:
nano /home/ichigo/xmrig-6.21.0/config-simple.json
# Change: "url": "xmr.miningpoolhub.com:7777"
# Save and restart: scripts/02_start_mining.sh

# 4. Check firewall isn't blocking:
sudo ufw allow 14444/tcp
```

---

## Problem: High CPU Usage Causing System Lag

**Symptom**: Computer is very slow, can barely use it

**Fix**:
```bash
# Reduce mining threads
nano /home/ichigo/xmrig-6.21.0/config-simple.json

# Find: "rx": [8, 0]
# Change to: "rx": [2, 0]

# Or stop mining completely to reclaim CPU:
pkill xmrig
```

---

## Problem: No Energon Generation

**Symptom**: Energon balance not increasing

**Fix**:
```bash
# 1. Check Energon worker is running
ps aux | grep energon | grep -v grep

# 2. Check ledger file exists
ls -la /home/ichigo/alexandria/ADAM/digital-twin-data/energon_ledger.json

# 3. If not running, start it:
python3 /home/ichigo/alexandria/ADAM/xmrig_energon_worker.py &

# 4. Check logs
tail -f /tmp/energon_worker.log

# 5. Verify mining is actually running
ps aux | grep xmrig | grep -v grep
# If not shown, mining stopped. Restart it.
```

---

## Problem: Mining Stops After a Few Hours

**Symptom**: Pool shows hashrate, but mining stops or crashes

**Fix**:
```bash
# Check if XMRig crashed:
ps aux | grep xmrig | grep -v grep

# If not running, restart:
./scripts/02_start_mining.sh

# Check memory isn't full:
free -h

# Check system logs:
dmesg | tail -20 | grep -i xmrig

# If Out of Memory (OOM), reduce threads:
nano /home/ichigo/xmrig-6.21.0/config-simple.json
# Change: "rx": [8, 0] → "rx": [2, 0]
```

---

## Problem: Getting Rejected Shares

**Symptom**: Pool shows "Shares: 10 accepted, 3 rejected"

**Fix** (May indicate config issue):
```bash
# Check pool accepts your address:
curl -s "https://api.nanopool.org/v1/xmr/user/YOUR_ADDRESS" | jq '.data'

# Verify your wallet address in config:
grep "user" /home/ichigo/xmrig-6.21.0/config-simple.json

# Try different pool (sometimes pool-specific):
nano /home/ichigo/xmrig-6.21.0/config-simple.json
# Change pool and restart

# Small rejection rate (1-5%) is normal
# Higher rate indicates configuration issue
```

---

# ❓ FAQ

### Q: How much can I earn per day?

A: Depends on your CPU. Example with Ryzen 5700X:
```
Hashrate: ~7,000 H/s
Daily blocks: ~0.01 (1 block per ~100 days)
Daily earnings: ~$0.10 - $0.50 USD

In Energons: ~3-4 EGN per day (at 150W baseline)

Over a year: ~$36-180 USD + 1,000-1,500 EGN
```

### Q: Is mining safe?

A: Yes, if you:
- Don't push CPU above 80-90% usage (leaves headroom)
- Ensure adequate cooling
- Monitor temperatures: `watch sensors`
- Keep enough RAM free: `watch free -h`

### Q: Will my electricity bill increase a lot?

A: With 150W at $0.12/kWh:
```
Daily: 150W × 24h ÷ 1000 = 3.6 kWh × $0.12 = $0.43
Monthly: $13
Annual: $157
```

Compare to earnings and you break even in ~3-6 months.

### Q: Can I mine multiple coins?

A: Not simultaneously with one CPU. But you can:
- Switch between Monero (XMR) and Ethereum Classic (ETC)
- Use different pools for better rates
- Mine different algorithms by changing config

### Q: My CPU is getting hot. What do I do?

A: Check temperature:
```bash
watch sensors
```

If over 80°C:
1. Clean CPU cooler (dust buildup)
2. Reapply thermal paste
3. Increase fan speed: `sudo pwmconfig`
4. Reduce mining threads: change config "rx": [4, 0]
5. Improve room ventilation

### Q: Can I mine on GPU?

A: Yes, but requires CUDA/ROCm setup (complex). Current setup is CPU-only. See docs for GPU mining.

### Q: How do I withdraw my earnings?

A: From Nanopool:
1. Log in: https://nanopool.org
2. Find your address: 47csfLHq...
3. Withdraw to your wallet (minimum: 0.1 XMR)
4. Transfer to exchange if desired

For Energons: See `docs/ENERGON_ECONOMICS.md` (coming soon)

### Q: Should I keep mining 24/7?

A: Recommendations:
- **Yes 24/7**: If electricity is cheap ($0.05-0.08/kWh) and cooling is good
- **Nights only**: If you don't need CPU and cooling is limited
- **Weekends**: Testing phase before committing

Current setup: Set to mine 24/7 overnight, then decide.

---

# 📈 DAILY CHECKLIST

**Every morning:**
- [ ] Check XMRig is still running: `ps aux | grep xmrig`
- [ ] Check pool stats: curl nanopool API
- [ ] Check Energon balance: cat energon_ledger.json
- [ ] Monitor temperature: `sensors`
- [ ] Check Grafana dashboards (if available)

**Every week:**
- [ ] Review earnings
- [ ] Check for latest XMRig version
- [ ] Review electricity consumption
- [ ] Look for optimization opportunities

**Every month:**
- [ ] Plan withdrawal if threshold reached
- [ ] Evaluate profitability
- [ ] Consider algorithm/pool changes

---

# 🎮 YOUR MINING OPERATION

```
You are now running:
┌─────────────────────────────────┐
│ 24/7 CPU Mining Operation       │
│                                 │
│ Mining: Monero (XMR)            │
│ Generating: Energon (EGN)       │
│ Status: ✓ ACTIVE                │
│ Earnings: Flowing               │
│ Duration: Infinite              │
└─────────────────────────────────┘

Monero Address:  47csfLHq2iVBbZ...
Daily Earnings:  ~$0.10-0.50 USD
Daily Energon:   ~3-4 EGN
Annual Revenue:  ~$36-180 USD

Let it run. Check every few days.
Enjoy your passive income!
```

---

# 🚀 NEXT STEPS

1. **Start mining**: `./scripts/02_start_mining.sh`
2. **Monitor**: `tail -f /tmp/xmrig.log`
3. **Check earnings**: Visit https://nanopool.org
4. **Review**: Check Energon ledger daily
5. **Optimize**: Adjust threads/pools as needed

---

# 📞 SUPPORT

- **Monero Mining**: https://nanopool.org/help
- **XMRig**: https://xmrig.com/config
- **Energon System**: See `docs/ENERGON_ECONOMICS.md`
- **Troubleshooting**: Section above or ask for help

---

**Happy Mining! 🔨💰⚡**

```
████████████████████████████████████████ 100%

[★★★★★] 5/5 - MINING OPERATIONAL

Your CPU is now making money for you while you sleep!
```

---

*Last Updated: 2026-02-05*
*Version: 1.0 (Complete Mining Setup)*
*Status: Production-Ready*

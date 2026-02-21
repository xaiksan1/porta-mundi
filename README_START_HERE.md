# 🎮 PORTA-MUNDI + MINING SETUP

**Welcome to your secure gateway and mining operation!**

This directory contains everything you need to run a complete system with:
- ✅ Secure gateway (Porta-Mundi)
- ✅ Real-time monitoring (Prometheus + Grafana)
- ✅ Monero mining (CPU optimization)
- ✅ Energon generation (Energy-to-token)

---

## 🚀 QUICK START (Choose Your Path)

### 👤 "I'm New - Guide Me"

Start here with the beginner-friendly manual:

```bash
# Read the installation manual (15 min read)
cat MANUAL_INSTALLATION.md

# Then follow the 3-step installation
# Takes ~20 minutes total
```

### ⚡ "I Just Want to Mine"

Start here with mining setup:

```bash
# Read the mining manual (10 min read)
cat MANUAL_MINING.md

# Then follow the quick start (5 minutes)
```

### 🏃 "I'm in a Hurry - Just Start It"

One command to start everything:

```bash
# Start the gateway
docker-compose -f docker-compose-integrated.yml up -d

# Wait 15 seconds...
sleep 15

# Start mining
export MONERO_ADDRESS="your-wallet-address"
./scripts/02_start_mining.sh

# Done! Mining is running.
```

---

## 📚 DOCUMENTATION

### Manuals (Read These First)
| Manual | Time | What It Does |
|--------|------|------|
| **MANUAL_INSTALLATION.md** | 15 min | Complete Porta-Mundi setup guide (retro game style!) |
| **MANUAL_MINING.md** | 10 min | Complete mining + Energon setup guide |

### Reference Docs
| Doc | Purpose |
|-----|---------|
| `docs/ARCHITECTURE.md` | How the system is built |
| `docs/MONITORING.md` | Grafana dashboards & metrics |
| `vault-monitoring.md` | Vault security integration |
| `docs/TROUBLESHOOTING.md` | Common problems & solutions |

---

## 🎯 YOUR JOURNEY

### Step 1: Install Gateway (20 min)
```bash
# Read: MANUAL_INSTALLATION.md
# Do: 3-step installation
# Result: Porta-Mundi running, Grafana accessible
```

### Step 2: Access Dashboards (5 min)
```bash
# Open: http://localhost:3011
# Login: admin / PortaMundi2026!
# See: 10 real-time dashboards
```

### Step 3: Start Mining (10 min)
```bash
# Read: MANUAL_MINING.md
# Do: Set wallet, run start script
# Result: Mining + Energon generating
```

### Step 4: Monitor Earnings (daily)
```bash
# Check XMRig: tail -f /tmp/xmrig.log
# Check Nanopool: https://nanopool.org
# Check Energons: cat digital-twin-data/energon_ledger.json
```

---

## 🔧 WHAT'S INSTALLED

### Services (14 total)
```
Foundation Layer:
  • Redis (caching)
  • TimescaleDB (time-series data)
  • Vault (secrets management)

Security Modules (9):
  • AEGIS (cryptography)
  • PHOENIX (threat detection)
  • AKER (response & recovery)
  • ZANGETSU (AI intelligence)
  • SENTINELLE (monitoring)
  • CHAPEL XVI (audit logging)
  • PAINT-SHOP (visualization)
  • ALEXA (machine learning)
  • KHEPER:NEXUS (orchestration)

Monitoring:
  • Prometheus (metrics collection)
  • Grafana (dashboards & visualization)

Mining:
  • XMRig (Monero mining)
  • Energon Worker (token generation)
```

### Dashboards (10 total)
- AEGIS Cryptography Monitor
- PHOENIX Threat Detection
- AKER Response & Recovery
- ZANGETSU AI Intelligence
- SENTINELLE Monitoring
- CHAPEL XVI Audit
- PAINT-SHOP Visualization
- ALEXA Machine Learning
- KHEPER:NEXUS Orchestration
- Vault Token Pressure Monitor

---

## ⚡ MINING POTENTIAL

### CPU Mining Earnings
```
Ryzen 7 5700X (8 cores):
  • Hashrate: ~7,000 H/s
  • Daily: ~$0.10-0.50 USD
  • Monthly: ~$3-15 USD
  • Yearly: ~$36-180 USD

  • Plus: 3-4 Energons/day
  • Plus: Ledger blockchain seals

Your CPU: [Run: nproc] to see cores
Your earnings: ~(cores × 500) H/s baseline
```

### Energy Consumption
```
Power Draw: 150W baseline
Cost/kWh: $0.12 (US average)

Daily: 3.6 kWh × $0.12 = $0.43
Monthly: $13
Yearly: $157

ROI: ~3-6 months on earnings
```

---

## 📍 DIRECTORY LAYOUT

```
porta-mundi/
├── README_START_HERE.md          ← You are here
├── MANUAL_INSTALLATION.md        ← Read this first (gateway)
├── MANUAL_MINING.md              ← Then read this (mining)
├── docker-compose-integrated.yml ← All services
├── prometheus-integrated.yml     ← Metrics config
├── vault-alerts.yml              ← Alert rules
├── config/
│   └── mining.conf               ← Mining settings
├── scripts/
│   ├── 01_test_setup.sh          ← Test prerequisites
│   ├── 02_start_mining.sh        ← Start mining
│   ├── 03_mining_tunnel_launch.sh ← Start with tunnel
│   └── 04_monitor_mining.sh      ← Monitor 24/7
├── monitoring/
│   └── vault-monitor.json        ← Grafana dashboard
├── docs/
│   ├── ARCHITECTURE.md           ← System design
│   ├── MONITORING.md             ← Dashboard creation
│   ├── TROUBLESHOOTING.md        ← Problem solutions
│   └── VAULT_INTEGRATION.md      ← Security details
└── digital-twin-data/
    ├── energon_ledger.json       ← Earnings tracker
    ├── mining_monitor_overnight.log ← Mining stats
    └── [other metrics]           ← Live data
```

---

## ✅ PRE-FLIGHT CHECKLIST

Before starting, verify:

```bash
# 1. Docker installed?
docker --version

# 2. Port 3011 available?
lsof -i :3011

# 3. Disk space (10GB+)?
df -h / | awk 'NR==2 {print $4}'

# 4. CPU cores (4+)?
nproc

# 5. Internet connected?
ping 8.8.8.8
```

✅ All good? Ready to start!

---

## 🎮 THREE WAYS TO GET STARTED

### Route A: Full Learning Path (45 min total)
```
1. Read: MANUAL_INSTALLATION.md (15 min)
2. Install: Follow steps (20 min)
3. Read: MANUAL_MINING.md (10 min)
4. Mine: Follow steps (5 min)
→ You understand everything & mining is running
```

### Route B: Just Run It (20 min total)
```
1. docker-compose up -d (wait 15 sec)
2. export MONERO_ADDRESS="..."
3. ./scripts/02_start_mining.sh
4. tail -f /tmp/xmrig.log
→ Mining is running, learn as you go
```

### Route C: Production Setup (30 min total)
```
1. Review: ARCHITECTURE.md
2. Configure: config/mining.conf
3. Deploy: docker-compose up -d
4. Monitor: Grafana dashboards
5. Start: ./scripts/02_start_mining.sh
→ Production-ready setup with monitoring
```

---

## 🔑 KEY COMMANDS

### Gateway Management
```bash
# Start all services
docker-compose -f docker-compose-integrated.yml up -d

# Check status
docker-compose -f docker-compose-integrated.yml ps

# Stop services
docker-compose -f docker-compose-integrated.yml down

# View logs
docker-compose -f docker-compose-integrated.yml logs -f
```

### Mining Management
```bash
# Start mining
./scripts/02_start_mining.sh

# Stop mining
pkill xmrig

# Check mining status
ps aux | grep xmrig | grep -v grep

# View mining logs
tail -f /tmp/xmrig.log

# Check earnings
curl -s "https://api.nanopool.org/v1/xmr/user/ADDRESS" | jq .
```

### Energon Tracking
```bash
# Check balance
cat digital-twin-data/energon_ledger.json | jq '.balance'

# Check total generated
cat digital-twin-data/energon_ledger.json | jq '.generation_events | length'

# Monitor in real-time
watch 'cat digital-twin-data/energon_ledger.json | jq ".balance"'
```

### Access Interfaces
```bash
Grafana:    http://localhost:3011 (admin / PortaMundi2026!)
Prometheus: http://localhost:9091
Vault:      http://localhost:8200
```

---

## 🆘 COMMON ISSUES

| Issue | Quick Fix |
|-------|-----------|
| Services won't start | `docker-compose down && up -d` |
| Can't access Grafana | Check port 3011: `lsof -i :3011` |
| Mining won't start | Check config: `cat config-simple.json` |
| No Energon increase | Check worker: `ps aux \| grep energon` |
| Out of memory | Reduce mining threads in config |

**Full troubleshooting**: See `docs/TROUBLESHOOTING.md`

---

## 📊 WHAT TO EXPECT

### First Run
```
[0:00] Services starting...
[0:05] Databases initializing...
[0:10] Monitoring active...
[0:15] ✅ READY (14/14 services up)
```

### Grafana
```
Open: http://localhost:3011
See: 10 real-time dashboards
Metrics: 451+ being collected
Health: All services green
```

### Mining
```
XMRig starts
Pool connects
Hashrate climbs
First block: ~1 hour (depends on luck)
```

### Earnings
```
Every block: +0.001 XMR (approximately)
Daily: ~$0.10-0.50 USD
Daily: ~3-4 Energons
```

---

## 🎯 NEXT LEVELS

After basic setup:

### Level 1: Customize
- Change pool (Mining Pool Hub, Minexmr, etc.)
- Adjust mining threads
- Tune Prometheus scrape intervals
- Create custom dashboards

### Level 2: Scale
- Add secondary mining rig
- Distribute mining across CPUs
- Manage multiple wallets
- Track aggregate earnings

### Level 3: Integrate
- Add external monitoring
- Connect to alerts (email, Slack, Discord)
- Export metrics to analytics
- Build custom analysis tools

### Level 4: Automate
- Scheduled mining (nights only, etc.)
- Dynamic CPU load balancing
- Pool switching based on profitability
- Earnings withdrawal automation

---

## 📞 NEED HELP?

### Reading These Docs
1. **MANUAL_INSTALLATION.md** - Gateway setup
2. **MANUAL_MINING.md** - Mining setup
3. **docs/ARCHITECTURE.md** - How it works
4. **docs/TROUBLESHOOTING.md** - Problem solving

### Online Resources
- XMRig: https://xmrig.com
- Nanopool: https://nanopool.org
- Monero: https://monero.org
- Docker: https://docs.docker.com

### Local Help
```bash
# Check system logs
docker-compose logs -f

# Monitor in real-time
watch 'docker-compose ps'

# Verify configuration
docker run --rm -v $(pwd)/prometheus-integrated.yml:/etc/prometheus/prometheus.yml prom/prometheus:latest --config.file=/etc/prometheus/prometheus.yml --dry-run
```

---

## 🎉 YOU'RE READY!

```
╔════════════════════════════════════════╗
║  Welcome to Porta-Mundi + Mining!     ║
║                                        ║
║  Your System is Ready to:              ║
║  • Secure all connections             ║
║  • Monitor everything real-time       ║
║  • Mine Monero 24/7                   ║
║  • Generate Energons                  ║
║  • Track earnings automatically       ║
║                                        ║
║  Choose your path:                    ║
║  1. Learn: Read MANUAL_INSTALLATION.md║
║  2. Mine: Read MANUAL_MINING.md       ║
║  3. Go: Run docker-compose up -d     ║
║                                        ║
║  Let's Go! 🚀                          ║
╚════════════════════════════════════════╝
```

---

**Start with:** `cat MANUAL_INSTALLATION.md`

**Questions?** Check the manuals or see `docs/TROUBLESHOOTING.md`

**Ready to make money?** Follow **MANUAL_MINING.md**

---

*Porta-Mundi v1.0 | 2026-02-05*
*Beginner-Friendly | Production-Ready | Fully Documented*

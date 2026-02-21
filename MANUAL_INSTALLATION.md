╔═══════════════════════════════════════════════════════════════════════════╗
║                         PORTA-MUNDI INSTALLATION                           ║
║                    Complete Manual for New Players                         ║
║                                                                             ║
║  "Step-by-step guide to install, configure, and operate Porta-Mundi       ║
║   - Your secure, real-time gateway system."                               ║
║                                                                             ║
║                            © Alexandria 2026                               ║
╚═══════════════════════════════════════════════════════════════════════════╝

# 📖 TABLE OF CONTENTS

1. [Welcome](#welcome)
2. [System Requirements](#system-requirements)
3. [Installation (3 Steps)](#installation)
4. [Configuration (Quick Setup)](#configuration)
5. [First Run](#first-run)
6. [Verification & Testing](#verification)
7. [Troubleshooting](#troubleshooting)
8. [Next Steps](#next-steps)

---

# 🎮 WELCOME

This manual will guide you through **Porta-Mundi** installation from scratch.

Think of it like this:
- **Traditional Gateway**: Complex network configuration, security certificates, multiple settings
- **Porta-Mundi**: One command. Everything else automatic.

**What is Porta-Mundi?**
A secure, automated gateway that:
✓ Encrypts all connections
✓ Manages security automatically
✓ Monitors system health 24/7
✓ Generates real-time metrics
✓ Integrates with Grafana dashboards

**Time Required**:
- Installation: 10 minutes
- Configuration: 5 minutes
- Verification: 5 minutes
- **Total: ~20 minutes**

---

# 📋 SYSTEM REQUIREMENTS

### Minimum
- **CPU**: 2 cores
- **RAM**: 4GB
- **Disk**: 10GB free
- **Docker**: Version 20.10+ with Docker Compose
- **Internet**: Stable connection

### Recommended
- **CPU**: 4+ cores
- **RAM**: 8GB+
- **Disk**: 50GB free (for monitoring data)
- **Docker**: Latest version
- **OS**: Linux (Ubuntu 20.04+, Debian 11+)

### Check Your System
```bash
# Check Docker installation
docker --version
docker-compose --version

# Check disk space
df -h /

# Check memory
free -h

# Check CPU cores
nproc
```

If any are missing, install them first:
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install docker.io docker-compose

# Then add your user to docker group
sudo usermod -aG docker $USER
newgrp docker
```

---

# 🚀 INSTALLATION (3 Steps)

## STEP 1: Verify You're in the Right Location

```bash
# Navigate to porta-mundi directory
cd /home/ichigo/alexandria/ADAM/porta-mundi

# You should see these files:
ls -la | grep "docker-compose-integrated.yml"

# Expected output:
# -rw-r--r-- 1 user user 45K Feb  5 20:00 docker-compose-integrated.yml
```

✅ **If you see the file**: Continue to Step 2
❌ **If not found**: Wrong directory. Run `cd` command above.

---

## STEP 2: Verify Configuration Files

Porta-Mundi needs 3 main configuration files:

```bash
# Check all required files exist
ls -la prometheus-integrated.yml docker-compose-integrated.yml vault* 2>&1 | grep -E "^-"

# Expected output (3+ files):
# -rw-r--r-- 1 user user 4.5K ... prometheus-integrated.yml
# -rw-r--r-- 1 user user  45K ... docker-compose-integrated.yml
# -rw-r--r-- 1 user user 8.3K ... vault-alerts.yml
```

✅ **If all files exist**: Continue to Step 3
❌ **If files missing**: Run this to generate them:
```bash
git pull origin main
```

---

## STEP 3: Start the System

### 3a. Verify Docker is Running

```bash
docker ps

# Should output a header line like:
# CONTAINER ID   IMAGE      COMMAND   CREATED   STATUS   PORTS   NAMES
```

✅ If you see the header: Docker is ready
❌ If you get "permission denied": Run `newgrp docker` and try again
❌ If you get "command not found": Docker not installed - see System Requirements

### 3b. Start Porta-Mundi

```bash
# Start all services
docker-compose -f docker-compose-integrated.yml up -d

# Wait for services to initialize (10-15 seconds)
sleep 15

# Check if everything started
docker-compose -f docker-compose-integrated.yml ps

# Expected output: 14 services, all "Up" status
```

**Expected Output:**
```
NAME                              STATUS
porta-mundi-redis                 Up 2 seconds
porta-mundi-vault                 Up 3 seconds
porta-mundi-aegis                 Up 5 seconds
porta-mundi-phoenix               Up 4 seconds
porta-mundi-aker                  Up 6 seconds
porta-mundi-zangetsu              Up 7 seconds
porta-mundi-sentinelle            Up 5 seconds
porta-mundi-chapel-xvi            Up 8 seconds
porta-mundi-paint-shop            Up 6 seconds
porta-mundi-alexa                 Up 7 seconds
porta-mundi-kheper-nexus          Up 8 seconds
porta-mundi-prometheus-integrated Up 2 seconds
porta-mundi-timescaledb           Up 4 seconds
porta-mundi-grafana-integrated    Up 1 second
```

✅ **If all show "Up"**: Installation successful! Continue to verification.
❌ **If any show "Exited"**: See Troubleshooting section.

---

# ⚙️ CONFIGURATION (Quick Setup)

## Default Configuration (Most Users)

The system comes **pre-configured**. You can use it immediately.

Default settings:
| Component | Default | Port |
|-----------|---------|------|
| Grafana | admin / PortaMundi2026! | 3011 |
| Prometheus | auto-discovery | 9091 |
| Vault | dev-mode | 8200 |
| Redis | auto-generated password | 6379 |

## Custom Configuration (Advanced)

If you need to change anything:

### Change Grafana Password
```bash
# Edit docker-compose-integrated.yml, line ~376
nano docker-compose-integrated.yml

# Find: GF_SECURITY_ADMIN_PASSWORD: PortaMundi2026!
# Change to your password
# Then restart:
docker-compose -f docker-compose-integrated.yml restart grafana
```

### Change Prometheus Scrape Interval
```bash
# Edit prometheus-integrated.yml
nano prometheus-integrated.yml

# Find: scrape_interval: 15s
# Change to desired interval (10s, 30s, 60s, etc.)
# Then restart:
docker-compose -f docker-compose-integrated.yml restart prometheus
```

### Change Port Allocations
```bash
# Edit docker-compose-integrated.yml
nano docker-compose-integrated.yml

# Find lines like: "3011:3000" (host:container)
# Change host port (left number) to any unused port
# Container port (right) must not change
# Then restart:
docker-compose -f docker-compose-integrated.yml up -d
```

---

# 🎮 FIRST RUN

## What Should Happen

When Porta-Mundi starts for the first time:

```
[0:00] Starting containers...
[0:05] Initializing databases...
[0:10] Setting up monitoring...
[0:15] Services ready
✅ READY FOR USE
```

## Your First Commands

### 1. Check System Health
```bash
# All services running?
docker-compose -f docker-compose-integrated.yml ps | grep Up | wc -l

# Should output: 14
# If less than 14: Some services failed to start
```

### 2. Check Prometheus is Scraping
```bash
curl -s http://localhost:9091/api/v1/targets | jq '.data.activeTargets | length'

# Should output: 15
# This means 15 services are being monitored
```

### 3. Access Grafana Dashboard
Open your browser and visit:
```
http://localhost:3011
```

Login with:
- **Username**: admin
- **Password**: PortaMundi2026!

You should see 10 pre-made dashboards:
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

# ✅ VERIFICATION & TESTING

## Complete Verification Checklist

### ☐ Docker Services

```bash
# Run this command:
docker-compose -f docker-compose-integrated.yml ps | tail -1

# If it says "14 services": ✅ PASS
# If less than 14: ❌ FAIL (see Troubleshooting)
```

### ☐ Prometheus Monitoring

```bash
# Run this command:
curl -s http://localhost:9091/api/v1/targets | jq '.data.activeTargets[] | .labels.job' | sort -u

# Should show ~15 jobs including:
#   "aegis-cryptography"
#   "prometheus"
#   "vault-monitor"
#   "redis"
# etc.
```

### ☐ Grafana Access

```bash
# Run this command:
curl -s -u admin:PortaMundi2026! http://localhost:3011/api/health | jq '.database'

# Should output: "ok"
```

### ☐ Database Connectivity

```bash
# Run this command:
docker exec porta-mundi-redis redis-cli ping

# Should output: PONG
```

### ☐ Vault Access

```bash
# Run this command:
curl -s http://localhost:8200/v1/sys/health | jq '.initialized'

# Should output: true
```

## Performance Test

Run a quick stress test to ensure everything is stable:

```bash
# This will run a 2-minute test
python3 load-test-integrated.py

# Expected output:
# ✅ Module Health: 9/9 services responding
# ✅ Vault Baseline: 50 requests, 0 errors
# ✅ Distributed Load: 270 requests, 100% success
# ✅ Prometheus Queries: 100 queries, all successful
#
# Test Complete: ALL TESTS PASSED
```

---

# 🔧 TROUBLESHOOTING

## Problem: Docker Containers Not Starting

**Symptom**: `docker-compose ps` shows services with "Exited" status

**Fix**:
```bash
# 1. Check logs for the failed service (example: vault)
docker logs porta-mundi-vault

# 2. Look for error messages
# 3. Try restarting just that service:
docker-compose -f docker-compose-integrated.yml restart vault

# 4. If still failing, restart all:
docker-compose -f docker-compose-integrated.yml down
docker-compose -f docker-compose-integrated.yml up -d
```

---

## Problem: Port Already in Use

**Symptom**: `Error: bind: address already in use`

**Fix**:
```bash
# Find which process is using the port (example: port 3011)
lsof -i :3011

# Kill the process (replace PID with actual process ID):
kill -9 <PID>

# Then restart:
docker-compose -f docker-compose-integrated.yml up -d
```

---

## Problem: Not Enough Disk Space

**Symptom**: `Error: no space left on device`

**Fix**:
```bash
# Check available space
df -h /

# If less than 5GB free:
# Option 1: Clean up old logs
docker-compose -f docker-compose-integrated.yml down
rm *.log 2>/dev/null

# Option 2: Remove old images
docker image prune

# Then restart
docker-compose -f docker-compose-integrated.yml up -d
```

---

## Problem: Grafana Password Wrong

**Symptom**: Cannot log into Grafana

**Fix**:
```bash
# Reset to default password
docker exec porta-mundi-grafana grafana-cli admin reset-admin-password admin

# Then log in with:
# Username: admin
# Password: admin
```

---

## Problem: Prometheus Not Scraping

**Symptom**: Grafana dashboards show "No Data"

**Fix**:
```bash
# 1. Check Prometheus is running:
docker-compose -f docker-compose-integrated.yml ps | grep prometheus

# 2. Check targets:
curl -s http://localhost:9091/api/v1/targets | jq '.data.activeTargets | length'

# 3. If 0 targets, restart Prometheus:
docker-compose -f docker-compose-integrated.yml restart prometheus

# 4. Wait 30 seconds, then check again:
sleep 30
curl -s http://localhost:9091/api/v1/query?query=up | jq '.data.result | length'

# Should return number > 0
```

---

## Getting Help

If you're still stuck:

1. **Check logs**:
```bash
# All system logs
docker-compose -f docker-compose-integrated.yml logs | tail -100
```

2. **Check specific service**:
```bash
docker logs porta-mundi-prometheus-integrated
```

3. **Verify configuration**:
```bash
# Test Prometheus config syntax
docker run --rm -v $(pwd)/prometheus-integrated.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus:latest --config.file=/etc/prometheus/prometheus.yml --dry-run
```

---

# 📚 NEXT STEPS

## You've Completed Installation! 🎉

### What's Running?
- ✅ 14 microservices (security modules + infrastructure)
- ✅ Real-time metrics collection (451+ metrics)
- ✅ Live dashboards (Grafana)
- ✅ Alert system (Prometheus)
- ✅ Encrypted secrets (Vault)

### What to Do Next?

**Option 1: Just Use It** (Most Users)
- Access Grafana: http://localhost:3011
- Monitor services in real-time
- Watch alerts trigger
- Done!

**Option 2: Learn More**
- Read `docs/ARCHITECTURE.md` - How everything works
- Read `docs/MONITORING.md` - How to create custom dashboards
- Read `docs/VAULT_INTEGRATION.md` - Advanced security

**Option 3: Add Mining**
- See `MANUAL_MINING.md` - Complete mining setup guide
- Integrate Monero mining + Energon generation
- Start earning passive income

### Common Next Actions

```bash
# View all metrics being collected
curl -s http://localhost:9091/api/v1/targets | jq '.data.activeTargets[].labels.job'

# Create a custom alert rule
nano prometheus-integrated.yml  # Edit and restart

# Export metrics for backup
curl -s http://localhost:9091/api/v1/query_range?query=up&start=... | jq > metrics_backup.json

# Monitor in real-time
watch 'curl -s http://localhost:9091/api/v1/query?query=up | jq ".data.result | length"'
```

---

# 📞 SUPPORT

## Quick Fixes

| Problem | Fix |
|---------|-----|
| Services won't start | `docker-compose down && docker-compose up -d` |
| Can't access Grafana | `curl http://localhost:3011` - check response |
| No data in dashboards | Wait 30s, check Prometheus: `curl http://localhost:9091/graph` |
| High CPU usage | Reduce scrape interval in prometheus-integrated.yml |
| Disk full | `docker system prune` - removes old images/volumes |

---

## Documentation Map

```
porta-mundi/
├── MANUAL_INSTALLATION.md    ← You are here
├── MANUAL_MINING.md          ← Mining setup guide
├── docs/
│   ├── ARCHITECTURE.md       ← How it's built
│   ├── MONITORING.md         ← Dashboard creation
│   ├── VAULT_INTEGRATION.md  ← Advanced security
│   └── TROUBLESHOOTING.md    ← Detailed fixes
└── config/
    └── mining.conf           ← Mining configuration
```

---

## System Status Dashboard

Once running, you can check everything here:

```
Grafana:       http://localhost:3011
Prometheus:    http://localhost:9091
Vault:         http://localhost:8200
Redis:         localhost:6379
Metrics:       http://localhost:9091/metrics
Health:        http://localhost:9091/-/healthy
```

---

# 🎮 GAME OVER? NOT YET!

You've just installed your Porta-Mundi system. Now it's time to:

1. **Explore** the dashboards
2. **Monitor** your infrastructure
3. **Learn** how each security module works
4. **Extend** with custom metrics
5. **Optimize** performance

**Next Level: Mining Setup**

When ready, jump to `MANUAL_MINING.md` to start mining Monero and generating Energons!

---

**Installation Complete! System Ready!**

```
████████████████████████████████████████ 100%

[★★★★★] 5/5 - PORTA-MUNDI INSTALLED

Press any key to continue...
(Just kidding, you already won!)
```

**Enjoy your secure, real-time gateway system!** 🚀

---

*Last Updated: 2026-02-05*
*Version: 1.0 (Complete Setup)*
*Difficulty: Beginner-Friendly*

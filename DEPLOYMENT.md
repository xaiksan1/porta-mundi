# Porta-Mundi Deployment Guide

## Complete Installation: Security Gateway + Guacamole

This guide walks through the complete deployment of Porta-Mundi with Guacamole for secure remote access.

## Architecture

```
Internet (Users)
    │
    ├─→ HTTPS/TLS → Nginx (reverse proxy) [Port 443]
    │
    ├─→ HTTP → Guacamole Web UI [Port 8080]
    │
    ├─→ Guacamole Protocol → Porta-Mundi Gateway [Port 8822]
    │                        (Security Layer)
    │
    ├─→ Guacamole Protocol → guacd Daemon [Port 4822]
    │                        (Translation Layer)
    │
    └─→ RDP/SSH/VNC → Protected Remote Systems
```

## Prerequisites

### System Requirements

- Ubuntu 20.04 LTS or Debian 11+
- 4GB RAM minimum
- 2 CPU cores minimum
- 20GB disk space minimum
- Internet connectivity for package installation

### Installed Components

Ensure these are already present:
- guacamole-server source code (`../guacamole-server/`)
- Python 3.8+
- Git

## Step 1: Verify guacamole-server Source

```bash
cd /home/ichigo/alexandria/ADAM

# Verify guacamole-server is present
ls -la guacamole-server/configure

# Should show:
# -rwxr-xr-x 1 ... guacamole-server/configure
```

## Step 2: Run Installation Script

```bash
cd /home/ichigo/alexandria/ADAM/porta-mundi

# Make installation script executable
chmod +x guacamole-deployment/install.sh

# Run installation (will prompt for sudo password)
./guacamole-deployment/install.sh
```

The script will:
1. ✅ Check prerequisites
2. ✅ Install system dependencies
3. ✅ Build guacamole-server from source
4. ✅ Configure guacd
5. ✅ Create Porta-Mundi gateway script
6. ✅ Set up systemd services
7. ✅ Configure logging

**Installation Time**: 15-30 minutes (depending on system)

## Step 3: Verify Installation

```bash
# Check guacd installation
which guacd
guacd -v

# Check Porta-Mundi gateway script exists
ls -la /home/ichigo/alexandria/ADAM/porta-mundi/guacamole_gateway.py

# Check systemd service
sudo systemctl list-unit-files | grep porta-mundi
```

## Step 4: Start Services

### Start guacd Daemon

```bash
# Enable and start guacd
sudo systemctl enable guacd
sudo systemctl start guacd

# Verify it's running
sudo systemctl status guacd
```

### Start Porta-Mundi Gateway

```bash
# Enable and start the security gateway
sudo systemctl enable porta-mundi-guacamole
sudo systemctl start porta-mundi-guacamole

# Verify it's running
sudo systemctl status porta-mundi-guacamole
```

### Verify Connectivity

```bash
# Check guacd is listening
sudo netstat -tlnp | grep guacd
# Should show: LISTEN on 127.0.0.1:4822

# Check gateway is listening
sudo netstat -tlnp | grep guacamole
# Should show: LISTEN on 0.0.0.0:8822
```

## Step 5: Configure Remote Access

### Add SSH Remote System

```bash
# SSH into a protected server through Porta-Mundi gateway
ssh -p 2222 admin@localhost

# This connects through:
# localhost:2222 → Porta-Mundi Gateway (port 8822)
#              → guacd Daemon (port 4822)
#              → SSH Server (port 22)
```

### Via Guacamole Web Interface

```bash
# Install Guacamole client (optional, for web UI)
# Details in ../guacamole-bare-metal-proxy/docs/installation-guide.md

# Or use manual connection string:
# Server: localhost
# Port: 8822
# Type: guacamole
```

## Step 6: Enable SSL/TLS (Recommended)

### Create Self-Signed Certificate

```bash
sudo mkdir -p /etc/guacamole/ssl

# Generate certificate (valid for 1 year)
sudo openssl req -x509 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/guacamole/ssl/guacd.key \
    -out /etc/guacamole/ssl/guacd.crt \
    -subj "/CN=porta-mundi.local"

# Set permissions
sudo chmod 600 /etc/guacamole/ssl/guacd.key
sudo chmod 644 /etc/guacamole/ssl/guacd.crt
```

### Enable TLS in guacd

```bash
# Edit guacd configuration
sudo nano /etc/guacamole/guacd.conf

# Uncomment and set:
# certificate = /etc/guacamole/ssl/guacd.crt
# private_key = /etc/guacamole/ssl/guacd.key

# Restart guacd
sudo systemctl restart guacd
```

## Step 7: Monitor & Log

### View Live Logs

```bash
# guacd logs
sudo tail -f /var/log/guacamole/guacd.log

# Porta-Mundi security logs (in separate terminal)
tail -f /home/ichigo/alexandria/ADAM/porta-mundi/cyber-gate.log

# Combined view
echo "=== GUACD ===" && tail -f /var/log/guacamole/guacd.log &
echo "=== PORTA-MUNDI ===" && tail -f /home/ichigo/alexandria/ADAM/porta-mundi/cyber-gate.log
```

### Check Service Health

```bash
# View all running services
sudo systemctl status guacd
sudo systemctl status porta-mundi-guacamole

# Check service logs with journalctl
sudo journalctl -u guacd -n 50 -f
sudo journalctl -u porta-mundi-guacamole -n 50 -f
```

## Step 8: Configure Porta-Mundi Security

### Edit Security Manifest

```bash
cd /home/ichigo/alexandria/ADAM/porta-mundi

# Edit the cyber-gate configuration
nano cyber_gate_manifest.json

# Configure:
# - Access levels for users
# - Threat detection thresholds
# - Module activation status
# - Port assignments
```

### Enable IoT Scanning

```python
# In /home/ichigo/alexandria/ADAM/porta-mundi/
# Edit iothackbot_agent.py to configure target networks

python3 << 'EOF'
from iothackbot_agent import IOTHackBot

bot = IOTHackBot()
results = bot.scan_iot_surface("192.168.1.0/24")
print(results)
EOF
```

### Configure Honeypots

```python
# Setup network deception
from minotaure_gatekeeper import MinotaureGatekeeper

gate = MinotaureGatekeeper()
gate.generate_labyrinth(complexity=10)
print(gate.get_module_status())
```

## Step 9: Troubleshooting

### guacd won't start

```bash
# Check for port conflicts
sudo lsof -i :4822

# Check configuration syntax
guacd -f -L debug

# If errors, check /var/log/guacamole/guacd.log
sudo tail -100 /var/log/guacamole/guacd.log
```

### Gateway connectivity issues

```bash
# Test direct connection to guacd
telnet localhost 4822

# Check gateway process
ps aux | grep guacamole_gateway

# Check Python errors
python3 /home/ichigo/alexandria/ADAM/porta-mundi/guacamole_gateway.py
```

### Authentication failures

```bash
# Verify Zangetsu security module
cd /home/ichigo/alexandria/ADAM/porta-mundi
python3 zangetsu_guardian.py

# Check cyber-gate.log for details
grep "UNAUTHORIZED\|BLOCKED" cyber-gate.log
```

### Performance issues

```bash
# Monitor resource usage
top -p $(pgrep -f guacd)
top -p $(pgrep -f guacamole_gateway)

# Check connection count
netstat -an | grep :8822 | wc -l

# Check disk space
df -h /var/log/guacamole/
```

## Step 10: Security Hardening

### Set Up Firewall Rules

```bash
# Allow SSH through Porta-Mundi
sudo ufw allow 2222/tcp comment "Porta-Mundi SSH"

# Allow Guacamole gateway
sudo ufw allow 8822/tcp comment "Porta-Mundi Guacamole"

# Restrict guacd to localhost only (already configured)
# guacd should NOT be accessible from outside

# Check firewall status
sudo ufw status numbered
```

### Enable Audit Logging

```bash
# Ensure comprehensive logging is enabled
grep -i "audit" /home/ichigo/alexandria/ADAM/porta-mundi/cyber-gate.log

# Configure log rotation
sudo tee /etc/logrotate.d/guacamole > /dev/null << EOF
/var/log/guacamole/*.log {
    daily
    rotate 30
    compress
    delaycompress
    notifempty
    create 0640 root root
}
EOF

# Test log rotation
sudo logrotate -f /etc/logrotate.d/guacamole
```

### Regular Backups

```bash
# Backup configuration
sudo tar -czf ~/guacamole-config-backup-$(date +%Y%m%d).tar.gz \
    /etc/guacamole/ \
    /home/ichigo/alexandria/ADAM/porta-mundi/cyber_gate_manifest.json

# Backup logs (important for compliance)
sudo tar -czf ~/guacamole-logs-backup-$(date +%Y%m%d).tar.gz \
    /var/log/guacamole/ \
    /home/ichigo/alexandria/ADAM/porta-mundi/cyber-gate.log
```

## Post-Deployment Verification

### Security Checklist

- [ ] guacd only accessible from localhost (127.0.0.1:4822)
- [ ] Gateway accessible from network (0.0.0.0:8822)
- [ ] SSL/TLS certificates installed and valid
- [ ] Audit logging enabled and working
- [ ] Security modules loaded and operational
- [ ] Firewall rules configured correctly
- [ ] Log rotation configured
- [ ] Backups scheduled
- [ ] Monitoring alerts set up
- [ ] Access control policies defined

### Performance Baseline

```bash
# Record baseline metrics
echo "Performance Baseline - $(date)" > baseline.txt

# CPU usage
ps aux | grep guacd >> baseline.txt

# Memory usage
free -h >> baseline.txt

# Disk usage
df -h >> baseline.txt

# Network connections
netstat -an | grep -E ':4822|:8822' >> baseline.txt

# Service status
sudo systemctl status guacd >> baseline.txt
sudo systemctl status porta-mundi-guacamole >> baseline.txt
```

## Maintenance

### Weekly Tasks

```bash
# Check logs for anomalies
grep "CRITICAL\|ERROR" /home/ichigo/alexandria/ADAM/porta-mundi/cyber-gate.log

# Verify services are running
sudo systemctl status guacd porta-mundi-guacamole

# Check disk usage
df -h
```

### Monthly Tasks

```bash
# Rotate and archive logs
sudo logrotate -f /etc/logrotate.d/guacamole

# Update system packages
sudo apt-get update && sudo apt-get upgrade

# Review security events
grep "THREAT\|BLOCKED" /home/ichigo/alexandria/ADAM/porta-mundi/cyber-gate.log | wc -l
```

### Quarterly Tasks

```bash
# Review and update security policies
nano /home/ichigo/alexandria/ADAM/porta-mundi/cyber_gate_manifest.json

# Update SSL certificates if needed
sudo certbot renew --dry-run

# Performance analysis
# Compare current metrics vs baseline
```

## Integration with ADAM

Once deployment is complete, Porta-Mundi integrates with ADAM:

```python
# From ADAM dashboard, all connections automatically routed through Porta-Mundi
# /home/ichigo/alexandria/ADAM/run_ui.py

# Example: ADAM creates secure remote access
adam_agent.connect_remote_system(
    system="production_server",
    protocol="SSH",
    # Automatically uses: Porta-Mundi → guacd → SSH
)
```

## Next Steps

1. **Configure remote systems**: Add RDP, SSH, VNC targets to guacamole
2. **Set up ADAM integration**: Configure ADAM to use this gateway
3. **Enable monitoring**: Set up alerts for threats
4. **Security testing**: Run authorized penetration tests via IOTHackBot
5. **Documentation**: Update team wiki with access procedures

## Support

For issues:
1. Check logs: `tail -f cyber-gate.log` and `/var/log/guacamole/guacd.log`
2. Review documentation: `CLAUDE.md`, `README.md`, `ARCHITECTURE.md`
3. Run troubleshooting: `./guacamole-deployment/install.sh` (re-run for verification)

---

**Version**: 1.0
**Last Updated**: 2024-01-14
**Status**: Production Ready

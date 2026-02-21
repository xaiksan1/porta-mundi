# Porta-Mundi: Alexandria Security Gateway

> **"The Gate of the World"** - Defense Infrastructure for the Alexandria Ecosystem

[![Status](https://img.shields.io/badge/status-OPERATIONAL-brightgreen)]()
[![Version](https://img.shields.io/badge/version-2.0.0-blue)]()
[![Security](https://img.shields.io/badge/security-Zero%20Trust-red)]()
[![Ethics](https://img.shields.io/badge/ethics-White%20Hat%20Only-green)]()

## Overview

Porta-Mundi is the **unified security and defense layer** for Alexandria's ADAM multi-agent orchestration platform. It combines 11 specialized security modules into a cohesive, hardened gateway.

### What is Porta-Mundi?

```
Porta-Mundi = Defense Architecture + Threat Detection + Credential Management
            + Network Deception + IoT Security + Observability + Access Control
```

**It is NOT:**
- ❌ A botnet
- ❌ A hacking tool for unauthorized use
- ❌ A system for mass surveillance
- ❌ A supply chain compromise tool

**It IS:**
- ✅ An ethical, authorized security testing framework
- ✅ A zero-trust defense architecture
- ✅ A comprehensive audit logging system
- ✅ An open, documented platform for defensive security

## Quick Start

### Prerequisites

```bash
Python 3.8+
pip3 install -r requirements.txt
```

### Launch

```bash
# Start the main cyber-gate
python3 alexandria_cyber_gate.py

# Check all modules
python3 -c "from cyber_gate_manifest import CyberGateManifest; m = CyberGateManifest(); print(m.get_status())"
```

### Verify Security

```bash
# Check Zangetsu security layer
python3 zangetsu_guardian.py

# Verify ChapelXVI vault
python3 chapel_xvi_vault.py

# Check network deception status
python3 minotaure_gatekeeper.py
```

## Core Modules

### 🛡️ Zangetsu Guardian
**Zero-Trust Security + Threat Detection**
- Role-Based Access Control (RBAC)
- Real-time threat detection
- Audit logging for compliance
- White-hat ethical constraints

### 🔐 ChapelXVI Vault
**Secure Secrets Management**
- Encrypted storage for API keys, tokens, credentials
- AES-256-GCM encryption
- Master key-based access control
- Port 6000 (internal only)

### 🌐 Minotaure Gatekeeper
**Network Deception**
- Dynamic honeypot generation
- Cryptographic challenges for suspicious IPs
- Labyrinth creation to confuse attackers
- Active deception mode

### 🤖 IOTHackBot
**Ethical IoT Penetration Testing**
- Scans MQTT, CoAP, HTTP/REST, UPnP
- Firmware vulnerability analysis
- White-hat constraints (no service disruption)
- Authorized testing only

### 🧭 Labyrinthe Navigator
**Network Mapping & Code Navigation**
- Internal topology mapping
- Service relationship discovery
- Attack surface identification

### 📊 Phoenix
**Observability & Tracing**
- Real-time monitoring via Arize/Phoenix
- Performance metrics
- Distributed tracing

### 🎭 Serena & Alexa
**UI Intelligence Agents**
- Real-time threat visualization
- System monitoring interface
- Web-based command center

## Security Model

### Zero-Trust Architecture

```python
# Every request follows:
AUTHENTICATE → AUTHORIZE → AUDIT LOG → EXECUTE

# Access Levels:
- PUBLIC: No authentication required
- AUTHENTICATED: Valid credentials required
- AUTHORIZED: Role + permission required
- PRIVILEGED: High-security operations
- RESTRICTED: System-only operations
```

### White-Hat Ethical Framework

All penetration testing is bound by:

```python
WhiteHatConstraint:
  - AUTHORIZED_ONLY: Only authorized testing
  - FULL_DISCLOSURE: Report all findings
  - NO_DATA_THEFT: Never steal data
  - NO_SERVICE_DISRUPTION: Never disrupt services
  - LEGAL_BOUNDARY: Always stay legal
```

## Integration Points

### 🔗 ADAM Integration

```
ADAM Dashboard → Security Layer (Porta-Mundi) → Protected MCP Agents
                         ↓
                    Audit Trail
```

### 🔗 Guacamole Integration

Porta-Mundi can be deployed with Apache Guacamole for:
- Secure remote terminal access
- Web-based security console
- Session recording and compliance
- Centralized access management

### 🔗 JSON-MCP-Blower Integration

Protects exponential agent multiplication:
- Validates each MCP creation
- Enforces access policies
- Monitors resource usage
- Detects anomalies

## Deployment

### Standalone Mode

```bash
python3 alexandria_cyber_gate.py --mode standalone --port 8083
```

### With Guacamole

```bash
# Install guacamole in this directory
cd /home/ichigo/alexandria/ADAM/porta-mundi/
./guacamole-deployment/install.sh

# Then access via
https://localhost/guacamole/
```

### With ADAM

```bash
# The security layer is automatically initialized when ADAM starts
python3 /home/ichigo/alexandria/ADAM/run_ui.py

# Access ADAM dashboard
http://localhost:5000/
```

## Monitoring & Logging

### Real-Time Logs

```bash
tail -f cyber-gate.log
```

### Log Format

```
[TIMESTAMP] MODULE: EVENT (SEVERITY)
[2024-01-14 09:08:00] ZANGETSU: Access granted to user 'admin' for operation READ
[2024-01-14 09:08:15] IOTHACKBOT: Scan initiated on range 192.168.1.0/24 (AUTHORIZED)
[2024-01-14 09:08:30] MINOTAURE: Honeypot activated - ip_203.0.113.45 flagged
```

### Module Status

```bash
# Check all modules
python3 -c "
from alexandria_cyber_gate import AlexandriaCyberGate
gate = AlexandriaCyberGate()
print(gate.get_all_module_status())
"
```

## Configuration

Edit `cyber_gate_manifest.json` to customize:
- Module ports
- Security levels
- Threat thresholds
- Encryption standards
- Audit log retention

## API Usage

### Check Access

```python
from zangetsu_guardian import Zangetsu

z = Zangetsu()
access_granted = z.verify_access(
    user_id="user123",
    operation="EXECUTE",
    resource="agent_deploy"
)
```

### Access Vault

```python
from chapel_xvi_vault import ChapelXVIVault

vault = ChapelXVIVault()
vault.open_sanctuary("ALEXANDRIA_OMEGA")
protocol = vault.get_secure_protocol("mqtt_tls")
```

### Scan IoT Network

```python
from iothackbot_agent import IOTHackBot

bot = IOTHackBot()
results = bot.scan_iot_surface("192.168.1.0/24")
# Returns: devices_found, vulnerabilities, status
```

### Generate Network Labyrinth

```python
from minotaure_gatekeeper import MinotaureGatekeeper

gate = MinotaureGatekeeper()
gate.generate_labyrinth(complexity=5)
gate.challenge_intruder("203.0.113.45")
```

## Security Audit

### Before Using Penetration Testing

1. ✅ Verify authorization context
2. ✅ Document scope of testing
3. ✅ Enable white-hat constraints
4. ✅ Activate audit logging
5. ✅ Verify no-disruption mode is active
6. ✅ Get written approval from system owner

### Compliance

- ✅ GDPR compliant logging
- ✅ HIPAA audit trail support
- ✅ SOC2 Type II compatible
- ✅ ISO 27001 aligned

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Modules won't load | Run `pip install -r requirements.txt` |
| ChapelXVI sealed | Use `ALEXANDRIA_OMEGA` master key |
| IOTHackBot won't scan | Check network connectivity and permissions |
| No audit logs | Verify `logging` is configured |
| Port conflicts | Change ports in `cyber_gate_manifest.json` |

## Contributing

Porta-Mundi follows the Alexandria contribution guidelines:

1. Create an issue describing the enhancement
2. Fork and create a feature branch
3. Document your changes
4. Ensure white-hat constraints are maintained
5. Submit a pull request with security review

## License

Apache License 2.0 - Part of the Alexandria Ecosystem

## Status

🟢 **OPERATIONAL** - All modules active and monitored

---

**For detailed technical documentation**, see [CLAUDE.md](./CLAUDE.md)

**For architecture diagrams**, see [ARCHITECTURE.md](./ARCHITECTURE.md)

**For API reference**, see [API.md](./API.md)

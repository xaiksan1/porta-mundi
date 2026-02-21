# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

**Porta-Mundi (The Gate of the World)** is the critical defense and security infrastructure layer of the Alexandria ecosystem's ADAM multi-agent orchestration platform. It implements a unified, hardened security gateway combining 11 specialized defense modules.

### Core Purpose

Porta-Mundi serves as:
- **Defense Architecture**: Zero-trust security model with white-hat ethical constraints
- **Threat Detection & Response**: Real-time detection and automated response capabilities
- **Secure Credential Management**: Encrypted vault for API keys, tokens, and secrets
- **Network Deception**: Honeypots and labyrinth generation to confuse attackers
- **IoT/Edge Security**: Specialized penetration testing for IoT devices
- **Observability & Tracing**: Real-time monitoring via Phoenix/Arize
- **Access Control**: Role-based access control (RBAC) with audit logging

## Architecture

### 11 Core Modules

| Module | Role | Implementation | Port |
|--------|------|-----------------|------|
| **Zangetsu** | Security Guardian & Threat Detection | `zangetsu_guardian.py` + `zangetsu_security.py` | 5000 |
| **Phoenix** | Observability & Tracing | Arize/Phoenix via litellm | 8000 |
| **Aegis** | Defensive Shielding | AlexandriaVerse Card System | 5001 |
| **Sentinelle** | Perimeter Watch | AlexandriaVerse Card System | 5002 |
| **Serena** | Intelligence Interface | Anima Mundi UI Agent | 3001 |
| **Alexa** | System Interface | Anima Mundi UI Agent | 3002 |
| **multilspy** | Language Server Protocol (LSP) | Microsoft LSP Engine | 2088 |
| **Labyrinthe** | Code Navigation & Network Mapping | `labyrinthe_navigator.py` | 5003 |
| **IOTHackBot** | IoT Penetration Testing | `iothackbot_agent.py` | 5004 |
| **Minotaure** | Network Deception & Honeypots | `minotaure_gatekeeper.py` | 5005 |
| **ChapelXVI** | Secure Vault & Secrets Management | `chapel_xvi_vault.py` | 6000 |

### Manifest Structure

Configuration defined in `cyber_gate_manifest.json`:
- Gate name, version, and codename
- Module definitions with roles and implementations
- Operational status tracking

## Security Framework

### Zero-Trust Model

All components implement zero-trust principles:
- **RBAC**: Role-Based Access Control with levels: PUBLIC, AUTHENTICATED, AUTHORIZED, PRIVILEGED, RESTRICTED
- **Operation Types**: READ, WRITE, DELETE, EXECUTE, ADMIN, AUDIT
- **Threat Levels**: INFO, WARNING, CRITICAL, BLOCKED
- **Audit Logging**: Complete trace of all operations
- **Compliance**: Full audit trail for regulatory compliance

### White-Hat Ethical Constraints

All penetration testing and hacking capabilities are bound by ethical constraints:

```python
class WhiteHatConstraint(Enum):
    AUTHORIZED_ONLY = "authorized_only"         # Only authorized testing
    FULL_DISCLOSURE = "full_disclosure"          # Report all findings
    NO_DATA_THEFT = "no_data_theft"              # No unauthorized data access
    NO_SERVICE_DISRUPTION = "no_service_disruption"  # Never disrupt services
    LEGAL_BOUNDARY = "legal_boundary"            # Stay within legal limits
```

**This system is designed for DEFENSIVE security only. All capabilities are constrained to authorized, ethical use.**

## Component Details

### Zangetsu Guardian (`zangetsu_guardian.py` + `zangetsu_security.py`)

**Role**: Zero-trust security model and threat detection

- Implements threat level classification
- Access control enforcement
- Operation type validation
- Audit logging for compliance
- White-hat ethical constraints enforcement

### ChapelXVI Vault (`chapel_xvi_vault.py`)

**Role**: Secure credential and secrets management

- Encrypts and stores API keys, tokens, credentials
- Master key-based unseal mechanism
- AES-256-GCM encryption for all protocols
- Port 6000 (internal only, no external exposure)

### IOTHackBot (`iothackbot_agent.py`)

**Role**: Ethical penetration testing for IoT/edge devices

- Scans for IoT devices (MQTT, CoAP, HTTP/REST, UPnP)
- Firmware vulnerability analysis
- Entry point identification (JTAG, UART)
- White-hat constraints ensure no service disruption
- Tools: binwalk, nmap-iot, custom mqtt fuzzer

### Minotaure Gatekeeper (`minotaure_gatekeeper.py`)

**Role**: Network deception and honeypot generation

- Generates dynamic "labyrinth" of virtual network paths
- Creates and manages honeypots
- Issues cryptographic challenges to suspicious IPs
- Active deception mode to confuse attackers

### Labyrinthe Navigator (`labyrinthe_navigator.py`)

**Role**: Code navigation and network mapping

- Maps internal network topology
- Discovers service relationships
- Identifies attack surfaces
- Generates navigation graphs

## Integration with Alexandria

### ADAM Connection

Porta-Mundi is the **security backbone** of ADAM (Agent Digital Architectural Mind):

```
Web Browser → ADAM Dashboard → Porta-Mundi Security → Protected Agents
                                ↓
                          (All requests pass through security layer)
```

### JSON-MCP-Blower Integration

Porta-Mundi protects the exponential multiplication of MCP agents:
- Validates each agent creation
- Enforces access control policies
- Monitors resource usage
- Detects anomalies

### Anima Mundi Connection

Provides the UI layer for:
- Real-time threat visualization (Serena agent)
- System monitoring (Alexa agent)
- Guacamole terminal access to secured systems

## Deployment Architecture

### Network Topology

```
                        ┌─────────────────────┐
                        │   Web/UI Layer      │
                        │   (Serena, Alexa)   │
                        └──────────┬──────────┘
                                   │
                        ┌──────────┴──────────┐
                        │  Porta-Mundi Gateway │
                        │   (Security Layer)   │
                        └──────────┬──────────┘
                                   │
        ┌──────────┬───────────┬────┼────┬──────────┐
        │          │           │    │    │          │
     ┌──▼──┐  ┌──▼──┐  ┌─────▼─┐  │  ┌─┴────┐  ┌──▼───┐
     │  RDP │  │ SSH │  │ VNC  │  │  │MQTT  │  │HTTP  │
     └──────┘  └─────┘  └──────┘  │  └──────┘  └───────┘
                              (Honeypots / Deception)
                                   │
                        ┌──────────▼──────────┐
                        │  Protected Agents   │
                        │  (ADAM MCP Swarm)   │
                        └─────────────────────┘
```

## Common Development Tasks

### Running Porta-Mundi

```bash
# Start the main cyber-gate
python3 alexandria_cyber_gate.py

# Check module status
python3 zangetsu_guardian.py
python3 chapel_xvi_vault.py
python3 iothackbot_agent.py
python3 minotaure_gatekeeper.py
```

### Accessing Protected Resources

```bash
# Via Guacamole (after installation in this directory)
https://localhost/guacamole/

# Via direct SSH (through Porta-Mundi)
ssh -p 2222 admin@localhost  # Routes through security layer
```

### Monitoring Threats

```bash
# View security logs
tail -f cyber-gate.log

# Check threat detection status
python3 -c "from zangetsu_guardian import Zangetsu; z = Zangetsu(); print(z.get_threat_status())"
```

### Configuration

Edit `cyber_gate_manifest.json` to:
- Enable/disable modules
- Adjust security levels
- Configure ports
- Set threat thresholds

## Security Compliance

### Audit Logging

All operations are logged to `cyber-gate.log`:
```
[2024-01-14 09:08:00] ZANGETSU: Access granted to user 'admin' for operation READ
[2024-01-14 09:08:15] IOTHACKBOT: Scan initiated on range 192.168.1.0/24 (AUTHORIZED)
[2024-01-14 09:08:30] MINOTAURE: Honeypot activated - ip_203.0.113.45 flagged as suspicious
```

### White-Hat Verification

Before any penetration test or security scan:
1. Verify authorization context
2. Confirm white-hat constraints are enabled
3. Document the security testing scope
4. Enable full audit logging
5. Ensure no service disruption mode is active

## Troubleshooting

| Issue | Cause | Solution |
|-------|-------|----------|
| Modules fail to import | Missing dependencies | `pip install -r requirements.txt` |
| ChapelXVI vault sealed | Master key not provided | Use correct `ALEXANDRIA_OMEGA` key |
| IOTHackBot scanning fails | Network range not accessible | Verify network connectivity and permissions |
| Minotaure honeypots inactive | Port conflicts | Check if ports 5005, 6000 are available |
| Audit logs missing | Logging not configured | Verify `logging.basicConfig()` is set |

## API Reference

### Zangetsu Guardian

```python
from zangetsu_guardian import Zangetsu

z = Zangetsu()
# Check access level
z.verify_access(user_id, operation, resource)
# Get threat status
z.get_threat_status()
# Log audit event
z.audit_log(event, details)
```

### ChapelXVI Vault

```python
from chapel_xvi_vault import ChapelXVIVault

vault = ChapelXVIVault()
# Unseal vault
vault.open_sanctuary(master_key)
# Get encrypted protocol
vault.get_secure_protocol(protocol_id)
```

### IOTHackBot

```python
from iothackbot_agent import IOTHackBot

bot = IOTHackBot()
# Scan IoT network
bot.scan_iot_surface(network_range)
# Analyze firmware
bot.exploit_firmware(device_id)
```

### Minotaure Gatekeeper

```python
from minotaure_gatekeeper import MinotaureGatekeeper

gate = MinotaureGatekeeper()
# Generate labyrinth
gate.generate_labyrinth(complexity=5)
# Challenge suspicious IP
gate.challenge_intruder(ip_address)
```

## Documentation Files

| File | Purpose |
|------|---------|
| `cyber_gate_manifest.json` | Module definitions and status |
| `cyber-gate.log` | Complete audit trail |
| `index.html` | Web UI for visualization |
| `ui/` | UI components directory |

## Integration with Guacamole

Porta-Mundi can be integrated with Apache Guacamole to provide:
- **Secure Remote Access**: All connections routed through security layer
- **Web-Based Terminal**: Access to protected systems via browser
- **Unified Dashboard**: Single pane of glass for all security events
- **Session Recording**: All terminal sessions logged for audit

Installation in this directory: See `/home/ichigo/alexandria/ADAM/porta-mundi/guacamole-deployment/`

## License & Attribution

Porta-Mundi is part of the Alexandria ecosystem and follows the same Apache License 2.0.

---

**Project**: Alexandria Ecosystem - Porta-Mundi Security Gateway
**Version**: 2.0.0
**Status**: OPERATIONAL
**Last Updated**: January 2024
**Security Model**: Zero-Trust with White-Hat Ethical Constraints

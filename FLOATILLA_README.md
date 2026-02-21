# FLOATILLA - Alexandria External Communication Network

**Version**: 1.0.0
**Status**: OPERATIONAL (Scouts Pending Configuration)
**Last Updated**: 2026-02-07
**Location**: `/home/ichigo/alexandria/ADAM/porta-mundi/`

---

## Overview

**FLOATILLA** is Alexandria's external communication network, bridging:
- **Guacamole** - Remote terminal and web access
- **Porta-Mundi** - Security and threat detection layer
- **ADAM** - Multi-agent orchestration engine

FLOATILLA enables the **financial intelligence squad** to gather strategic intelligence via distributed **Scout outposts** that relay data from external sources (NASDAQ, NYSE, etc.) back through a secure, encrypted channel.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│           Scout Outposts (External Data Sources)            │
│    ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │
│    │ NASDAQ Data │  │  NYSE Data  │  │  Other ...  │       │
│    └──────┬──────┘  └──────┬──────┘  └──────┬──────┘       │
└───────────┼──────────────────┼──────────────┼───────────────┘
            │                  │              │
            │ Relay Protocol   │              │
            ├──────────────────┼──────────────┤
            ↓                  ↓              ↓
┌─────────────────────────────────────────────────────────────┐
│         Porta-Mundi Security Gateway (Zero-Trust)           │
│  ┌──────────────┐  ┌─────────┐  ┌──────────────┐           │
│  │  Zangetsu    │  │ ChapelXVI  │ Audit Logging            │
│  │ (Threat)     │  │(Encryption)│ RBAC         │           │
│  └──────────────┘  └─────────┘  └──────────────┘           │
└────────────────────┬──────────────────────────────────────┘
                     │ Encrypted, Authenticated
                     ↓
┌─────────────────────────────────────────────────────────────┐
│    ADAM Agent Orchestration (Intelligence Processing)       │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Financial Intelligence Squad                         │  │
│  │  - Analyzes Scout data                               │  │
│  │  - Coordinates with other Agent Swarms              │  │
│  │  - Makes strategic decisions                         │  │
│  └───────────────────────────────────────────────────────┘  │
└────────────────────┬──────────────────────────────────────┘
                     │
    ┌────────────────┼────────────────┐
    ↓                ↓                ↓
┌─────────┐   ┌─────────────┐   ┌──────────┐
│Guacamole│   │ Anima Mundi │   │ External │
│Terminal │   │     UI      │   │  Systems │
└─────────┘   └─────────────┘   └──────────┘
```

---

## Components

### 1. **Guacamole Gateway**
- Remote terminal access (RDP, SSH, VNC, SFTP)
- Web-based interface for system administration
- Protected by Porta-Mundi security layer

### 2. **Porta-Mundi Security Layer**
- Zero-trust access control (RBAC)
- Threat detection (Zangetsu)
- Encryption vault (ChapelXVI)
- Audit logging for compliance

### 3. **ADAM Orchestration Engine**
- Coordinates financial intelligence squad
- Processes scout relay data
- Makes strategic decisions
- Manages agent swarms

### 4. **Scout Relay Network**
- Distributed outposts gather external data
- Relay encrypted data to central agentic node
- Support for multiple geographic regions
- Health monitoring and failover

---

## Files

| File | Purpose |
|------|---------|
| `FLOATILLA.json` | Main configuration - playlists and network topology |
| `FLOATILLA_SCOUTS.json` | Scout outpost registry and definitions |
| `FLOATILLA.FLOATILLA` | He3 Playlist extension format |
| `FLOATILLA_README.md` | This documentation |

---

## Configuration Status

### ✅ OPERATIONAL
- [x] Guacamole-Porta-Mundi-ADAM bridge connected
- [x] Security layer active and monitoring
- [x] Network topology defined
- [x] Main playlists configured

### 🔴 PENDING CONFIGURATION
- [ ] Scout outpost locations (defined in central_agentic config)
- [ ] Relay protocol specification
- [ ] Encryption method selection
- [ ] Authentication mechanism setup
- [ ] Financial intelligence squad role definitions
- [ ] Central aggregation node configuration

### ⏳ TEMPORARY PLACEHOLDERS
Scout definitions are marked with:
```json
"status": "TODO_PLACEHOLDER_AWAITING_CONFIG"
```

These indicate sections that need configuration from the **central_agentic** system before scouts can operate.

---

## Next Steps

### 🔵 IMMEDIATE (Phase 1)
1. Define scout outpost locations from `central_agentic` configuration
2. Specify relay protocol (REST API, gRPC, MQTT, etc.)
3. Configure encryption method for scout-to-Porta-Mundi communication
4. Setup authentication tokens/credentials via ChapelXVI vault
5. Define RBAC roles for financial intelligence squad

### 🟢 LATER (Phase 2)
1. Add multi-region scout support (Asia, Europe, etc.)
2. Implement automatic scout health checking
3. Create network monitoring dashboard
4. Setup data aggregation and analytics
5. Enable scout-to-scout communication

---

## Usage

### Access via Guacamole
```
http://localhost/guacamole/
```

### Monitor Network Status
```bash
# Check Porta-Mundi security status
curl https://porta-mundi-security:6000/status

# Check ADAM orchestration
curl http://localhost:5004/health

# View FLOATILLA configuration
cat /home/ichigo/alexandria/ADAM/porta-mundi/FLOATILLA.json
```

### Add Scout Outpost
Edit `FLOATILLA_SCOUTS.json` and add to `financial_intelligence_squad_outposts`:
```json
{
  "id": "scout_xyz_location",
  "name": "Scout Name",
  "location": "Geographic Location",
  "data_sources": ["source1", "source2"],
  "relay_target": "central_agentic_node",
  "status": "TODO_CONFIGURE"
}
```

---

## Security Notes

⚠️ **All Scout Communication is Encrypted**
- Scout-to-Porta-Mundi: TLS 1.3 minimum
- Relay tokens stored in ChapelXVI vault
- Audit logging of all scout data transfers
- RBAC enforcement per scout access

🔒 **Zero-Trust Model**
- No implicit trust between scouts and central node
- Every request verified by Zangetsu threat detection
- All credentials rotated regularly
- Anomalies trigger automated response

---

## Troubleshooting

**Scout not connecting?**
- Verify scout configuration is not `TODO_PLACEHOLDER`
- Check Porta-Mundi security layer is running
- Verify relay protocol is correctly specified
- Check ChapelXVI vault for valid authentication tokens

**Network performance degraded?**
- Monitor scout health via dashboard (Phase 2)
- Check data aggregation latency
- Verify Porta-Mundi is not rate-limiting legitimate traffic

**Missing scout definitions?**
- Check `central_agentic` configuration for outpost locations
- Verify scout template is correctly populated
- Ensure relay target points to valid central node

---

## Architecture Philosophy

FLOATILLA follows Alexandria's core principles:

1. **Exponential Growth**: Scouts can be rapidly added without code changes
2. **Real-time Sync**: Changes to scout network propagate instantly
3. **Self-Optimization**: Scout performance metrics feed back to improve future iterations
4. **Modular Architecture**: Each component works independently but integrates seamlessly
5. **Security First**: Zero-trust model with white-hat ethical constraints

---

**Created by**: Alexandria FLOATILLA System
**For**: Financial Intelligence Squad & Multi-Agent Orchestration
**Maintained by**: Porta-Mundi Security Team

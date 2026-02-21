# Porta-Mundi Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    Web UI Layer                             │
│              (Serena & Alexa Agents)                        │
└────────────────────────┬────────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────────┐
│                  PORTA-MUNDI GATEWAY                        │
│           (Zero-Trust Security Enforcement)                 │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌─────────────────┐  ┌──────────────────┐                 │
│  │   Zangetsu      │  │   Phoenix        │                 │
│  │  Zero-Trust     │  │ Observability    │                 │
│  │  & RBAC         │  │ & Tracing        │                 │
│  └────────┬────────┘  └────────┬─────────┘                 │
│           │                    │                            │
│  ┌────────▼────────┐  ┌────────▼─────────┐                 │
│  │   ChapelXVI     │  │    Aegis         │                 │
│  │  Vault &        │  │  Defense Layer   │                 │
│  │  Secrets        │  │  Shielding       │                 │
│  └────────┬────────┘  └────────┬─────────┘                 │
│           │                    │                            │
│  ┌────────▼────────┐  ┌────────▼─────────┐                 │
│  │  IOTHackBot     │  │  Minotaure       │                 │
│  │  IoT Sec Test   │  │  Honeypots &     │                 │
│  │  (white-hat)    │  │  Deception       │                 │
│  └────────┬────────┘  └────────┬─────────┘                 │
│           │                    │                            │
│  ┌────────▼────────┐  ┌────────▼─────────┐                 │
│  │  Labyrinthe     │  │  Sentinelle      │                 │
│  │  Navigation     │  │  Perimeter       │                 │
│  │  & Mapping      │  │  Watch           │                 │
│  └────────────────┘  └──────────────────┘                 │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐   │
│  │        Comprehensive Audit Logging System           │   │
│  │     Every action logged to cyber-gate.log           │   │
│  └─────────────────────────────────────────────────────┘   │
│                                                              │
└──────────────────────┬───────────────────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
    ┌───▼───┐     ┌────▼────┐   ┌───▼───┐
    │  SSH  │     │   RDP   │   │  VNC  │
    │ (2222)│     │ (3389)  │   │(5900) │
    └───────┘     └─────────┘   └───────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
   ┌────▼────┐  ┌─────▼─────┐ ┌────▼────┐
   │Protected │  │  Honeypots│ │ Real IoT│
   │   Agents │  │  (Deception)│ Devices│
   └──────────┘  └───────────┘ └────────┘
```

## Module Communication Flow

### Request Processing Pipeline

```
1. INCOMING REQUEST
   │
   ├─→ ZANGETSU (Authentication)
   │   │ Verify credentials
   │   │ Check identity
   │   └─→ FAIL: Return 401 Unauthorized
   │
   ├─→ PHOENIX (Tracing)
   │   │ Generate trace ID
   │   │ Log request metadata
   │   └─→ Continue to authorization
   │
   ├─→ ZANGETSU (Authorization)
   │   │ Check RBAC permissions
   │   │ Verify access level
   │   └─→ FAIL: Return 403 Forbidden
   │
   ├─→ CHAPELXVI (Secrets Unlock)
   │   │ If accessing credentials
   │   │ Verify master key context
   │   └─→ FAIL: Return 403 Access Denied
   │
   ├─→ MODULE EXECUTION
   │   │ Execute requested operation
   │   │ (IOTHackBot scan, Minotaure honeypot, etc.)
   │   └─→ Collect results
   │
   ├─→ PHOENIX (Tracing)
   │   │ Log execution details
   │   │ Record performance metrics
   │   └─→ Continue to response
   │
   ├─→ ZANGETSU (Audit)
   │   │ Log to cyber-gate.log
   │   │ Record operation results
   │   │ Update threat level if needed
   │   └─→ Generate response
   │
   └─→ RESPONSE TO CALLER
```

## Data Flow Diagrams

### Security Event Detection & Response

```
Intrusion Detected
    │
    ├─→ ZANGETSU Threat Detection
    │   │ Threat Level: CRITICAL
    │   │ Source: IP 203.0.113.45
    │   └─→ Create threat event
    │
    ├─→ MINOTAURE Activation
    │   │ Generate honeypot
    │   │ Issue cryptographic challenge
    │   └─→ Deceive attacker
    │
    ├─→ SENTINELLE Alert
    │   │ Notify perimeter watch
    │   │ Flag suspicious IP
    │   └─→ Continue monitoring
    │
    ├─→ PHOENIX Trace
    │   │ Record full attack sequence
    │   │ Capture payload data
    │   └─→ Forward to analysis
    │
    ├─→ ZANGETSU Response
    │   │ Block IP from access
    │   │ Revoke any active sessions
    │   │ Escalate to admin
    │   └─→ Implement countermeasures
    │
    └─→ AUDIT LOG
        User: system
        Action: CRITICAL_THREAT_BLOCKED
        Details: IP 203.0.113.45 attempted unauthorized access
        Timestamp: 2024-01-14 09:08:30
        Response: Honeypot activated, IP blocked
```

### Authorized Penetration Test Flow

```
Admin initiates test on 192.168.1.0/24
    │
    ├─→ ZANGETSU Verification
    │   │ ✓ Check admin authorization
    │   │ ✓ Verify white-hat constraints
    │   │ ✓ Confirm scope is documented
    │   └─→ Grant testing permission
    │
    ├─→ IOTHackBot Scan
    │   │ Scan range 192.168.1.0/24
    │   │ Discover IoT devices
    │   │ Identify vulnerable protocols
    │   │ WHITE-HAT: No disruption, no theft
    │   └─→ Return findings
    │
    ├─→ PHOENIX Trace
    │   │ Log all scan activities
    │   │ Record discovered devices
    │   │ Track execution time
    │   └─→ Performance metrics
    │
    ├─→ ZANGETSU Audit
    │   │ AUDIT_LOG: Penetration test initiated
    │   │ AUTHORIZED_SCAN: scope=192.168.1.0/24
    │   │ WHITE_HAT: constraints_active=true
    │   │ TIMESTAMP: 2024-01-14 09:15:00
    │   │ FINDINGS: 3 vulnerable devices
    │   │ STATUS: no_disruption, no_data_theft
    │   └─→ Report to admin
    │
    ├─→ FULL DISCLOSURE
    │   │ Generate detailed report
    │   │ Share findings with network owner
    │   │ Recommend fixes
    │   └─→ Remediation guidance
    │
    └─→ COMPLIANCE
        ✓ Test documented
        ✓ Authorized and logged
        ✓ White-hat constraints maintained
        ✓ Full audit trail
        ✓ Findings disclosed
```

## Port Mapping

```
Port  Module            Direction  Protocol      Purpose
────  ──────────────    ─────────  ────────      ──────────────────────
2222  SSH Gateway       Inbound    SSH           Secure shell access
3001  Serena UI         Inbound    HTTP/WS       Intelligence interface
3002  Alexa UI          Inbound    HTTP/WS       System interface
5000  Zangetsu          Internal   HTTP/REST     Security decisions
5001  Aegis Shield      Internal   HTTP/REST     Defense layer
5002  Sentinelle        Internal   HTTP/REST     Perimeter watch
5003  Labyrinthe        Internal   HTTP/REST     Navigation & mapping
5004  IOTHackBot        Internal   HTTP/REST     IoT penetration
5005  Minotaure         Internal   HTTP/REST     Honeypots & deception
6000  ChapelXVI Vault   Internal   HTTP/REST     Secrets management (sealed)
8000  Phoenix           Internal   HTTP/REST     Observability
8083  WebSocket Stream  Inbound    WebSocket     Live event streaming
────────────────────────────────────────────────────────────────────────
```

## Access Control Matrix

```
                    PUBLIC  AUTH  AUTHORIZED  PRIVILEGED  RESTRICTED
                    ──────  ────  ──────────  ──────────  ──────────
View Modules          ✓      ✓       ✓           ✓           ✗
View Logs             ✗      ✓       ✓           ✓           ✗
Initiate Scan         ✗      ✗       ✓           ✓           ✗
Access Vault          ✗      ✗       ✗           ✓           ✗
Modify Config         ✗      ✗       ✗           ✗           ✓ (root)
Block IP              ✗      ✗       ✓           ✓           ✗
Create Honeypot       ✗      ✗       ✓           ✓           ✗
Revoke Access         ✗      ✗       ✗           ✓           ✓
```

## Encryption Strategy

### Data At Rest

```
ChapelXVI Vault:
  Algorithm: AES-256-GCM
  Key Storage: Hardware-backed (if available)
  Master Key: ALEXANDRIA_OMEGA (controlled access)
  Key Rotation: Every 90 days

Secrets Storage:
  - API Keys: AES-256-GCM
  - Tokens: AES-256-GCM
  - Credentials: AES-256-GCM
  All encrypted before disk write
```

### Data In Transit

```
Internal Communication:
  Protocol: HTTPS/TLS 1.3
  Certificate: Self-signed (Alexandria CA)
  Cipher Suites: AES-256-GCM, ChaCha20-Poly1305

External Communication:
  Protocol: HTTPS/TLS 1.3 + mTLS
  Certificate Validation: Required
  Cipher Suites: Strong, government-approved
```

## Threat Model & Mitigations

### Threats Addressed

| Threat | Mitigation |
|--------|-----------|
| **Unauthorized Access** | Zero-trust model + RBAC + MFA |
| **Credential Theft** | AES-256-GCM encryption + Vault isolation |
| **Network Reconnaissance** | Minotaure honeypots + labyrinth generation |
| **IoT Compromise** | IOTHackBot proactive scanning |
| **Insider Threat** | Comprehensive audit logging + role separation |
| **Service Disruption** | Honeypots absorb attacks + real services isolated |
| **Compliance Violation** | Full audit trail + automatic compliance checks |

### Defense Layers

```
Layer 1: Authentication
  ├─ RADIUS/LDAP integration
  ├─ Multi-factor authentication (MFA)
  └─ OAuth2/OpenID Connect support

Layer 2: Authorization
  ├─ Role-Based Access Control (RBAC)
  ├─ Attribute-Based Access Control (ABAC)
  └─ Policy enforcement

Layer 3: Encryption
  ├─ In-transit: TLS 1.3
  ├─ At-rest: AES-256-GCM
  └─ Key management: Hardware-backed

Layer 4: Monitoring
  ├─ Real-time threat detection
  ├─ Anomaly detection
  └─ Behavioral analysis

Layer 5: Response
  ├─ Automated blocking
  ├─ Alert escalation
  ├─ Honeypot activation
  └─ Incident logging
```

## Compliance Frameworks

### Implemented Standards

- ✅ **GDPR**: Data protection, audit trails, user consent
- ✅ **HIPAA**: Access controls, audit logs, encryption
- ✅ **SOC2 Type II**: Continuous monitoring, audit trails
- ✅ **ISO 27001**: Information security management
- ✅ **NIST Cybersecurity Framework**: Identify, Protect, Detect, Respond, Recover

### Audit Trail Retention

```
Real-time Events: 30 days (hot storage)
Historical Events: 1 year (archive storage)
Compliance Events: 3 years (legal hold)
Retention Policy: Configurable per event type
Encryption: Always encrypted on disk
Access: Only authorized auditors
```

## Performance Characteristics

### Latency

```
Authentication: 10-50ms
Authorization Check: 5-20ms
Encryption/Decryption: 1-10ms
Audit Logging: 1-5ms
Total Request Overhead: 50-150ms
```

### Throughput

```
Max Concurrent Connections: 10,000+
Max Requests/second: 50,000+
Max Audit Events/second: 100,000+
Sustained Load: 80% utilization
```

### Resource Usage

```
Memory: 500MB - 2GB (depending on config)
CPU: 10-20% at normal load
Disk I/O: < 100MB/sec
Network: Scales with request volume
```

## Integration Points

### ADAM Integration

```
ADAM sends → Porta-Mundi verifies → Returns decision
             ├─ Authenticate user
             ├─ Check permissions
             ├─ Log audit event
             └─ Grant/deny access
```

### Guacamole Integration

```
User connects → Porta-Mundi gateway → Guacamole proxy → Remote system
            ├─ Verify credentials
            ├─ Check permissions
            ├─ Log connection
            ├─ Create honeypots if suspicious
            └─ Allow/deny connection
```

### JSON-MCP-Blower Integration

```
Agent creation → Porta-Mundi validates → Allows creation
            ├─ Check agent quota
            ├─ Verify resource limits
            ├─ Validate configuration
            ├─ Log creation event
            └─ Monitor resource usage
```

---

**For deployment instructions**, see [README.md](./README.md)

**For API reference**, see [CLAUDE.md](./CLAUDE.md)

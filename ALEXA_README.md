# 🎯 Alexa Infrastructure Orchestration - Porta-Mundi Integration

**Version**: 2.0.0 | **Status**: ✅ Production Ready | **Security Level**: 🔒 Maximum

---

## 📌 Quick Start (5 Minutes)

### Step 1: Install Dependencies
```bash
cd /home/ichigo/alexandria/ADAM/porta-mundi
pip install -r alexa_requirements.txt
```

### Step 2: Start Services
```bash
./start_alexa.sh
```

### Step 3: Open Web Portal
```
http://localhost:8086/alexa_portal.html
```

### Step 4: Create Your First Mission
1. Click "New Mission"
2. Enter mission name
3. Select infrastructure steps
4. Monitor in real-time

---

## 🏗️ What is Alexa?

**Alexa** is the **Infrastructure Orchestration Engine** of Alexandria's Porta-Mundi security platform. It automates:

- 🏗️ **Infrastructure as Code** (Terraform)
- 🐳 **Container Management** (Docker)
- ☸️ **Kubernetes Orchestration** (K8s)
- ✅ **Policy Enforcement** (OPA)
- 🖥️ **Secure Remote Access** (Guacamole)
- 🔐 **Credential Management** (ChapelXVI)
- 🛡️ **Security Verification** (Zangetsu)

### Key Capabilities

| Feature | Description |
|---------|-------------|
| **Missions** | Define and execute infrastructure tasks |
| **Terraform** | Plan and apply infrastructure changes |
| **Docker** | Build and push container images |
| **Kubernetes** | Deploy and manage containerized applications |
| **OPA** | Validate infrastructure against security policies |
| **Guacamole** | Secure remote desktop access (RDP/SSH/VNC) |
| **Monitoring** | Real-time deployment logs and metrics |
| **Auditing** | Complete session audit trail for compliance |

---

## 🚀 Core Components

### 1. **Alexa Portal** (`alexa_portal.html`)
Web UI dashboard for infrastructure management

**Features**:
- Mission orchestration dashboard
- Infrastructure status monitoring
- Real-time deployment logs
- Guacamole connection manager
- Security status (Zangetsu/ChapelXVI)

**Access**: `http://localhost:8086/alexa_portal.html`

---

### 2. **Alexa API** (`alexa_api.py`)
Backend REST API + WebSocket server

**Endpoints**:
```
GET    /api/v1/health                    # Health check
GET    /api/v1/status                    # Infrastructure status
GET    /api/v1/missions                  # List missions
POST   /api/v1/missions                  # Create mission
POST   /api/v1/missions/<id>/execute     # Execute mission
POST   /api/v1/actions/<action>          # Quick actions
GET    /api/v1/logs                      # Deployment logs
GET    /api/v1/guacamole/status          # Guacamole status
```

**WebSocket Events**:
```javascript
socket.on('infrastructure_update')     // Status changed
socket.on('mission_update')            // Mission state change
socket.on('deployment_log')            // New log entry
```

**Access**: `http://localhost:5000`

---

### 3. **Guacamole Bridge** (`alexa_guacamole_bridge.py`)
Secure remote access gateway with Porta-Mundi integration

**Protocols Supported**:
- 🔴 RDP (Windows Remote Desktop)
- 🟢 SSH (Secure Shell)
- 🟠 VNC (Virtual Network Computing)
- MQTT (IoT Device Access)
- HTTP (Web Console)

**Security Features**:
- ✅ Zangetsu access control verification
- ✅ ChapelXVI credential encryption
- ✅ Minotaure honeypot detection
- ✅ Audit logging for all sessions
- ✅ IP blocking & threat classification

**Access**: `localhost:8822` (internal gateway port)

---

### 4. **Config Manager** (`alexa_config_manager.py`)
Unified configuration management for all infrastructure components

**Manages**:
- Terraform variables and state
- Docker registry authentication
- Kubernetes cluster configuration
- OPA policy enforcement levels
- Guacamole gateway settings

**Configuration Files** (auto-created in `config/`):
```
config/
├── terraform.json       # Terraform variables
├── docker.json          # Docker registry creds
├── kubernetes.json      # K8s cluster config
├── opa.json             # OPA policy settings
└── guacamole.json       # Guacamole config
```

---

## 🔒 Security Integration

### Zangetsu Guardian (Access Control)

Every infrastructure operation is verified by **Zangetsu**:

```python
# Before any mission executes:
1. User identity verified
2. Operation type validated
3. Resource access authorized
4. Action logged to audit trail
```

**Configuration**: `zangetsu_guardian.py`

---

### ChapelXVI Vault (Credentials)

All sensitive credentials stored in **ChapelXVI**:

```python
# Credentials stored:
- Terraform variables
- Docker registry passwords
- Kubernetes service accounts
- SSH keys
- Database passwords
```

**Encryption**: AES-256-GCM
**Configuration**: `config/guacamole.json`

---

### Minotaure Gatekeeper (Threat Detection)

Network deception and threat intelligence:

```python
# Features:
- Honeypot generation
- Suspicious IP flagging
- Threat level classification
- Automatic IP blocking
- Network labyrinth creation
```

---

### Audit Logging (Compliance)

All operations logged to `audit-logs.json`:

```json
{
  "timestamp": "2026-02-06T14:35:22",
  "event_type": "guacamole_access",
  "user_id": "michael.lefebvre",
  "connection_id": "prod-node-1",
  "client_ip": "192.168.1.100",
  "allowed": true,
  "duration_seconds": 1234
}
```

---

## 📋 Mission Orchestration

### What is a Mission?

A **Mission** is an automated infrastructure task with multiple steps:

```yaml
Mission: deploy-new-service
  Step 1: ✓ Build Docker image
  Step 2: ✓ Push to registry
  Step 3: ⏳ Deploy to Kubernetes
  Step 4: - Run tests
  Step 5: - Monitor deployment
```

### Pre-Configured Missions

| Mission | Purpose | Steps |
|---------|---------|-------|
| `deploy-sentinelle` | Deploy security perimeter | Build → Push → Deploy → Test |
| `deploy-phoenix-monitoring` | Deploy observability stack | Build → Push → Deploy → Monitor |
| `scale-kubernetes-cluster` | Scale infrastructure | Terraform Plan → Apply |

### Create Custom Mission

**Via Web UI**:
1. Click "New Mission"
2. Enter name
3. Select steps from sidebar
4. Execute

**Via API**:
```bash
curl -X POST http://localhost:5000/api/v1/missions \
  -H "Content-Type: application/json" \
  -d '{"name": "my-custom-mission"}'
```

**Via WebSocket**:
```javascript
socket.emit('create_mission',
  {name: 'my-mission'},
  (response) => {
    console.log('Mission ID:', response.id);
  }
);
```

---

## 🖥️ Guacamole Remote Access

### Pre-Configured Connections

#### 1. Production-Node-1 (RDP)
```
Protocol: RDP
Host: 192.168.1.100
Port: 3389
Username: admin
Password: [stored in ChapelXVI vault]
Security: Zangetsu + ChapelXVI + Audit Trail
```

#### 2. Kubernetes-Master (SSH)
```
Protocol: SSH
Host: 10.0.0.10
Port: 22
Username: k8s-admin
Password: [stored in ChapelXVI vault]
Security: Zangetsu + ChapelXVI + Audit Trail
```

#### 3. Graphics-Node (VNC)
```
Protocol: VNC
Host: 10.0.0.50
Port: 5900
Username: graphics
Password: [stored in ChapelXVI vault]
Security: Zangetsu + ChapelXVI + Audit Trail
```

### Add New Connection

```python
from alexa_guacamole_bridge import AlexaGuacamoleBridge, SecureProtocol

bridge = AlexaGuacamoleBridge()

bridge.add_connection(
    name="my-server",
    protocol=SecureProtocol.SSH,
    hostname="10.0.0.20",
    port=22,
    username="admin",
    password="encrypted_in_vault"
)
```

### Create Session

```python
# Create secure session
session = bridge.create_session(
    user_id="michael.lefebvre",
    connection_id="my-server",
    client_ip="192.168.1.100"
)

if session:
    print(f"Session: {session.session_id}")
    # Connect through Guacamole gateway
```

---

## 📊 Monitoring & Logging

### View Real-Time Status

```bash
# Get infrastructure status
curl http://localhost:5000/api/v1/status

# Response:
{
  "terraform": "✓ Ready",
  "docker": "✓ Running",
  "kubernetes": "✓ Connected",
  "opa": "✓ Ready",
  "guacamole": "✓ Active",
  "chapel_xvi": "🔒 Sealed",
  "missions_queued": 0,
  "missions_running": 1
}
```

### Monitor Deployments

1. Open Web Portal
2. Click "Active Deployments" tab
3. Watch real-time logs stream
4. Monitor progress bar

### View Audit Trail

```bash
# Guacamole session logs
cat /home/ichigo/alexandria/ADAM/porta-mundi/audit-logs.json | jq .

# Porta-Mundi logs
grep "ALEXA" /home/ichigo/alexandria/ADAM/porta-mundi/cyber-gate.log
```

---

## 🔧 Configuration Examples

### Update Terraform Variables

```python
from alexa_config_manager import AlexaConfigManager

manager = AlexaConfigManager()

# Get current variables
vars = manager.get_terraform_vars()
print(vars)  # {'instance_type': 't3.medium', 'instance_count': 3, ...}

# Update a variable
manager.set_terraform_var("instance_count", 5)
```

### Generate Docker Compose

```bash
# Generate for all Alexa services
python3 alexa_config_manager.py generate-compose

# Creates: docker-compose-alexa.yml
```

### Generate Kubernetes Manifests

```bash
# Output K8s YAML
python3 alexa_config_manager.py kubernetes

# Save to file
python3 alexa_config_manager.py kubernetes > deployment.yaml
```

### Generate OPA Policies

```bash
# View policy definitions
python3 alexa_config_manager.py opa

# Creates policy files for:
# - require-encryption.rego
# - require-https.rego
# - require-labels.rego
# - require-resource-limits.rego
# - security-hardening.rego
```

---

## 🧪 Testing

### Health Check

```bash
curl http://localhost:5000/api/v1/health

# Expected: {"status": "operational", ...}
```

### Create Test Mission

```bash
curl -X POST http://localhost:5000/api/v1/missions \
  -H "Content-Type: application/json" \
  -d '{"name": "test-mission"}'

# Expected: {"id": "abc123", "name": "test-mission", ...}
```

### Test Guacamole Integration

```bash
curl http://localhost:5000/api/v1/guacamole/status

# Expected: {"status": "operational", "active_sessions": 0, ...}
```

---

## 🐛 Troubleshooting

### Problem: "Port 5000 already in use"

**Solution**:
```bash
# Find process using port
lsof -i :5000

# Kill it
kill -9 <PID>

# Or use alternative port
export ALEXA_API_PORT=5001
./start_alexa.sh
```

### Problem: "ModuleNotFoundError: No module named 'flask'"

**Solution**:
```bash
pip install -r alexa_requirements.txt
```

### Problem: "ChapelXVI vault sealed"

**Solution**:
```bash
# ChapelXVI starts sealed for security
# Unseal via: python3 chapel_xvi_vault.py --unseal
# Or use UI: Settings → Vault → Unseal
```

### Problem: "Guacamole bridge connection refused"

**Solution**:
```bash
# Check if guacd is running
nc -zv localhost 4822

# Check bridge configuration
cat config/guacamole.json

# Verify both are on same network
docker network ls
```

---

## 📚 File Structure

```
porta-mundi/
├── alexa_portal.html              # Web UI dashboard
├── alexa_api.py                   # REST API + WebSocket
├── alexa_guacamole_bridge.py      # Secure Guacamole gateway
├── alexa_config_manager.py        # Configuration management
├── start_alexa.sh                 # Startup script
├── alexa_requirements.txt          # Python dependencies
├── config/                         # Configuration directory
│   ├── terraform.json
│   ├── docker.json
│   ├── kubernetes.json
│   ├── opa.json
│   └── guacamole.json
├── ALEXA_CONVERSION.md            # Conversion documentation
├── ALEXA_README.md                # This file
├── cyber_gate_manifest.json       # Porta-Mundi module registry
├── cyber-gate.log                 # Main log file
├── alexa-api.log                  # API server log
├── guacamole-bridge.log           # Bridge log
├── audit-logs.json                # Session audit trail
└── Alexa/                         # Legacy Alexa files (archived)
    └── ...
```

---

## 🔄 Integration Workflow

```
┌─────────────────────────────────────────┐
│  User Opens Web Portal (alexa_portal)   │
│  http://localhost:8086                  │
└──────────────┬──────────────────────────┘
               │ HTTP + WebSocket
┌──────────────▼──────────────────────────┐
│    Alexa API (alexa_api.py)             │
│    - Validates via Zangetsu             │
│    - Retrieves creds from ChapelXVI     │
│    - Orchestrates infrastructure        │
└──────────────┬──────────────────────────┘
               │ Secured execution
┌──────────────▼──────────────────────────┐
│   Infrastructure Components             │
│   - Terraform                           │
│   - Docker                              │
│   - Kubernetes                          │
│   - OPA Policies                        │
└──────────────┬──────────────────────────┘
               │ Session creation
┌──────────────▼──────────────────────────┐
│  Guacamole Bridge (alexa_guacamole)     │
│  - Audit logs to audit-logs.json        │
│  - Block via Minotaure                  │
│  - Monitor via Phoenix                  │
└─────────────────────────────────────────┘
```

---

## 🎯 Next Steps

### 1. Deploy Your First Infrastructure

```bash
# Start Alexa
./start_alexa.sh

# Open portal
open http://localhost:8086/alexa_portal.html

# Create mission
Click "New Mission" → Name: "deploy-infrastructure"

# Execute
Click "Execute Mission"

# Monitor
Watch logs in "Active Deployments" tab
```

### 2. Configure Remote Access

1. Verify Guacamole connections in settings
2. Add new connection for your server
3. Store credentials in ChapelXVI
4. Test SSH/RDP via Guacamole gateway

### 3. Set Up Custom OPA Policies

1. Edit `config/opa.json`
2. Generate policies: `python3 alexa_config_manager.py opa`
3. Deploy to OPA engine
4. Validate infrastructure automatically

### 4. Automate with Missions

1. Create mission templates
2. Schedule missions (hourly/daily)
3. Chain missions (deploy → test → monitor)
4. Set up alerts on failures

---

## 📞 Support & Documentation

### Documentation Files
- **Conversion Details**: `ALEXA_CONVERSION.md`
- **Porta-Mundi Guide**: `CLAUDE.md`
- **ADAM Framework**: `/home/ichigo/alexandria/ADAM/CLAUDE.md`
- **Alexandria Master**: `/home/ichigo/alexandria/CLAUDE.md`

### Log Files
```bash
tail -f /home/ichigo/alexandria/ADAM/porta-mundi/alexa-api.log
tail -f /home/ichigo/alexandria/ADAM/porta-mundi/guacamole-bridge.log
grep ALEXA /home/ichigo/alexandria/ADAM/porta-mundi/cyber-gate.log
```

### API Documentation
```bash
# View all endpoints
curl http://localhost:5000/api/v1/

# Swagger/OpenAPI (if available)
curl http://localhost:5000/api/v1/docs
```

---

## ✨ Key Features Recap

✅ **Infrastructure Orchestration**
- Terraform, Docker, Kubernetes, OPA

✅ **Mission Scheduling**
- Define complex workflows
- Monitor in real-time
- Automatic retries

✅ **Secure Remote Access**
- RDP, SSH, VNC via Guacamole
- Zangetsu access control
- ChapelXVI credentials
- Full audit trail

✅ **Security Integration**
- Zero-trust model (Zangetsu)
- Encrypted vault (ChapelXVI)
- Threat detection (Minotaure)
- Compliance logging

✅ **Configuration Management**
- Unified central config
- Dynamic variable updates
- Infrastructure templates
- Policy generation

---

## 🎉 You're Ready!

Your **Alexa Infrastructure Orchestration** system is now:

- ✅ **Fully Integrated** with Porta-Mundi
- ✅ **Secure** with white-hat constraints
- ✅ **Production Ready** with audit logging
- ✅ **Scalable** via Kubernetes orchestration
- ✅ **Compliant** with comprehensive auditing

**Start Building! 🚀**

```bash
./start_alexa.sh
```

---

**Created**: February 6, 2026
**Version**: 2.0.0 (Porta-Mundi Edition)
**Architect**: Michael Lefebvre
**Status**: 🟢 OPERATIONAL

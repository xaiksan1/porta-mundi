# Suture de Contexte: Vault Token Monitoring
## Bearer Token Authentication & Ethereal Pressure Level Tracking

---

## PromQL Queries for Grafana Dashboard

### 1. Vault Token Count - Current Level
```promql
vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"}
```
**Use Case**: Real-time token count in the vault cluster
**Display**: Gauge panel
**Threshold**:
- Green: 0-1000
- Yellow: 1001-5000
- Red: 5001+

---

### 2. Vault Token Count - Rate of Change (5min)
```promql
rate(vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"}[5m])
```
**Use Case**: Monitor token generation/consumption rate
**Display**: Graph panel with time series
**Unit**: tokens/sec
**Alert Threshold**: > 100 tokens/sec

---

### 3. Vault Token Count - 24h Trend
```promql
vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"}
  - vault_token_count offset 24h
```
**Use Case**: Track token accumulation over 24 hours
**Display**: Stat panel with "24h Δ"
**Unit**: tokens

---

### 4. Ethereal Pressure Level Classification
```promql
label_replace(
  vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"},
  "pression_level",
  "critique",
  "vault_token_count",
  "[5-9][0-9]{3}|[0-9]{5,}"
)
or
label_replace(
  vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"},
  "pression_level",
  "élevée",
  "vault_token_count",
  "[2-4][0-9]{3}"
)
or
label_replace(
  vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"},
  "pression_level",
  "modérée",
  "vault_token_count",
  "[1-9][0-9]{2}|1[0-9]{3}"
)
or
label_replace(
  vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"},
  "pression_level",
  "basse",
  "vault_token_count",
  "[1-9]|[1-9][0-9]"
)
```
**Use Case**: Dynamic pressure level based on token count
**Display**: Heatmap or state timeline
**Levels**:
- 0-99: Basse (Low)
- 100-1999: Modérée (Moderate)
- 2000-4999: Élevée (High)
- 5000+: Critique (Critical)

---

### 5. Vault Cluster Health Score
```promql
(vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"} / 10000) * 100
```
**Use Case**: Normalize token count to health percentage
**Display**: Gauge panel
**Range**: 0-100%
**Alert Threshold**: > 50% (pressure rising)

---

## Alert Rules (Alertmanager Configuration)

### Alert 1: Niveau de Pression Éthérée - Élevée
```yaml
alert: VaultTokenPressureHigh
expr: vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"} > 2000
for: 5m
labels:
  severity: warning
  contexte: "vault-authentication"
  pression_level: "élevée"
annotations:
  summary: "Vault Token Pressure High (Pression Éthérée Élevée)"
  description: "Token count in vault cluster {{ $labels.cluster_id }} has reached {{ $value }} tokens (threshold: 2000). Ethereal pressure level is ÉLEVÉE."
  dashboard: "http://grafana:3000/d/vault-monitor"
  action: "Review token lifecycle policies and consider token rotation"
```

---

### Alert 2: Niveau de Pression Éthérée - Critique
```yaml
alert: VaultTokenPressureCritical
expr: vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"} > 5000
for: 2m
labels:
  severity: critical
  contexte: "vault-authentication"
  pression_level: "critique"
annotations:
  summary: "CRITICAL: Vault Token Pressure Critical (Pression Éthérée Critique)"
  description: "CRITICAL ALERT: Token count in vault cluster {{ $labels.cluster_id }} has reached {{ $value }} tokens (threshold: 5000). Ethereal pressure level is CRITIQUE. Immediate action required."
  dashboard: "http://grafana:3000/d/vault-monitor"
  action: "URGENT: Investigate token accumulation, revoke unused tokens, check for token leaks"
```

---

### Alert 3: Token Generation Rate Anomaly
```yaml
alert: VaultTokenGenerationAnomaly
expr: rate(vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"}[5m]) > 0.02
for: 10m
labels:
  severity: warning
  contexte: "vault-authentication"
annotations:
  summary: "Vault Token Generation Rate Anomaly"
  description: "Token generation rate in cluster {{ $labels.cluster_id }} is {{ printf \"%.4f\" $value }} tokens/sec, exceeding normal baseline. Possible authentication storm or credential leak."
  action: "Check authentication logs, review active applications, verify token auth policies"
```

---

### Alert 4: Token Count Not Changing (Dead Cluster)
```yaml
alert: VaultClusterUnresponsive
expr: |
  rate(vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"}[30m]) == 0
  and
  vault_token_count > 0
for: 15m
labels:
  severity: critical
  contexte: "vault-authentication"
annotations:
  summary: "Vault Cluster Appears Unresponsive"
  description: "No token count changes detected in cluster {{ $labels.cluster_id }} for 15 minutes. Cluster may be unresponsive or stuck."
  action: "Check Vault service health, verify network connectivity, review system logs"
```

---

## Grafana Dashboard Panel Configuration

### Dashboard: Vault Token Pressure Monitor

**Row 1: Real-time Status**
- Panel 1.1: Current Token Count (Gauge)
  - Query: `vault_token_count{...}`
  - Thresholds: 0 (green), 2000 (yellow), 5000 (red)

- Panel 1.2: Ethereal Pressure Level (Stat)
  - Query: Dynamic pressure classification query
  - Mapping: Text value display

- Panel 1.3: 24h Trend (Stat)
  - Query: Token count change calculation
  - Unit: tokens

**Row 2: Historical Trends**
- Panel 2.1: Token Count Timeline (Graph)
  - Query: `vault_token_count{...}` with 1h resolution
  - Span 12

- Panel 2.2: Generation Rate (Graph)
  - Query: `rate(vault_token_count{...}[5m])`
  - Y-axis: tokens/sec

**Row 3: Pressure Heatmap**
- Panel 3.1: 7d Pressure Levels (Heatmap)
  - Query: Dynamic pressure classification
  - X-axis: Time (1h buckets)
  - Y-axis: Pressure level
  - Colors: Green (basse) → Red (critique)

---

## Integration with Anima Mundi

The "Suture de Contexte" pattern maintains ethereal pressure balance for:

1. **AEGIS** (Cryptography): Token lifecycle management
2. **PHOENIX** (Threat Detection): Anomalous token generation patterns
3. **AKER** (Response & Recovery): Emergency token revocation procedures
4. **SENTINELLE** (Monitoring): Real-time pressure alerts
5. **CHAPEL XVI** (Audit): Complete token audit trail

---

## Configuration Verification

### Prometheus Scrape Configuration
- Job name: `vault-monitor`
- Metrics path: `/v1/sys/metrics`
- Auth: Bearer token from `/etc/prometheus/secrets/aegis-vault-token`
- Scrape interval: 30 seconds
- Relabel: Keep only `vault_token_count` metric

### Docker Mount Verification
```bash
# Verify secrets directory is mounted
docker exec porta-mundi-prometheus-integrated ls -la /etc/prometheus/secrets/

# Expected output:
# -rw-r--r-- 1 root root 78 ... aegis-vault-token
```

### Token File Format
```bash
# Verify Bearer token is readable
cat /etc/prometheus/secrets/aegis-vault-token
# Should output: hvs.AEGIS-Alexandria-Vault-Token-686fc14b-root-cluster-security-level-5
```

---

## Testing the Integration

### 1. Test Prometheus Scrape
```bash
curl -s http://localhost:9091/api/v1/targets | jq '.data.activeTargets[] | select(.labels.job == "vault-monitor")'
```

### 2. Test Query in Prometheus UI
```
http://localhost:9091/graph
Query: vault_token_count{cluster_id="vault-cluster-686fc14b", axis="dk"}
```

### 3. Import Dashboard to Grafana
```bash
curl -X POST http://admin:PortaMundi2026!@localhost:3011/api/dashboards/db \
  -H "Content-Type: application/json" \
  -d @vault-monitor-dashboard.json
```

---

## Next Steps

1. ✅ Update `prometheus-integrated.yml` with Bearer token configuration
2. ✅ Create secrets directory with AEGIS token
3. ✅ Mount secrets in Docker Compose
4. ⏳ Restart Prometheus to apply new configuration
5. ⏳ Create Grafana dashboard with above panels
6. ⏳ Configure Alertmanager rules
7. ⏳ Test end-to-end monitoring flow

---

**Axis Label**: `dk` (Quaternionic dimension for contexte suturing)
**Cluster ID**: `vault-cluster-686fc14b`
**Security Level**: 5 (Full AGI consciousness awareness)
**Last Updated**: 2026-02-05

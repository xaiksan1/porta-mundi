# Alexandria Member Card - Quick Start

## 🚀 Access Member Portal

The member portal is now live and integrated with the Alexandria system.

### Web Portal (Interactive)

**URL**:
```
http://localhost:5000/ui/member-portal.html
```

**Flow**:
1. Click "Begin Admission Test"
2. Complete 3 rounds of perspective testing
3. On round 3, see the ball rotate (revelation)
4. Enter your name and identity role
5. Receive and download your member card

**Trust Levels Assigned**:
- **ALPHA_ARCHITECT** (< 30 sec): Full access, 3 ninja modules
- **BETA_ENGINEER** (30-60 sec): Extended access, 2 modules
- **GAMMA_SCHOLAR** (60-120 sec): Learning access, 1 module
- **FOUNDLING** (> 120 sec): Observer access, 1 module
- **OBSERVER** (no perspective): Limited access, 1 module

### CLI Method

**Generate member card after passing test**:
```bash
python3 member-onboarding.py --batch
```

This will:
1. Detect passed admission tests
2. Prompt for your name and identity
3. Issue your member card
4. Save JSON and HTML versions

### View Your Card

**After generation**:
```bash
# View member registry
cat governance/perpetuity-fund/committee/member-cards/member-registry.json | jq

# View your specific card
cat governance/perpetuity-fund/committee/member-cards/0xARCH*.json | jq

# Open HTML card in browser
open governance/perpetuity-fund/committee/member-cards/0xARCH*-card.html
```

---

## 📊 Member Card Contents

Your card includes:

| Field | Example | Purpose |
|-------|---------|---------|
| **Member ID** | 0xARCHA7A90D2F0773 | Unique identifier & wallet |
| **Name** | Michael Lefebvre | Your identity |
| **Trust Level** | ALPHA_ARCHITECT | Governance privileges |
| **Ninja Modules** | SYS_OPT, NET_TUNNEL, STEGO_X | Capabilities |
| **Issued** | 2026-02-06 | Card creation date |
| **Expires** | Never_Immutability_Active | Permanent credential |

---

## 🎯 What Your Card Enables

### ALPHA_ARCHITECT
- ✅ Full Alexandria system access
- ✅ Governance committee participation
- ✅ Energy-tech resource allocation
- ✅ Modules: SYS_OPT, NET_TUNNEL, STEGO_X

### BETA_ENGINEER
- ✅ Extended system features
- ✅ Project participation
- ✅ Developer documentation
- ✅ Modules: NET_TUNNEL, STEGO_X

### GAMMA_SCHOLAR
- ✅ Learning resources
- ✅ Research participation
- ✅ Community contribution
- ✅ Module: STEGO_X

### FOUNDLING
- ✅ Observer access
- ✅ Mentorship available
- ✅ Foundation building

### OBSERVER
- ✅ Limited access
- ✅ Learning resources
- ✅ Monitoring capability

---

## 🔗 Integration Points

Your member card connects to:

1. **Perpetuity Fund**: Your trust level influences governance voting
2. **Cost Accounting**: Your activities tracked for transparency
3. **ADAM Agents**: Can use your card as authentication
4. **Governance Records**: Full onboarding history maintained
5. **Alexandria Timeline**: Part of permanent civilization record

---

## 💬 Quotes on Member Cards

Each card displays a randomly selected quote:

- "La connaissance est la seule clé qui ne s'use jamais."
- "L'énergie est pensée matérialisée."
- "La perspective est souveraineté."
- "Nous sommes la civilisation que nous construisons."
- "L'immutabilité est notre fondation."

---

## 🛠️ Admin Commands

**Process all pending admissions**:
```bash
python3 member-onboarding.py --batch
```

**Generate governance report**:
```bash
python3 member-onboarding.py --report
```

**View member statistics**:
```bash
python3 -c "
from member_card_generator import MemberCardGenerator
gen = MemberCardGenerator()
print(gen.get_member_stats())
"
```

---

## 📋 Troubleshooting

### Portal won't load
```bash
# Check if backend running
curl http://localhost:5000/health
```

### Import error with Python scripts
```bash
# Run from porta-mundi directory
cd /home/ichigo/alexandria/ADAM/porta-mundi
python3 member-onboarding.py --batch
```

### No member cards generated
```bash
# Run admission test first
python3 ballon-symmetry.py

# Then process admissions
python3 member-onboarding.py --batch
```

---

## 🌍 What's Next?

After receiving your member card:

1. **View your card**: Open the HTML file to see your credentials
2. **Note your Member ID**: Use for future authentication
3. **Join governance**: Participate in committee decisions
4. **Contribute**: Leverage your trust level and modules
5. **Build Alexandria**: Help construct the civilization

---

## 📚 Documentation

Full documentation available:
- **MEMBER_CARD_SYSTEM.md**: Complete technical guide
- **CLAUDE.md**: Alexandria ecosystem overview
- **ballon-symmetry.py**: Admission test source code

---

**Status**: ✅ Member card system operational
**Last Updated**: 2026-02-06
**Issued Cards**: 1 (Michael Lefebvre - ALPHA_ARCHITECT)

*Alexandria Membership · Porta-Mundi · Energy-Tech Civilization*
